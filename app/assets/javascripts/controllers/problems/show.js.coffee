problemApp = angular.module('problemApp')
problemApp.controller('ShowProblemController', ['$scope', '$location', 'Map', 'Problems', 'Categories', 'ProblemVotes', 'Findings',
  ($scope, $location, Map, Problems, Categories, ProblemVotes, Findings) ->
    $scope.vote = ProblemVotes.query({problem_id: gon.problem_id})
    $scope.problem = Problems.get({id: gon.problem_id})
    $scope.selected_tab = 0

    $scope.vote_up = () ->
      v = new ProblemVotes({type: 'up'})
      v.$save({problem_id: gon.problem_id}, (data, header) -> $scope.vote = data)

    $scope.vote_down = () ->
      v = new ProblemVotes({type: 'down'})
      v.$save({problem_id: gon.problem_id}, (data, header) -> $scope.vote = data)

    $scope.unvote = () ->
      v = new ProblemVotes({type: 'unvote'})
      v.$save({problem_id: gon.problem_id}, (data, header) -> $scope.vote = data)

    $scope.showFindings = () ->
      $scope.selected_tab = 0
      $scope.findings = Findings.query({problem_id: gon.problem_id})

    $scope.showBrainstorms = () ->
      $scope.selected_tab = 1

    $scope.showVolunteers = () ->
      $scope.selected_tab = 2

    $scope.showFundings = () ->
      $scope.selected_tab = 3

    $scope.createFinding = (finding) ->
      finding.$save({problem_id: gon.problem_id},
        (data, header) -> $scope.showFindings())

    $scope.newFinding = new Findings()
    $scope.showFindings()
])