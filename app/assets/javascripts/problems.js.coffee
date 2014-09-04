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

problemApp.controller('IndexProblemController', ['$scope', 'Provinces', 'Kabupatens', 'Kecamatans', 'Map', 'Problems',
  ($scope, Provinces, Kabupatens, Kecamatans, Map, Problems) ->
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

    $scope.problems = Map.query({},
      (data, header) ->
        $scope.initialize()
    )

    $scope.fetchPrevPage = () ->
      $scope.fetchProblems($scope.current_page - 1)

    $scope.fetchNextPage = () ->
      $scope.fetchProblems($scope.current_page + 1)

    $scope.fetchProblems = (page) ->
      Problems.query({page:page},
        (data, header) ->
          $scope.detailedProblems = data.problems
          $scope.current_page = data.current_page
          $scope.total_pages = data.total_pages
        )

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

    $scope.provinces = Provinces.query()
    $scope.fetchProblems(1)
])