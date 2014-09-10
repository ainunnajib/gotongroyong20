locationServices = angular.module('locationServices', ['ngResource'])
locationServices.factory "Provinces",
  ["$resource", ($resource) -> return $resource("/api/v1/locations",{},
  {
    'query': {method: 'GET', isArray:true, cache:true}
  })]
locationServices.factory "Kabupatens",
  ["$resource", ($resource) -> return $resource("/api/v1/locations/:province_id",{},
  {
    'query': {method: 'GET', isArray:true, cache:true}
  })]
locationServices.factory "Kecamatans",
  ["$resource", ($resource) -> return $resource("/api/v1/locations/:province_id/:kabupaten_id",{},
  {
    'query': {method: 'GET', isArray:true, cache:true}
  })]
locationServices.factory "Kelurahans",
  ["$resource", ($resource) -> return $resource("/api/v1/locations/:province_id/:kabupaten_id/:kecamatan_id",{},
  {
    'query': {method: 'GET', isArray:true, cache:true}
  })]

problemServices = angular.module('problemServices', ['ngResource'])
problemServices.factory "Map",
  ["$resource", ($resource) -> return $resource("/api/v1/problems/maps")]
problemServices.factory "Problems",
  ["$resource", ($resource) -> return $resource("/api/v1/problems/details/:id", {},
    {
      'query': {method:'GET', isArray:false},
    }
  )]
problemServices.factory "Categories",
  ["$resource", ($resource) -> return $resource("/api/v1/problems/categories")]

problemServices.factory "Findings",
  ["$resource", ($resource) -> return $resource("/api/v1/problems/details/:problem_id/findings/:finding_id")]

voteServices = angular.module('voteServices', ['ngResource'])
voteServices.factory "ProblemVotes",
  ["$resource", ($resource) -> return $resource("/api/v1/problems/details/:problem_id/votes/", {},
    {
      'query': {method:'GET', isArray:false},
    }
  )]
voteServices.factory "FindingVotes",
  ["$resource", ($resource) -> return $resource("/api/v1/problems/details/:problem_id/findings/:finding_id/votes/", {},
    {
      'query': {method:'GET', isArray:false},
    }
  )]