// app.js

(function() {

    'use strict';
angular.module('formsApp',['formly', 'formlyBootstrap','ngRoute', 'ngMessages']);

//    angular.module('formlyApp', ['formly', 'formlyBootstrap']);

angular.module('formsApp').config(['$routeProvider',
                                  function($routeProvider) {
                                   $routeProvider.
                                       when('/clients',{

                                       templateUrl: "partials/client-list.html"
                                   }).
                                   when('/clients/detail/:action' ,{
                                       templateUrl: 'partials/client-detail.html',

                                   }).
                                   when('/clients/detail/:action/:idClient' , {
                                       templateUrl: 'partials/client-detail.html',
                                   }).
                                   otherwise({
                                    redirectTo: '/clients'
                                  })

                                   }]);

})();
