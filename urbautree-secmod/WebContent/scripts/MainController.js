// scripts/MainController.js

(function() {

    'use strict';
    
    var formsApp = angular.module('formsApp',['formly', 'formlyBootstrap']);
        formsApp.controller('clientFormController', ClientFormController);

    function ClientFormController() {

        var vm = this;
        // The model object that we reference
    // on the  element in index.html
    vm.client = {};
    vm.onSubmit = onSubmit;
        
    // An array of our form fields with configuration
    // and options set. We make reference to this in
    // the 'fields' attribute on the  element
    vm.clientFields = [
        {
            className: 'row' ,
            fieldGroup: [
                {   
                    className: 'col-xs-6',
                    key: 'rzSocial',
                    type: 'input',
                    templateOptions: {
                        type: 'text',
                        label: 'Razon Social',
                        required: true
                    }
                },
                {
                    className: 'col-xs-6',
                    key: 'clientName',
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
                    className: 'col-xs-6',
                    key: 'country',
                    type: 'input',
                    templateOptions: {
                        type: 'text',
                        label: 'Pais'
                    }
                },
                {
                    className: 'col-xs-6',
                    key: 'tel',
                    type: 'input',
                    validators: {
                        telephoneNumber:  function($viewValue, $modelValue, scope) {
                        var value = $modelValue || $viewValue;
                        if(value) {
                            // call the validateDriversLicense function
                            // which either returns true or false
                            // depending on whether the entry is valid
                            return validateTelepone(value)
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
            key: 'numFiscal',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Numero Fiscal',
                
            }
        },
        {
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
            key: 'addrFiscal',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Direccion Fiscal'
            }
        },
        {
            key: 'email',
            type: 'email',
            templateOptions: {
                type: 'text',
                label: 'Email'
            }
        },
        {
            key: 'rating',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Rating'
            }
        },
        {
            key: 'addrship',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Direcion'
            }
        },
        {
            key: 'tipo_cliente',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Tipo Cliente'
            }
        },
        {
            key: 'seller',
            type: 'input',
            templateOptions: {
                type: 'text',
                label: 'Vendedor'
            }
        },
        
                
    ];
     // function definition
    function onSubmit() {
        console.log('submit');
      alert(JSON.stringify(vm.client), null, 2);
    }
        
    
        function validateTelepone(value) {
        return /\d{4}(-|)\d{4}$/.test(value);
        }
    }

})();