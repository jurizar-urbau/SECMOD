var fesApp = angular.module('fesApp', []);
fesApp.controller('formCtrl', ["$scope","$http","beanService" , function($scope,$http,beanService) {
    $scope.master = {};
    $scope.beanService = beanService; 
    
    $scope.update = function(config) {
  	  var url= this.beanService.url;
  	  config.id = this.beanService.bean.id;
  	  config.mode = this.beanService.bean.mode;
  	  
  	  $http({
  		    method: 'POST',
  		    url: url,
  		    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  		    transformRequest: function(obj) {
  		        var str = [];
  		        for(var p in obj)
  		        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
  		        return str.join("&");
  		    },
  		    data: config
  		}).
      		  success(function(data, status, headers, config) {
      			console.log("succes");
      			location.replace( $scope.beanService.redirectUrl );
      			  // this callback will be called asynchronously
      			    // when the response is available
      			  }).
      			  error(function(data, status, headers, config) {
      			    console.log("error");
      				  // called asynchronously if an error occurs
      			    // or server returns response with an error status.
      			  });
    };

    $scope.reset = function() {
        
  	  $scope.user = angular.copy($scope.master);
    };

    $scope.reset();
}]);
