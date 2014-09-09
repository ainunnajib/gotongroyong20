textFilters = angular.module('textFilters', [])
textFilters.filter "nl2br", ->
  (text) ->
    (if text then text.replace(/\n/g, "<br/>") else "")
