// scripts/MainController.js

(function() {

    'use strict';

        angular.module('formsApp')
            .controller('clientFormController', 
            		["$http","$scope","$routeParams","$location","province","tipoCliente","seller",'client','notifications', ClientFormController]);

        angular.module('formsApp')
            .controller('clientLisController',["$scope","$http","$location",'notifications', ClientListController]);

    function ClientListController($scope,$http,$location,notifications) {
    	
    	$scope.go = function ( path , other ) {
    		if(other) {
    			path = path + other;
    		}  
    		$location.path( path );
    		};
    	console.log("get data");	
        $http({
  		    method: 'GET',
  		    url: '/urbautree-secmod/bin/clients?mode=list',
  		    headers: {'Content-Type': 'application/json'},
  		}).
      		  success(function(data, status, headers, config) {
      			console.log("success");
                $scope.data = data.data;
         }).
      			  error(function(data, status, headers, config) {
      			    console.log("error");
      				  // called asynchronously if an error occurs
      			    // or server returns response with an error status.
      			  });
    }

    function ClientFormController($http ,$scope, $routeParams,$location,province,tipoCliente,seller,clientService,notifications) {
    	$scope.go = function ( path ,other) {
    		  $location.path( path );
    		};
        var vm = this;
        // The model object that we reference
    // on the  element in index.html

    vm.onSubmit = onSubmit;

       var myClient = {},
        action = "",
        idClient ;
       if($routeParams.action) {
         action = $routeParams.action;
       }
        if ($routeParams.idClient) {
           var idClient = $routeParams.idClient;
           $scope.clientId = $routeParams.idClient;
          console.log($routeParams.idClient);
          idClient = $routeParams.idClient;
//       myClient=  client.getClient($routeParams.idClient);

        vm.getclient =  function() {
            clientService.getClient($routeParams.idClient)
               .success(function(client) {
                vm.client = client;
                console.log("this is the client" + vm.client);
            })
        }

        vm.getclient();
       }else {
          vm.client = {};
       }
        vm.client =myClient;


    // An array of our form fields with configuration
    // and options set. We make reference to this in
    // the 'fields' attribute on the  element
    var defaultClassName =     'col-xs-6'  //Two columns view
    vm.clientFields =
    [
        {
            fieldGroup: [
                {
                    className: defaultClassName,
                    key: 'rzsocial',
                    type: 'input',
                    templateOptions: {
                        type: 'text',
                        label: 'Razon Social',
                        required: true
                    },
                    validation: {
                        required: function(viewValue, modelValue, scope) {
                            return scope.to.label + 'is required'
                        }
                    }
                },
                {
                    className: defaultClassName,
                    key: 'client',
                    type: 'input',
                    templateOptions: {
                        type: 'text',
                        label: 'Cliente',
                        required: true
                    }
                },
            ]
        },
        {
            fieldGroup: [
                 {
                    className: defaultClassName,
                    key: 'country',
                    type: 'select',
                    templateOptions: {
                        label: 'Pais',
                        options: province.getProvinces()
                    }
                },
                {
                    className: defaultClassName,
                    key: 'tel',
                    type: 'input',
                    validators: {

                        telephoneNumber:  function($viewValue, $modelValue, scope) {
                        var value = $modelValue || $viewValue;
                        if(value) {
                            // call the validateDriversLicense function
                            // which either returns true or false
                            // depending on whether the entry is valid
                            console.log("validation");
                            console.log(validateTelepone(value));
                            return validateTelepone(value)
                        }else {
                          console.log("empty default true");
                            return true;
                        }
                   }
                    },
                    templateOptions: {
                        type: 'text',
                        label: 'Telefono'

                    }
                },

            ]
        },
        {
            className: defaultClassName,
            key: 'fax',
            type: 'input',
            validators: {
                telephoneNumber:  function($viewValue, $modelValue, scope) {
                var value = $modelValue || $viewValue;
                if(value) {
                    // call the validateDriversLicense function
                    // which either returns true or false
                    // depending on whether the entry is valid
                    return validateTelepone(value)
                }else {
                            return true;
                        }

           }
            },
            templateOptions: {
                type: 'text',
                label: 'Fax',
                required: false

            }
        },
        {
            className: defaultClassName,
            key: 'email',
            type: 'input',
            templateOptions: {
                type: 'email',
                label: 'Email'
            }
        },
        {
            className: defaultClassName,
            key: 'tipoCliente',
            type: 'select',
            templateOptions: {
                label: 'Clasificacion',
                options:  tipoCliente.getTipoClientes()
            }
        },
        {
            className: defaultClassName,
            key: 'rating',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Calificacion'
            }
        },
        {
            className: defaultClassName,
            key: 'numfiscal',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Numero Fiscal',

            }
        },
        {
            className: defaultClassName,
            key: 'seller',
            type: 'select',
            templateOptions: {
                label: 'Vendedor',
                options: seller.getSellers()
            }
        },
        {
                    className: defaultClassName,
                    key: 'telalt',
                    type: 'input',
                    validators: {
                        telephoneNumber: {
                        expression: function($viewValue, $modelValue, scope) {
                                        var value = $modelValue || $viewValue;
                                        if(value) {
                                            // call the validateDriversLicense function
                                            // which either returns true or false
                                            // depending on whether the entry is valid
                                            return validateTelepone(value)
                                        }else {
                                            return true;
                                        }
                                   },
                        message: '$viewValue + " is not a valid IP Address "'
                    }

                    },
                    templateOptions: {
                        type: 'text',
                        label: 'Telefono alterno'

                    }
         },
        {
                    className: defaultClassName,
                    key: 'faxalt',
                    type: 'input',
                    validators: {
                        telephoneNumber:  function($viewValue, $modelValue, scope) {
                        var value = $modelValue || $viewValue;
                        if(value) {
                            // call the validateDriversLicense function
                            // which either returns true or false
                            // depending on whether the entry is valid
                            return validateTelepone(value)
                        }else {
                            return true;
                        }
                   }
                    },
                    templateOptions: {
                        type: 'text',
                        label: 'Fax Alterno'

                    }
                },
        {
            className: defaultClassName,
            key: 'addrfiscal',
            type: 'textarea',
            templateOptions: {
                label: 'Direccion Fiscal'
            }
        },


        {
            className: defaultClassName,
            key: 'addrship',
            type: 'textarea',
            templateOptions: {
                label: 'Direcion Correspondencia'
            }
        },

        {
            template: '<hr />'
        }

    ];
     // function definition
    function onSubmit() {
        console.log('submit');
        vm.client.mode= action;
        vm.client.id = idClient;
        console.log(JSON.stringify(vm.client));

//       alert(JSON.stringify(vm.client), null, 2);
        $http({
  		    method: 'POST',
  		    url: 'http://localhost:8080/urbautree-secmod/bin/clients',
  		    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
  		    transformRequest: function(obj) {
  		        var str = [];
  		        for(var p in obj)
  		        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
  		        return str.join("&");
  		    },
  		    data: vm.client
  		}).
      		  success(function(data, status, headers, config) {
      			console.log("succes");
      			notifications.setNotification("Exito","Cliente Agregado con exito");
      			 $location.path( '/clients' );
//      			location.replace( $scope.beanService.redirectUrl );
      			  // this callback will be called asynchronously
      			    // when the response is available
      			  }).
      			  error(function(data, status, headers, config) {
      			    console.log("error");
      				  // called asynchronously if an error occurs
      			    // or server returns response with an error status.
      			  });


    }


        function validateTelepone(value) {
          return /^\d{4}(-|)\d{4}$/.test(value);
        }
    }

})();
