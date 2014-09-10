problemApp = angular.module('problemApp')
problemApp.controller('IndexFindingController', ['Findings', 'FindingVotes',
  (Findings, FindingVotes) ->
    updateFindingVote = (finding, data) ->
      finding.my_vote_status = data.my_vote_status
      finding.up_vote = data.up_vote
      finding.down_vote = data.down_vote
  
    vm = this
    vm.loadFindings = () ->
      vm.findings = Findings.query({problem_id: gon.problem_id})    

    vm.vote_up = (finding) ->
      v = new FindingVotes({type: 'up'})
      v.$save({problem_id: gon.problem_id, finding_id: finding.id},
        (data, header) -> updateFindingVote(finding, data)
        (data ,header) -> alert("You need to log in to vote"))

    vm.vote_down = (finding) ->
      v = new FindingVotes({type: 'down'})
      v.$save({problem_id: gon.problem_id, finding_id: finding.id},
        (data, header) -> updateFindingVote(finding, data)
        (data ,header) -> alert("You need to log in to vote"))

    vm.unvote = (finding) ->
      v = new FindingVotes({type: 'unvote'})
      v.$save({problem_id: gon.problem_id, finding_id: finding.id},
        (data, header) -> updateFindingVote(finding, data)
        (data ,header) -> alert("You need to log in to vote"))

    vm.newFinding = new Findings()
    vm.createFinding = (finding) ->
      finding.$save({problem_id: gon.problem_id},
      (data, header) -> vm.loadFindings()
      (data ,header) -> alert("You need to log in to write finding"))

    vm.newReply = new Findings()
    vm.createReply = (parent_finding, reply) ->
      reply.parent_id = parent_finding.id
      reply.$save({problem_id: gon.problem_id},
      (data, header) -> vm.loadFindings()
      (data ,header) -> alert("You need to log in to write finding"))

    vm.loadFindings()
    
    return vm
])
