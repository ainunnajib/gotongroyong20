problemApp = angular.module('problemApp')
problemApp.controller('IndexProblemController', ['$scope', '$location', 'Provinces', 'Kabupatens', 'Kecamatans', 'Kelurahans', 'Map', 'Problems', 'Categories',
  ($scope, $location, Provinces, Kabupatens, Kecamatans, Kelurahans, Map, Problems, Categories) ->
    
    vm = this
    
    mapProblems = []
    indonesia = new google.maps.LatLng(0,  120.644)
    marker = undefined
    map = undefined
    
    fetchDetailedProblems = (page, filter) ->
      extractedFilter = extractFilter(filter)

      Problems.query({page: page, province_id: extractedFilter.province_id
        , kabupaten_id: extractedFilter.kabupaten_id , kecamatan_id: extractedFilter.kecamatan_id, kelurahan_id: extractedFilter.kelurahan_id
        , category_id: extractedFilter.category_id},
      (data, header) ->
        vm.detailedProblems = data.problems
        vm.current_page = data.current_page
        vm.total_pages = data.total_pages
      )

    fetchMapProblems = (filter) ->
      extractedFilter = extractFilter(filter)

      mapProblems = Map.query({province_id: extractedFilter.province_id
        , kabupaten_id: extractedFilter.kabupaten_id , kecamatan_id: extractedFilter.kecamatan_id, kelurahan_id: extractedFilter.kelurahan_id
        , category_id: extractedFilter.category_id},
      (data, header) ->
        initialize()
      )

    initialize = ->
      mapOptions =
        zoom: 4
        center: indonesia

      map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

      markers = []
      for problem in mapProblems
        marker = new google.maps.Marker(
          animation: google.maps.Animation.DROP
          position: new google.maps.LatLng(problem.latitude, problem.longitude)
        )
        markers.push(marker)
      markerCluster = new MarkerClusterer(map, markers)

      return

    toggleBounce = ->
      if marker.getAnimation()?
        marker.setAnimation null
      else
        marker.setAnimation google.maps.Animation.BOUNCE
      return        

    extractFilter = (filter) ->
      province_id: if filter.province.id == -1 then undefined else filter.province.id
      kabupaten_id: if filter.kabupaten.id == -1 then undefined else filter.kabupaten.id
      kecamatan_id: if filter.kecamatan.id == -1 then undefined else filter.kecamatan.id
      kelurahan_id: if filter.kelurahan.id == -1 then undefined else filter.kelurahan.id
      category_id: if filter.category.id == -1 then undefined  else filter.category.id

    updateUrl = (page, filter) ->
      extractedFilter = extractFilter(filter)
      url_params = {}
      for k, v of extractedFilter
        if v == undefined
          $location.search(k, null)
        else
          url_params[k] = v
      if page != 1
        url_params['page'] = page
      $location.search(url_params)
    
    prependAll = (data) -> [{name: 'ALL', id: -1}].concat(data)

    vm.filter =
      province: {id: -1} #all
      kabupaten: {id: -1} #all
      kecamatan: {id: -1} #all
      kelurahan: {id: -1} #all
      category: {id: -1} #all

    vm.current_page = 1

    vm.fetchPrevPage = () ->
      updateUrl(vm.current_page - 1, vm.filter)

    vm.fetchNextPage = () ->
      updateUrl(vm.current_page + 1, vm.filter)

    vm.filterProblems = (filter) ->
      updateUrl(1, filter)

    vm.getKabupatens = (province) ->
      if province
        vm.filter.kabupaten.id = -1
        vm.filter.kecamatan.id = -1
        vm.filter.kelurahan.id = -1
        vm.kabupatens = prependAll([])
        vm.kecamatans = prependAll([])
        vm.kelurahans = prependAll([])
        Kabupatens.query({province_id: province.id},
        (data, header) -> vm.kabupatens = prependAll(data)
        )

    vm.getKecamatans = (province, kabupaten) ->
      if kabupaten and province
        vm.kecamatans = prependAll([])
        vm.kelurahans = prependAll([])
        vm.filter.kecamatan.id = -1
        vm.filter.kelurahan.id = -1
        Kecamatans.query({province_id: province.id, kabupaten_id: kabupaten.id},
        (data, header) -> vm.kecamatans = prependAll(data)
        )

    vm.getKelurahans = (province, kabupaten, kecamatan) ->
      if kecamatan and kabupaten and province
        vm.kelurahans = []
        vm.filter.kelurahan.id = -1
        Kelurahans.query({province_id: province.id, kabupaten_id: kabupaten.id, kecamatan_id: kecamatan.id},
        (data, header) -> vm.kelurahans = prependAll(data)
        )

    $scope.$on('$locationChangeSuccess',
    (event) ->
      params = $location.search()
      old_current_page = vm.current_page

      if params.page
        vm.current_page = parseInt(params.page)
      else
        vm.current_page = 1
      if params.province_id
        vm.filter.province.id = parseInt(params.province_id)
        vm.getKabupatens(vm.filter.province)
      if params.kabupaten_id
        vm.filter.kabupaten.id = parseInt(params.kabupaten_id)
        vm.getKecamatans(vm.filter.province, vm.filter.kabupaten)
      if params.kecamatan_id
        vm.filter.kecamatan.id = parseInt(params.kecamatan_id)
        vm.getKelurahans(vm.filter.province, vm.filter.kabupaten, vm.filter.kecamatan)
      if params.kelurahan_id then vm.filter.kelurahan.id = parseInt(params.kelurahan_id)

      # Don't reload map if it is only page change
      if (old_current_page == vm.current_page)
        fetchMapProblems(vm.filter)

      fetchDetailedProblems(vm.current_page, vm.filter)
    )

    Provinces.query({},
    (data, header) ->
      vm.provinces = prependAll(data)
      vm.kabupatens = prependAll([])
      vm.kecamatans = prependAll([])
      vm.kelurahans = prependAll([])
    )
    Categories.query({},
    (data, header) ->
      vm.categories = prependAll(data)
    )
    
    return vm
])
