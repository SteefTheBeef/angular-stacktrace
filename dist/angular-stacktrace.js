angular.module('angularStacktrace', []);

angular.module('angularStacktrace').provider('stacktrace', function() {
  this.options = {
    type: 'POST',
    url: null,
    contentType: 'application/json'
  };
  this.setUrl = (function(_this) {
    return function(url) {
      _this.options.url = url;
      return _this;
    };
  })(this);
  this.setType = (function(_this) {
    return function(type) {
      _this.options.type = type;
      return _this;
    };
  })(this);
  this.$get = function() {
    return {
      getOption: (function(_this) {
        return function(key) {
          return _this.options[key];
        };
      })(this)
    };
  };
}).provider('$exceptionHandler', function() {
  this.$get = ["errorLogService", function(errorLogService) {
    return errorLogService;
  }];
}).factory('traceService', function() {
  return {
    print: printStackTrace
  };
}).factory('errorLogService', ["$log", "$window", "stacktrace", "traceService", function($log, $window, stacktrace, traceService) {
  return function(exception, cause) {
    var e, errorMessage, stackTrace, url;
    $log.error.apply($log, arguments);
    try {
      errorMessage = exception.toString();
      stackTrace = traceService.print({
        e: exception
      });
      url = stacktrace.getOption('url');
      if (!url) {
        throw new Error('Cannot send exception report, please set url.');
      }
      return $.ajax({
        type: stacktrace.getOption('type'),
        url: stacktrace.getOption('url'),
        contentType: "application/json",
        data: angular.toJson({
          errorUrl: $window.location.href,
          errorMessage: errorMessage,
          stackTrace: stackTrace
        })
      });
    } catch (_error) {
      e = _error;
      return $log.error(e);
    }
  };
}]);
