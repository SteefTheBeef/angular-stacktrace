angular.module('angularStacktraceTestApp').config( (stacktraceProvider) ->
  stacktraceProvider.setType('GET')
)

.controller 'appCtrl', ->
  ava.a = 'b'


