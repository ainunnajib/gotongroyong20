angular.module("problemApp").directive "findingMarkup", ->
  restrict: "E"

  template: "<div><div class='pull-left vote'>
    <div class='thumb' ng-if=\"finding.my_vote_status == 'quo' || finding.my_vote_status == 'not_available'\">
      <img alt=\"Up inactive\" height=\"25\" mouseover=\"up_hover.png\" ng-click='vote_up(finding)' src=\"/assets/up_inactive.png\" width=\"20\" />
      <br>
      <div class='point'>
        {{finding.up_vote - finding.down_vote}}
      </div>
      <img alt=\"Down inactive\" height=\"25\" ng-click=\"vote_down(finding)\" src=\"/assets/down_inactive.png\" style=\"margin-top:10px\" width=\"20\" />
    </div>
    <div class='thumb' ng-if=\"finding.my_vote_status == 'up'\">
      <img alt=\"Up pressed\" height=\"25\" mouseover=\"up_hover.png\" ng-click=\"unvote(finding)\" src=\"/assets/up_pressed.png\" width=\"20\" />
      <br>
      <div class='point'>
        {{finding.up_vote - finding.down_vote}}
      </div>
      <img alt=\"Down inactive\" height=\"25\" ng-click=\"vote_down(finding)\" src=\"/assets/down_inactive.png\" style=\"margin-top:10px\" width=\"20\" />
    </div>
    <div class='thumb' ng-if=\"finding.my_vote_status == 'down'\">
      <img alt=\"Up inactive\" height=\"25\" mouseover=\"up_hover.png\" ng-click='vote_up(finding)' src=\"/assets/up_inactive.png\" width=\"20\" />
      <br>
      <div class='point'>
        {{finding.up_vote - finding.down_vote}}
      </div>
      <img alt=\"Down pressed\" height=\"25\" ng-click=\"unvote(finding)\" src=\"/assets/down_pressed.png\" style=\"margin-top:10px\" width=\"20\" />
    </div>
  </div>
  <div class='comment'>
    <div class='posted-by'>
      {{finding.posted_by}}
    </div>
    <span ng-bind-html='finding.comment | nl2br'></span>
    <div class='reply'>
      <a class='thumb btn btn-default btn-xs' ng-click='finding.show_new_reply = true ? !finding.show_new_reply : false'>
        <span class='glyphicon glyphicon-chevron-down'></span>
      </a>
      <div ng-if='finding.show_new_reply'>
        <br>
        <textarea id=\"finding\" name=\"finding\" ng-model=\"newReply.comment\">
        </textarea>
        <br>
        <button class=\"btn btn-primary pull-right\" name=\"button\" ng-click=\"createReply(finding, newReply)\" type=\"submit\">Submit</button>
      </div>
    </div>
  </div></div>"
  replace: true
