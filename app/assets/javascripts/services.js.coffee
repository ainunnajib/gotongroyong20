locationServices = angular.module('locationServices', ['ngResource'])
locationServices.factory "Provinces",
  ["$resource", ($resource) -> return $resource("/locations")]
locationServices.factory "Kabupatens",
  ["$resource", ($resource) -> return $resource("/locations/:province_id")]
locationServices.factory "Kecamatans",
  ["$resource", ($resource) -> return $resource("/locations/:province_id/:kabupaten_id")]