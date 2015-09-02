(function() {
    'use strict';
    
    angular
        .module('formsApp')
        .factory('client', client);
    
    function client($http) {
        function getClient(idClient) {
            
            
            return $http.get("http://localhost:8080/urbautree-secmod/bin/clients?mode=view&id="+idClient)
            .success(function(data, status, headers,config) {
                console.log("succes view client");
                service.client = data;    
            
            });
            return client;
            
            
        }
        var service =  {
            client: {},
            getClient: getClient
        }
        return service;
    }
})();