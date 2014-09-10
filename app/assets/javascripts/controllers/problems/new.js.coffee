problemApp = angular.module('problemApp')
problemApp.controller('NewProblemController', ['Provinces', 'Kabupatens', 'Kecamatans', 'Kelurahans',
  (Provinces, Kabupatens, Kecamatans, Kelurahans) ->
    vm = this

    vm.selectedProvince = null;
    vm.selectedKabupaten = null;
    vm.selectedKecamatan = null;
    vm.selectedKelurahan = null;
    
    vm.provinces = Provinces.query()

    vm.getKabupatens = () ->
      if vm.selectedProvince
        vm.kabupatens = []
        vm.kecamatans = []
        vm.kelurahans = []
        Kabupatens.query({province_id: vm.selectedProvince.id},
        (data, header) -> vm.kabupatens = data
        )

    vm.getKecamatans = () ->
      if vm.selectedKabupaten and vm.selectedProvince
        vm.kecamatans = []
        vm.kelurahans = []
        Kecamatans.query({province_id: vm.selectedProvince.id, kabupaten_id: vm.selectedKabupaten.id},
        (data, header) -> vm.kecamatans = data
        )

    vm.getKelurahans = () ->
      if vm.selectedKecamatan and vm.selectedKabupaten and vm.selectedProvince
        vm.kelurahans = []
        Kelurahans.query({province_id: vm.selectedProvince.id, kabupaten_id: vm.selectedKabupaten.id, kecamatan_id: vm.selectedKecamatan.id},
        (data, header) -> vm.kelurahans = data
        )
    
    return vm
])
