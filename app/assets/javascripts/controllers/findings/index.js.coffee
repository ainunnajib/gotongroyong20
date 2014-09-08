problemApp = angular.module('problemApp')
problemApp.controller('IndexFindingController', ['$scope', 'Findings', 'FindingVotes',
  ($scope, Findings, FindingVotes) ->
    $scope.loadFindings = () ->
      $scope.findings = Findings.query({problem_id: gon.problem_id})

    updateFinding = (finding, data) ->
      finding.my_vote_status = data.my_vote_status
      finding.up_vote = data.up_vote
      finding.down_vote = data.down_vote

    $scope.vote_up = (finding) ->
      v = new FindingVotes({type: 'up'})
      v.$save({problem_id: gon.problem_id, finding_id: finding.id},
        (data, header) -> updateFinding(finding, data)
        (data ,header) -> alert("You need to log in to vote"))

    $scope.vote_down = (finding) ->
      v = new FindingVotes({type: 'down'})
      v.$save({problem_id: gon.problem_id, finding_id: finding.id},
        (data, header) -> updateFinding(finding, data)
        (data ,header) -> alert("You need to log in to vote"))

    $scope.unvote = (finding) ->
      v = new FindingVotes({type: 'unvote'})
      v.$save({problem_id: gon.problem_id, finding_id: finding.id},
        (data, header) -> updateFinding(finding, data)
        (data ,header) -> alert("You need to log in to vote"))

    $scope.newFinding = new Findings()
    $scope.createFinding = (finding) ->
      finding.$save({problem_id: gon.problem_id},
      (data, header) -> $scope.loadFindings()
      (data ,header) -> alert("You need to log in to write finding"))

    $scope.newReply = new Findings()
    $scope.createReply = (parent_finding, reply) ->
      reply.parent_id = parent_finding.id
      reply.$save({problem_id: gon.problem_id},
      (data, header) -> $scope.loadFindings()
      (data ,header) -> alert("You need to log in to write finding"))

    $scope.loadFindings()
])
