# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

problemApp = angular.module('problemApp', ['locationServices'])
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