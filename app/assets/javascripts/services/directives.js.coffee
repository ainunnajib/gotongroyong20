appDirectives = angular.module('appDirectives', [])
appDirectives.directive 'voteSection', () ->
    directive = 
    {
        restrict: 'AEC',
        scope: {
            'upVoteCount': '@',
            'downVoteCount': '@',
            'upVoted': '@',
            'downVoted': '@',
            'imgHeight': '@',
            'imgWidth': '@',
            'voteUp': '&',
            'voteDown': '&'
        },
        link: (scope, element, attrs) ->
            scope['upInactiveImg'] = image_path('up_inactive.png')
            scope['upPressedImg'] = image_path('up_pressed.png')
            scope['downInactiveImg'] = image_path('down_inactive.png')
            scope['downPressedImg'] = image_path('down_pressed.png')            
        template: '<div class="thumb">
              <img height="35" ng-click="voteUp()" ng-src="{{upVoted == \'true\' && upPressedImg || upInactiveImg}}" width="30">
              <br>
              <div class="point ng-binding">
                {{upVoteCount - downVoteCount}}
              </div>
              <img height="35" ng-click="voteDown()" ng-src="{{downVoted == \'true\' && downPressedImg || downInactiveImg}}" width="30">
            </div>'        
    }
    
    return directive

