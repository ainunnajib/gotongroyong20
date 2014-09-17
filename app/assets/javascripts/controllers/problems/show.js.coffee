problemApp = angular.module('problemApp')
problemApp.controller('ShowProblemController', ['$location', '$sce', 'Map', 'Problems', 'Categories', 'ProblemVotes', 'Findings',
  ($location, $sce, Map, Problems, Categories, ProblemVotes, Findings) ->
  
    vm = this;
    vm.problem = Problems.get({id: gon.problem_id},
      (data,header) ->
        meta_image = if vm.problem.images && vm.problem.images.length > 0 then vm.problem.images[0] else ''
        vm.meta_item = {
          'title': vm.problem.title,
          'description': vm.problem.summary,
          'image': meta_image
        }

        return
    )

    vm.voteImgStyle = {
        'width': '30px',
        'height': '35px'
    }    

    unvote = () ->
      v = new ProblemVotes({type: 'unvote'})
      v.$save({problem_id: gon.problem_id},
      (data, header) ->
        vm.vote = data
      (data ,header) ->
        if(data.status = 401)
          alert("You are not authorized to vote this item")
        else
          alert("You need to log in to vote"))

    vm.vote_up = () ->
      if(vm.vote.my_vote_status == 'up')
        unvote()
      else
        v = new ProblemVotes({type: 'up'})
        v.$save({problem_id: gon.problem_id},
          (data, header) ->
            vm.vote = data
          (data ,header) ->
            if(data.status = 401)
              alert("You are not authorized to vote this item")
            else
              alert("You need to log in to vote"))

    vm.vote_down = () ->
      if(vm.vote.my_vote_status == 'down')
        unvote()
      else
        v = new ProblemVotes({type: 'down'})
        v.$save({problem_id: gon.problem_id},
          (data, header) ->
            vm.vote = data
          (data ,header) ->
            if(data.status = 401)
              alert("You are not authorized to vote this item")
            else
              alert("You need to log in to vote"))

    vm.showImage = (index) ->
      $('.demoLightbox:eq(' + index + ')').lightbox()
      return true

    ProblemVotes.query({problem_id: gon.problem_id},
    (data, header)->
      vm.vote = data      
    )

    return vm
])