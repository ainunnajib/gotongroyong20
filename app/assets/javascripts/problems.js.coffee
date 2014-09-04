# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

problemApp = angular.module('problemApp', ['locationServices', 'problemServices'])
problemApp.controller('NewProblemController', ['$scope', 'Provinces', 'Kabupatens', 'Kecamatans',
  ($scope, Provinces, Kabupatens, Kecamatans) ->
    $scope.provinces = Provinces.query()

    $scope.getKabupatens = (province) ->
      if province
        $scope.kabupatens = []
        $scope.kecamatans = []
        Kabupatens.query({province_id: province.id},
          (data, header) -> $scope.kabupatens = data
    )

    $scope.getKecamatans = (province, kabupaten) ->
      if kabupaten and province
        $scope.kecamatans = []
        Kecamatans.query({province_id: province.id, kabupaten_id: kabupaten.id},
          (data, header) -> $scope.kecamatans = data
    )
])

problemApp.controller('IndexProblemController', ['$scope', 'Provinces', 'Kabupatens', 'Kecamatans', 'Map', 'Problems', 'Categories',
  ($scope, Provinces, Kabupatens, Kecamatans, Map, Problems, Categories) ->
    $scope.initialize = ->
      mapOptions =
        zoom: 4
        center: indonesia

      map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

      for problem in $scope.problems
        marker = new google.maps.Marker(
          map: map
          draggable: true
          animation: google.maps.Animation.DROP
          position: new google.maps.LatLng(problem.latitude, problem.longitude)
        )
        google.maps.event.addListener marker, "click", toggleBounce

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

    $scope.problems = Map.query({},
      (data, header) ->
        $scope.initialize()
    )

    $scope.fetchPrevPage = () ->
      $scope.fetchProblems($scope.current_page - 1, $scope.filter)

    $scope.fetchNextPage = () ->
      $scope.fetchProblems($scope.current_page + 1, $scope.filter)

    $scope.fetchProblems = (page, filter) ->
      console.log(filter)
      province_id = if filter.province.id == -1 then undefined else filter.province.id
      kabupaten_id = if filter.kabupaten.id == -1 then undefined else filter.kabupaten.id
      kecamatan_id = if filter.kecamatan.id == -1 then undefined else filter.kecamatan.id
      category_id = if filter.category.id == -1 then undefined  else filter.category.id

      Problems.query({page: page, province_id: province_id
        , kabupaten_id: kabupaten_id , kecamatan_id: kecamatan_id, category_id: category_id},
        (data, header) ->
          $scope.detailedProblems = data.problems
          $scope.current_page = data.current_page
          $scope.total_pages = data.total_pages
        )

    $scope.filterProblems = (filter) ->
      $scope.fetchProblems(1, filter)

    $scope.getKabupatens = (province) ->
      if province
        $scope.filter.kabupaten.id = -1
        $scope.filter.kecamatan.id = -1
        $scope.kabupatens = prependAll([])
        $scope.kecamatans = prependAll([])
        Kabupatens.query({province_id: province.id},
          (data, header) -> $scope.kabupatens = prependAll(data)
        )

    $scope.getKecamatans = (province, kabupaten) ->
      if kabupaten and province
        $scope.kecamatans = prependAll([])
        $scope.filter.kecamatan.id = -1
        Kecamatans.query({province_id: province.id, kabupaten_id: kabupaten.id},
          (data, header) ->
            $scope.kecamatans = prependAll(data)
        )

    Provinces.query({},
      (data, header) ->
        $scope.provinces = prependAll(data)
    )
    Categories.query({},
      (data, header) ->
        $scope.categories = prependAll(data)
    )
    $scope.filter =
      province: {id: -1} #all
      kabupaten: {id: -1} #all
      kecamatan: {id: -1} #all
      category: {id: -1} #all

    $scope.fetchProblems(1, $scope.filter)
])