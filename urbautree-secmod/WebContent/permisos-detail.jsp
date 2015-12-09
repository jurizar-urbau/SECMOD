<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.misc.EncryptUtils"%>
<%@page import="java.util.ArrayList"%>
      
<%

	ExtendedFieldsBaseMain rm = new ExtendedFieldsBaseMain( "PERMISOS", 
		new String[]{"EMPLEADO","FECHA","MOTIVO","OBSERVACIONES"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_DATE,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_STRING
		} );

ExtendedFieldsBaseMain empleadosMain = new ExtendedFieldsBaseMain( "EMPLEADOS", 
		new String[]{"NOMBRES","APELLIDOS","DIRECCION","TELEFONO","NUMERO_CEDULA","NIT","ESTADO_CIVIL","SEXO","FECHA_DE_NACIMIENTO","HIJOS","MUNICIPIO","ESTADO"},
			new int[]{ 
			Constants.EXTENDED_TYPE_STRING, 
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_DATE,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER
		} );
	
	
      	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
      		
      		TwoFieldsBaseMain motivosMain = new TwoFieldsBaseMain("MOTIVOS");
      		ArrayList<KeyValueBean> motivosList = motivosMain.getForCombo();
      		ArrayList<String[]> empleadosList = empleadosMain.getCombo("EMPLEADOS", "ID", "CONCAT( NOMBRES ,' ', APELLIDOS)" );
      		
      		
      		
      	
      	int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
      	ExtendedFieldsBean bean = rm.get( id );
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
          
          	<h3><i class="fa fa-angle-right"></i> Detalle de permiso</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   		<h4 class="mb"><i class="fa fa-angle-left"></i><a href=permisos.jsp">&nbsp;Regresar</a> </h4>
          			   		<form class="form-horizontal style-form" id="form" name="form">
		                  	   	<input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>"></input>
		                      	<input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>"></input>
		                      	<input type="hidden" name="tablename" id="tablename" value="<%= EncryptUtils.base64encode( "PERMISOS" ) %>"></input>
		                      	
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "EMPLEADO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "FECHA" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "MOTIVO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "OBSERVACIONES" ) %>"></input>
		                      	
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DATE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	
		                      	
		                      	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Empleado</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="EMPLEADO" id="EMPLEADO">
		                              			<%
		                              				for( String[] keyValue : empleadosList ){
		                              			%> 
		                              				<option data="<%= keyValue[0] + "," + keyValue[1] %>" value="<%= keyValue[ 0 ] %>" <%= bean.getValue( "EMPLEADO" ).equals( String.valueOf( keyValue[0]) ) ? "SELECTED" : ""%>><%= keyValue[1] %></option>
		                              			<% } %>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="EMPLEADO" id="EMPLEADO" disabled>
		                              			<%
		                              				for( String[] keyValue : empleadosList ){
		                              			%> 
		                              				<option value="<%= keyValue[0] %>" <%= bean.getValue( "EMPLEADO" ).equals( String.valueOf( keyValue[0]) ) ? "SELECTED" : ""%>><%= keyValue[1] %></option>
		                              			<% } %>
		                              		</select>	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                      	
		                      	
		                      		<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Fecha</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="date" class="form-control" name="FECHA" id="FECHA" value="<%= bean.getValue( "FECHA" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="date" class="form-control" name="FECHA" id="FECHA" disabled value="<%= bean.getValue( "FECHA" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Motivo</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="MOTIVO" id="MOTIVO">
		                              			<%
		                              				for( KeyValueBean keyValue : motivosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "MOTIVO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="MOTIVO" id="MOTIVO" disabled>
		                              			<%
		                              				for( KeyValueBean keyValue : motivosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "MOTIVO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Observaciones</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="OBSERVACIONES" id="OBSERVACIONES" value="<%= bean.getValue( "OBSERVACIONES" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="OBSERVACIONES" id="OBSERVACIONES" disabled value="<%= bean.getValue( "OBSERVACIONES" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
	                          	
	                          	
	                          	
	                          	
                          	</form>
                         </div>
                         <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('permisos.jsp')">Cancelar</button>
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
    		            location.replace( "permisos.jsp" );
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