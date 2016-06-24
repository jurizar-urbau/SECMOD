<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.misc.EncryptUtils"%>
<%@page import="java.util.ArrayList"%>
      
<%

ExtendedFieldsBaseMain cupones = new ExtendedFieldsBaseMain( "CUPONES_DE_DESCUENTO", 
		new String[]{"MONTO","DESCRIPCION","ID_USUARIO","FECHA_CREACION","ESTADO","ID_CLIENTE","ID_ORDEN","ID_MOTIVO"},
			new int[]{ 
			Constants.EXTENDED_TYPE_DOUBLE, 
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DATE,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER
		} );

		ArrayList<String[]> motivos = cupones.getCombo( "MOTIVOS_DE_DESCUENTO", "ID","DESCRIPCION" );
	
      	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
      		
      		
      		
      		
      	
      	int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
      	ExtendedFieldsBean bean = cupones.get( id );
      	String mode = request.getParameter( "mode" );
      
      %>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<script>
		function searchClients( q ){
			$( "#client-container" ).html("");
			 $.get( "./bin/searchc?q=" + q, null, function(response){
	             $.each(response, function(i, v) {
	            	 var rootele;
	            	 var htmltoadd =
	            		"<tr>" +
	             	  	"<td><input type='radio' name='clienteid' value='" + v.id + "," + v.nombres + " " + v.apellidos + "'></td>" +
	                 	"<td>"+v.nit+"</td>" +                                  
	                 	"<td>"+v.nombres+"</td>" +
	                 	"<td>"+v.apellidos+"</td>" +         
	                 	"</tr>";
	     			$( "#client-container" ).append( htmltoadd );
	            	
	            	 
	             });
	          });
		}
	</script>
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
          
          	<h3><i class="fa fa-angle-right"></i> Detalle de cupones de descuento</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			    	<h4 class="mb"><i class="fa fa-angle-left"></i><a href="descuentos.jsp">&nbsp;Regresar</a> </h4>
          			   		<form class="form-horizontal style-form" id="form" name="form">
		                  	   	<input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>"></input>
		                      	<input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>"></input>
		                      	<input type="hidden" name="tablename" id="tablename" value="<%= EncryptUtils.base64encode( "CUPONES_DE_DESCUENTO" ) %>"></input>
		                      	
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "MONTO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "DESCRIPCION" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ID_MOTIVO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ID_USUARIO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "FECHA_CREACION" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ESTADO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ID_CLIENTE" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ID_ORDEN" ) %>"></input>
		                      	
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DATE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	
		                      	
		                      		<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Monto</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="MONTO" id="MONTO" value="<%= bean.getValue( "MONTO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="MONTO" id="MONTO" disabled value="<%= bean.getValue( "MONTO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Descripci&oacute;n</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="DESCRIPCION" id="DESCRIPCION" value="<%= bean.getValue( "DESCRIPCION" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="DESCRIPCION" id="DESCRIPCION" disabled value="<%= bean.getValue( "DESCRIPCION" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Motivo</label> 
		                              	<div class="col-sm-10">
		                              	<% if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="ID_MOTIVO" id="ID_MOTIVO">
		                              			<%
		                              				for( String[] motivo : motivos ){
		                              			%>
		                              				<option value="<%= motivo[ 0 ]%>"  <%= motivo[0].equals( bean.getValue( "ID_MOTIVO" ) ) ? "selected" : "" %>><%= motivo[ 1 ] %></option>
		                              			<% } %>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="ID_MOTIVO" id="ID_MOTIVO" disabled>
		                              			<%
		                              				for( String[] motivo : motivos ){
		                              			%>
		                              				<option value="<%= motivo[ 0 ]%>"  <%= motivo[0].equals( bean.getValue( "ID_MOTIVO" ) ) ? "selected" : "" %>><%= motivo[ 1 ] %></option>
		                              			<% } %>
		                              		</select> 	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	  	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="hidden" class="form-control" name="ID_USUARIO" id="ID_USUARIO" value="<%= loggedUser.getId() %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="hidden" class="form-control" name="ID_USUARIO" id="ID_USUARIO" disabled value="<%= bean.getValue( "ID_USUARIO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="hidden" class="form-control" name="FECHA_CREACION" id="FECHA_CREACION" value="NOW()">	                          	                          
			                          	<%}else{%>
			                          		<input type="hidden" class="form-control" name="FECHA_CREACION" id="FECHA_CREACION" disabled value="<%= bean.getValue( "FECHA_CREACION" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="hidden" class="form-control" name="ESTADO" id="ESTADO" value="C">	                          	                          
			                          	<%}else{%>
			                          		<input type="hidden" class="form-control" name="ESTADO" id="ESTADO" disabled value="<%= bean.getValue( "ESTADO" )  %>">	                          		
			                          	<%}%>   	                                  
		                           
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Cliente</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>
			                          		<input type="text" class="form-control" name="ID_CLIENTE_DISPLAY" id="ID_CLIENTE_DISPLAY"  onclick="chooseClient()">
			                          		<input type="hidden" name="ID_CLIENTE" id="ID_CLIENTE" value="<%= bean.getValue( "ID_CLIENTE" ) %>">	                          	                          
			                          	<%}else{%>
			                          	    <input type="hidden" name="ID_CLIENTE" id="ID_CLIENTE" value="<%= bean.getValue( "ID_CLIENTE" ) %>">
			                          		<input type="text" class="form-control" name="ID_CLIENTE_DISPLAY" id="ID_CLIENTE_DISPLAY" disabled value="<%= bean.getValue( "ID_CLIENTE" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<!-- div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Numero de Orden</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="ID_ORDEN" id="ID_ORDEN" value="<%= bean.getValue( "ID_ORDEN" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="ID_ORDEN" id="ID_ORDEN" disabled value="<%= bean.getValue( "ID_ORDEN" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div-->
		                          	</div>
		                          	
	                          	
	                          	
	                          	
	                          	
                          	</form>
                         </div>
                         <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('descuentos.jsp')">Cancelar</button>
					     </div>                                                                                                      
                  </div>
          		</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->
      
       <!-- clients modal -->
      	 
					<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione un cliente...</h4>
			                          <span class="pull-right">
			                          	
			          				  	<a data-toggle="modal" class="btn btn-success" href="venta.jsp#myModalNewClient">+</a>          				  
			          				  </span>
			          				  
			          				  	<label>Buscar: <input type="text" class="form-control" id="search-client" name="q"></label> 
			          				  
			          				  
			                          
			                      </div>
			                      <div class="modal-body">
				                      
						 <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	  <thead>
                              <tr>
                                  <th></th>
                                  <th>Nit</th>                                  
                                  <th>Nombres</th>
                                  <th>Apellidos</th>                                                                    
                              </tr>
                              </thead>
                              <tbody id="client-container">
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setClient();">Seleccionar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
<script>

function setClient(){
	var value = $('input[name=clienteid]:checked').val();
	var values = value.split(',');
	selected_client_id = values[0];
	$('#ID_CLIENTE').val( selected_client_id );
	$('#ID_CLIENTE_DISPLAY').val( value );
	$('#clientid').val( selected_client_id );
	hideClient();
}
function hideClient(){
		$('#myModal').modal('hide');
	}
function chooseClient(){
		
		$('#myModal').modal('show');
		$('#search-client').focus();
		
	}
	
		$(window).load(function(){
			
		    $( "#search-client" ).keyup(function() {
		    	var value = $( "#search-client" ).val();
		    	searchClients( value );
			});
		    
		});
	
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
    		            location.replace( "descuentos.jsp" );
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