problemApp = angular.module('problemApp')
problemApp.controller('IndexProblemController', ['$scope', '$location', 'Provinces', 'Kabupatens', 'Kecamatans', 'Kelurahans', 'Map', 'Problems', 'Categories',
  ($scope, $location, Provinces, Kabupatens, Kecamatans, Kelurahans, Map, Problems, Categories) ->
    $scope.initialize = ->
      mapOptions =
        zoom: 4
        center: indonesia

      map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

      markers = []
      for problem in $scope.mapProblems
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

    indonesia = new google.maps.LatLng(0,  120.644)
    marker = undefined
    map = undefined

    prependAll = (data) -> [{name: 'ALL', id: -1}].concat(data)

    extractFilter = (filter) ->
      province_id: if filter.province.id == -1 then undefined else filter.province.id
      kabupaten_id: if filter.kabupaten.id == -1 then undefined else filter.kabupaten.id
      kecamatan_id: if filter.kecamatan.id == -1 then undefined else filter.kecamatan.id
      kelurahan_id: if filter.kelurahan.id == -1 then undefined else filter.kelurahan.id
      category_id: if filter.category.id == -1 then undefined  else filter.category.id

    $scope.updateUrl = (page, filter) ->
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

    $scope.fetchMapProblems = (filter) ->
      extractedFilter = extractFilter(filter)

      $scope.mapProblems = Map.query({province_id: extractedFilter.province_id
        , kabupaten_id: extractedFilter.kabupaten_id , kecamatan_id: extractedFilter.kecamatan_id, kelurahan_id: extractedFilter.kelurahan_id
        , category_id: extractedFilter.category_id},
      (data, header) ->
        $scope.initialize()
      )

    $scope.fetchPrevPage = () ->
      $scope.updateUrl($scope.current_page - 1, $scope.filter)

    $scope.fetchNextPage = () ->
      $scope.updateUrl($scope.current_page + 1, $scope.filter)

    $scope.fetchDetailedProblems = (page, filter) ->
      extractedFilter = extractFilter(filter)

      Problems.query({page: page, province_id: extractedFilter.province_id
        , kabupaten_id: extractedFilter.kabupaten_id , kecamatan_id: extractedFilter.kecamatan_id, kelurahan_id: extractedFilter.kelurahan_id
        , category_id: extractedFilter.category_id},
      (data, header) ->
        $scope.detailedProblems = data.problems
        $scope.current_page = data.current_page
        $scope.total_pages = data.total_pages
      )

    $scope.filterProblems = (filter) ->
      $scope.updateUrl(1, filter)

    $scope.getKabupatens = (province) ->
      if province
        $scope.filter.kabupaten.id = -1
        $scope.filter.kecamatan.id = -1
        $scope.filter.kelurahan.id = -1
        $scope.kabupatens = prependAll([])
        $scope.kecamatans = prependAll([])
        $scope.kelurahans = prependAll([])
        Kabupatens.query({province_id: province.id},
        (data, header) -> $scope.kabupatens = prependAll(data)
        )

    $scope.getKecamatans = (province, kabupaten) ->
      if kabupaten and province
        $scope.kecamatans = prependAll([])
        $scope.kelurahans = prependAll([])
        $scope.filter.kecamatan.id = -1
        $scope.filter.kelurahan.id = -1
        Kecamatans.query({province_id: province.id, kabupaten_id: kabupaten.id},
        (data, header) -> $scope.kecamatans = prependAll(data)
        )

    $scope.getKelurahans = (province, kabupaten, kecamatan) ->
      if kecamatan and kabupaten and province
        $scope.kelurahans = []
        $scope.filter.kelurahan.id = -1
        Kelurahans.query({province_id: province.id, kabupaten_id: kabupaten.id, kecamatan_id: kecamatan.id},
        (data, header) -> $scope.kelurahans = prependAll(data)
        )

    Provinces.query({},
    (data, header) ->
      $scope.provinces = prependAll(data)
      $scope.kabupatens = prependAll([])
      $scope.kecamatans = prependAll([])
      $scope.kelurahans = prependAll([])
    )
    Categories.query({},
    (data, header) ->
      $scope.categories = prependAll(data)
    )
    $scope.filter =
      province: {id: -1} #all
      kabupaten: {id: -1} #all
      kecamatan: {id: -1} #all
      kelurahan: {id: -1} #all
      category: {id: -1} #all

    $scope.current_page = 1

    $scope.$on('$locationChangeSuccess',
    (event) ->
      params = $location.search()
      if params.page
        $scope.current_page = parseInt(params.page)
      else
        $scope.current_page = 1
      if params.province_id
        $scope.filter.province.id = parseInt(params.province_id)
        $scope.getKabupatens($scope.filter.province)
      if params.kabupaten_id
        $scope.filter.kabupaten.id = parseInt(params.kabupaten_id)
        $scope.getKecamatans($scope.filter.province, $scope.filter.kabupaten)
      if params.kecamatan_id
        $scope.filter.kecamatan.id = parseInt(params.kecamatan_id)
        $scope.getKelurahans($scope.filter.province, $scope.filter.kabupaten, $scope.filter.kecamatan)
      if params.kelurahan_id then $scope.filter.kelurahan.id = parseInt(params.kelurahan_id)

      $scope.fetchMapProblems($scope.filter)
      $scope.fetchDetailedProblems($scope.current_page, $scope.filter)
    )
])
