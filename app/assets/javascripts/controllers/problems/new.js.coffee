problemApp = angular.module('problemApp')
problemApp.controller('NewProblemController', ['Provinces', 'Kabupatens', 'Kecamatans', 'Kelurahans',
  (Provinces, Kabupatens, Kecamatans, Kelurahans) ->
    vm = this

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

    vm.selectedProvince =
      id: gon.province_id;
    if vm.selectedProvince.id
      vm.getKabupatens()

    vm.selectedKabupaten =
      id: gon.kabupaten_id;
    if vm.selectedKabupaten.id
      vm.getKecamatans()

    vm.selectedKecamatan =
      id: gon.kecamatan_id;
    if vm.selectedKecamatan.id
      vm.getKelurahans()

    vm.selectedKelurahan =
      id: gon.kelurahan_id;

    vm.provinces = Provinces.query()

    return vm
])
