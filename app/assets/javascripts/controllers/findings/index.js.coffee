problemApp = angular.module('problemApp')
problemApp.controller('IndexFindingController', ['$scope', 'Findings',
  ($scope, Findings) ->
    $scope.loadFindings = () ->
      $scope.findings = Findings.query({problem_id: gon.problem_id})

    $scope.newFinding = new Findings()
    $scope.createFinding = (finding) ->
      finding.$save({problem_id: gon.problem_id},
      (data, header) -> $scope.loadFindings()
      (data ,header) -> alert("You need to log in to write finding"))

    $scope.loadFindings()
])
