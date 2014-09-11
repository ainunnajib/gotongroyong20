problemApp = angular.module('problemApp')
problemApp.controller('ShowProblemController', ['$location', 'Map', 'Problems', 'Categories', 'ProblemVotes', 'Findings',
  ($location, Map, Problems, Categories, ProblemVotes, Findings) ->

    upInactiveImg = '/assets/up_inactive.png'
    upPressedImg = '/assets/up_pressed.png'
    downInactiveImg = '/assets/down_inactive.png'
    downPressedImg = '/assets/down_pressed.png'

    vm = this;
    vm.problem = Problems.get({id: gon.problem_id})
    vm.selected_tab = 0

    unvote = () ->
      v = new ProblemVotes({type: 'unvote'})
      v.$save({problem_id: gon.problem_id},
      (data, header) ->
        vm.vote = data
        vm.upStatusImage = upInactiveImg
        vm.downStatusImage = downInactiveImg
      (data ,header) -> alert("You need to log in to vote"))

    vm.vote_up = () ->
      if(vm.vote.my_vote_status == 'up')
        unvote()
      else
        v = new ProblemVotes({type: 'up'})
        v.$save({problem_id: gon.problem_id},
          (data, header) ->
            vm.vote = data
            vm.upStatusImage = upPressedImg
            vm.downStatusImage = downInactiveImg
          (data ,header) -> alert("You need to log in to vote"))

    vm.vote_down = () ->
      if(vm.vote.my_vote_status == 'down')
        unvote()
      else
        v = new ProblemVotes({type: 'down'})
        v.$save({problem_id: gon.problem_id},
          (data, header) ->
            vm.vote = data
            vm.upStatusImage = upInactiveImg
            vm.downStatusImage = downPressedImg
          (data ,header) -> alert("You need to log in to vote"))

    vm.showFindings = () ->
      vm.selected_tab = 0

    vm.showBrainstorms = () ->
      vm.selected_tab = 1

    vm.showVolunteers = () ->
      vm.selected_tab = 2

    vm.showFundings = () ->
      vm.selected_tab = 3

    ProblemVotes.query({problem_id: gon.problem_id},
    (data, header)->
      vm.vote = data

      if(vm.vote.my_vote_status == 'quo' || vm.vote.my_vote_status == 'not_available')
        vm.upStatusImage = upInactiveImg
        vm.downStatusImage = downInactiveImg
      else if(vm.vote.my_vote_status == 'up')
        vm.upStatusImage = upPressedImg
        vm.downStatusImage = downInactiveImg
      else if(vm.vote.my_vote_status == 'down')
        vm.upStatusImage = upInactiveImg
        vm.downStatusImage = downPressedImg
    )

    vm.showFindings()

    return vm
])