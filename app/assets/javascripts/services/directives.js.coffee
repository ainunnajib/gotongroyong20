appDirectives = angular.module('appDirectives', [])
appDirectives.directive 'voteSection', () ->
    directive = 
    {
        restrict: 'AEC',
        scope: {
            'upVoteCount': '@',
            'downVoteCount': '@',            
            'voteStatus': '@',
            'imgStyle': '@',            
            'voteUp': '&',
            'voteDown': '&'
        },
        link: (scope, element, attrs) ->
            scope['upInactiveImg'] = image_path('up_inactive.png')
            scope['upPressedImg'] = image_path('up_pressed.png')
            scope['downInactiveImg'] = image_path('down_inactive.png')
            scope['downPressedImg'] = image_path('down_pressed.png')            
        template: '<div class="thumb">
              <img ng-click="voteUp()" ng-src="{{voteStatus == \'up\' && upPressedImg || upInactiveImg}}" ng-style="{{imgStyle}}">
              <br>
              <div class="point ng-binding">
                {{upVoteCount - downVoteCount}}
              </div>
              <img ng-click="voteDown()" ng-src="{{voteStatus == \'down\' && downPressedImg || downInactiveImg}}" ng-style="{{imgStyle}}">
            </div>'        
    }
    
    return directive

appDirectives .directive "ngEnter", ->
  (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which is 13
        scope.$apply ->
          scope.$eval attrs.ngEnter,
            event: event
        event.preventDefault()