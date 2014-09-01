locationServices = angular.module('locationServices', ['ngResource'])
locationServices.factory "Provinces",
  ["$resource", ($resource) -> return $resource("/api/v1/locations")]
locationServices.factory "Kabupatens",
  ["$resource", ($resource) -> return $resource("/api/v1/locations/:province_id")]
locationServices.factory "Kecamatans",
  ["$resource", ($resource) -> return $resource("/api/v1/locations/:province_id/:kabupaten_id")]

problemServices = angular.module('problemServices', ['ngResource'])
problemServices.factory "Map",
  ["$resource", ($resource) -> return $resource("/api/v1/problems/maps")]