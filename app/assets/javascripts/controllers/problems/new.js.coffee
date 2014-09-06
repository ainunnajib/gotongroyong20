problemApp = angular.module('problemApp')
problemApp.controller('NewProblemController', ['$scope', 'Provinces', 'Kabupatens', 'Kecamatans', 'Kelurahans',
  ($scope, Provinces, Kabupatens, Kecamatans, Kelurahans) ->
    $scope.provinces = Provinces.query()

    $scope.getKabupatens = (province) ->
      if province
        $scope.kabupatens = []
        $scope.kecamatans = []
        $scope.kelurahans = []
        Kabupatens.query({province_id: province.id},
        (data, header) -> $scope.kabupatens = data
        )

    $scope.getKecamatans = (province, kabupaten) ->
      if kabupaten and province
        $scope.kecamatans = []
        $scope.kelurahans = []
        Kecamatans.query({province_id: province.id, kabupaten_id: kabupaten.id},
        (data, header) -> $scope.kecamatans = data
        )

    $scope.getKelurahans = (province, kabupaten, kecamatan) ->
      if kecamatan and kabupaten and province
        $scope.kelurahans = []
        Kelurahans.query({province_id: province.id, kabupaten_id: kabupaten.id, kecamatan_id: kecamatan.id},
        (data, header) -> $scope.kelurahans = data
        )
])
