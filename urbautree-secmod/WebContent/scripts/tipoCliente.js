// scripts/province.js
(function(){

    'use strict';

    angular
        .module('formsApp')
        .factory('tipoCliente', tipoCliente);
        
        function tipoCliente($http) {
            function gerTipoClientes() {
                var list = [] ;
                $http({
                	method: 'POST',
                	url: 'http://localhost:8080/urbautree-secmod/bin/clienttype',
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
      			console.log("success get type of clients");
      		       for(var item in data.data) {
                    if(data.data.hasOwnProperty(item)){
                    	list.push({
                                        "name" : data.data[item].tipoCliente ,
                                        "value" : data.data[item].id
                                       });
                    }
                }
                }).
      			  error(function(data, status, headers, config) {
      			    console.log("error getting countries");
      				  // called asynchronously if an error occurs
      			    // or server returns response with an error status.
      			  }); 
                    return list;
                    }

            return {
                getTipoClientes: gerTipoClientes
            }
        }
        
})();