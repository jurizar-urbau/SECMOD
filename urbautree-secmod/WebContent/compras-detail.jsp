<%@page import="com.urbau.feeders.Main"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.misc.EncryptUtils"%>
<%@page import="java.util.ArrayList"%>
      
<%

	ExtendedFieldsBaseMain comprasMain = new ExtendedFieldsBaseMain( "COMPRAS", 
		new String[]{ 
			"FECHA","ID_PROVEEDOR",
			"ID_ORDEN_DE_COMPRA","TIPO_DE_PAGO",
			"FORMA_DE_INGRESO","SUBTOTAL",
			"DESCUENTO","TOTAL","GASTOS",
			"TOTAL_CON_GASTOS","ESTADO"
	    },
		new int[]{ 
			Constants.EXTENDED_TYPE_DATE, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_INTEGER
		} );

      	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
      		
      		
//      		ArrayList<String[]> empleadosList = empleadosMain.getCombo("EMPLEADOS", "ID", "CONCAT( NOMBRES ,' ', APELLIDOS)" );
      		
      		
      		
      	
      	int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
      	ExtendedFieldsBean bean = comprasMain.get( id );
      	String mode = request.getParameter( "mode" );
      
      %>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	</head>
   
   <body>
  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      
      <header class="header black-bg">
      		<%@include file="fragment/header.jsp"%>        
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <%@include file="fragment/sidebar.jsp"%>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      
      <section id="main-content">
          <section class="wrapper site-min-height">
          
          	<h3><i class="fa fa-angle-right"></i> Detalle de adelanto</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   		<h4 class="mb"><i class="fa fa-angle-left"></i><a href="compras.jsp">&nbsp;Regresar</a> </h4>
          			   		
          			   		<form class="form-horizontal style-form" id="form" name="form">
          			   			
		                  	   	<input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>"></input>
		                      	<input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>"></input>
		                      	<%= Util.getHiddenFormFrom( comprasMain ) %>
		                      	
		                      	
		                      	    <div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Fecha</label> 
		                              	<div class="col-sm-10">
				                        	<input type="date" class="form-control" name="FECHA" id="FECHA" value="<%= bean.getValue( "FECHA" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Proveedor</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="ID_PROVEEDOR" id="ID_PROVEEDOR" value="<%= bean.getValue( "ID_PROVEEDOR" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Orden de compra</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="ID_ORDEN_DE_COMPRA" id="ID_ORDEN_DE_COMPRA" value="<%= bean.getValue( "ID_ORDEN_DE_COMPRA" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Tipo de pago</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="TIPO_DE_PAGO" id="TIPO_DE_PAGO" value="<%= bean.getValue( "TIPO_DE_PAGO" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Forma de ingreso</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="FORMA_DE_INGRESO" id="FORMA_DE_INGRESO" value="<%= bean.getValue( "FORMA_DE_INGRESO" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Subtotal</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="SUBTOTAL" id="SUBTOTAL" value="<%= bean.getValue( "SUBTOTAL" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Descuento</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="DESCUENTO" id="DESCUENTO" value="<%= bean.getValue( "DESCUENTO" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Total</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="TOTAL" id="TOTAL" value="<%= bean.getValue( "TOTAL" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Gasto</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="GASTOS" id="GASTOS" value="<%= bean.getValue( "GASTOS" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Total con gastos</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="TOTAL_CON_GASTOS" id="TOTAL_CON_GASTOS" value="<%= bean.getValue( "TOTAL_CON_GASTOS" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Estado</label> 
		                              	<div class="col-sm-10">
				                        	<input type="text" class="form-control" name="ESTADO" id="ESTADO" value="<%= bean.getValue( "ESTADO" ) %>" <%= ( "edit".equals( mode ) || "add".equals( mode ) ) ? "" : "disabled" %>>	                          	                          
		                              	</div>
		                          	</div>	                          	
                          	</form>
                         </div>
                         <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('compras.jsp')">Cancelar</button>
					     </div>                                                                                                      
                  </div>
          		</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
<script>
            $(document).ready(function(){
             $('#form').validate(
             {
              rules: {
                nombre: {
                  minlength: 2,
                  maxlength: 30,
                  required: true
                }
              },
              highlight: function(element) {
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
              },
              success: function(element) {
                element
                .closest('.form-group').removeClass('has-error').addClass('has-success');
              }
             });
            }); // end document.ready
            
            
            
           
        </script>
       
		<script>        	
        
        $(function() {
    		    	
    		$('#form').submit(function(e){
    			e.preventDefault();
    		});
    		
    		
    		$("#savebutton").click(function(){
    			    					
    			var form =$('#form');
    	     	$.ajax({
    	     		type:'POST',
    	 			url: './bin/ExtendedFields',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "compras.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operacion");	
    	 			}
    		            		        
    	       });
    	     	
    	     	return false;
    	 	});
    				 
    		
    		var mode = getUrlParameter('mode');    		
    		if(mode === "remove"){
    			$("#rolSelect").attr('disabled','disabled');
    			$("#activo").attr('disabled','disabled');
    			
    			$("#savebutton").removeClass("btn btn-success");
    			$("#savebutton").addClass("btn btn-danger");
    			$("#savebutton").html("Borrar");						
    		}else if(mode === "view"){
    			$("#rolSelect").attr('disabled','disabled');
    			$("#activo").attr('disabled','disabled');
    			$("#savebutton").hide();    			    	    	
    			
    		}else if(mode === "add"){    			
    			$("#nombresapellidos").attr('value', ' ');
    			$("#clave").attr('value', '');    			
    		}
    		
    		// select option by id 
    		var idRol = $("#idRol").val();    		    		    	
    		if(idRol){
    			$("#rolSelect option[value="+idRol+"]").attr('selected','selected');    			
    		}
    		
    		
    		
    		
   		}); // end function 
    		 
    		 
		function getUrlParameter(sParam){
   			
		    var sPageURL = window.location.search.substring(1);
		    var sURLVariables = sPageURL.split('&');
		    
		    for (var i = 0; i < sURLVariables.length; i++) {
		    	
		        var sParameterName = sURLVariables[i].split('=');
		        if (sParameterName[0] == sParam) {
		             return sParameterName[1];
		        }
		    }
	    } // end getUrlParameter 
        
            
           
	</script>
        
  </body>
</html>
<% 		
} else {
%>
		<p>No se especifico un id.</p>
<%
 } 
%>