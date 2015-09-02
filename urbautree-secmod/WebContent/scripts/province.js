// scripts/province.js
(function(){

    'use strict';

    angular
        .module('formsApp')
        .factory('province', province);
        
        function province($http) {
            function getProvinces() {
                var countries =[];
               $http({
  		    method: 'POST',
  		    url: 'http://localhost:8080/urbautree-secmod/bin/countries',
  		    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  		    transformRequest: function(obj) {
  		        var str = [];
  		        for(var p in obj)
  		        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
  		        return str.join("&");
  		    },
  		    data: 
                   {mode: "list"}
  		}).
      		  success(function(data, status, headers, config) {
      			console.log("success get countries");
      		   
                   for(var country in data.data) {
                    if(data.data.hasOwnProperty(country)){
                        countries.push({
                                        "name" : data.data[country].countryName ,
                                        "value" : data.data[country].id
                                       });
                    }
                    
                }
                   
                }).
      			  error(function(data, status, headers, config) {
      			    console.log("error getting countries");
      				  // called asynchronously if an error occurs
      			    // or server returns response with an error status.
      			  }); 
                return countries;
            }

            return {
                getProvinces: getProvinces
            }
        }
        
})();