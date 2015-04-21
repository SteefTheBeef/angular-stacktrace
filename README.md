# AngularStacktrace

Automatic and easy error reporting for AngularJS

## Dependencies
AngularJS  
jQuery  
Stacktrace-js

## Installation
1. Get it from bower: `bower install angular-stacktrace --save`
2. Add it as a dependecy to your app: `JavaScript angular.module('yourApp', ['angularStacktrace']);`
3. Configure an URL which to send reports to:  
```JavaScript 
angular.module('yourApp').config(function(stacktraceProvider) {
    return stacktraceProvider.setUrl('yourUrl');
});
```
## Inspiration & Credits
[Ben nadel](http://www.bennadel.com/blog/2542-logging-client-side-errors-with-angularjs-and-stacktrace-js.htm)

## License
MIT
