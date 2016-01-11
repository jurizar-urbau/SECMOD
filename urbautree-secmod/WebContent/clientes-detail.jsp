<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.ClienteBean"%>
<%@page import="com.urbau.beans.PaisBean"%>
<%@page import="com.urbau.beans.MonedaBean"%>
<%@page import="com.urbau.feeders.ClientesMain"%>
<%@page import="com.urbau.feeders.MonedasMain"%>
<%@page import="com.urbau.feeders.PaisesMain"%>
      
<%	
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			ClientesMain main = new ClientesMain();					
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );								
			ClienteBean bean = main.get( id );
			String mode = request.getParameter( "mode" );									
																		
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	</head>
   
   <body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=159695794072494&version=v2.3";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE CLIENTE</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="clientes.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" id="form" name="form">
                      <input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>">
                      <input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>">                                          
                      
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nit</label>
                              <div class="col-sm-10">                              		                          	
	                          		<input type="text" class="form-control" name="nit" id="nit" value="<%= bean.getNit() %>">	                          	                          	                          	   	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nombres</label>
                              <div class="col-sm-10">                              		                          	
	                          		<input type="text" class="form-control" name="nombres" id="nombres" value="<%= bean.getNombres() %>">	                          	                          
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Apellidos</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="apellidos" id="apellidos" value="<%= bean.getApellidos() %>">	                          	                          	                          	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Direcci&oacute;n</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="direccion" id="direccion" value="<%= bean.getDireccion() %>">	                          	                          	                          	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tel&eacute;fono</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="telefono" id="telefono" value="<%= bean.getTelefono() %>">	                          	                          	                          	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Correo Electr&oacute;nico</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="correo" id="correo" value="<%= bean.getEmail() %>">	                          	                          	                                                           
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tipo De Cliente</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<select class="form-control" name="tipodecliente" id="tipodecliente">
	                          			<option value="interno" <%= "interno".equals( bean.getTipoDeCliente() ) ? "selected" : "" %>>Interno</option>
	                          			<option value="externo" <%= "externo".equals( bean.getTipoDeCliente() ) ? "selected" : "" %>>Externo</option>
	                          		</select>	                          	                          	                                                           
                              </div>
                          </div>
                                
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Cliente Credito</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<select class="form-control" name="aceptacredito" id="aceptacredito">
	                          			<option value="1" <%= 1 == bean.getAcepta_credito() ? "selected" : "" %>>Si</option>
	                          			<option value="0" <%= 0 == bean.getAcepta_credito() ? "selected" : "" %>>No</option>
	                          		</select>	                          	                          	                                                           
                              </div>
                          </div>
                                      
                                                                              
                                                                                                                                                                                                                    
                          <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('clientes.jsp')">Cancelar</button>
					      </div>  
                                                                                                                           
                      </form>
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
            	  
                nit: {
                  minlength: 2,
                  maxlength: 15,
                  required: true
                },                
                nombres: {
                    minlength: 3,
                    maxlength: 50,
                    required: true
                  },
                appelidos: {
                    minlength: 3,
                    maxlength: 50                  
                  },                                      
                direccion: {
                    minlength: 3,
                    maxlength: 50                    
                  },     
                telefono: {
                    minlength: 3,
                    maxlength: 20                    
                  },                                                       
                correo: {
                  required: true,
                  email: true
                },
                tipodecliente: {
                    required: true                   
                  }
                
              },
              highlight: function(element) {
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
              },
              success: function(element) {
            	$(element).closest('.form-group').removeClass('has-error').addClass('has-success');
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
    	     		dataType: "text",
    	 			url: './bin/Clientes',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		      
    		        	alert(msg);
    		            location.replace( "clientes.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operaciòn");	
    	 			}
    		            		        
    	       });
    	     	
    	     	return false;
    	 	});
    				 
    		
    		var mode = getUrlParameter('mode');    		
    		if(mode === "remove"){
    			$("#nit").attr('disabled','disabled');    			
    			$("#nombres").attr('disabled','disabled');
    			$("#apellidos").attr('disabled','disabled');    			
    			$("#direccion").attr('disabled','disabled');
    			$("#telefono").attr('disabled','disabled');
    			$("#correo").attr('disabled','disabled');    			
    			$("#tipodecliente").attr('disabled','disabled');
    			
    			$("#savebutton").removeClass("btn btn-success");
    			$("#savebutton").addClass("btn btn-danger");
    			$("#savebutton").html("Borrar");						
    		}else if(mode === "view"){
    			$("#nit").attr('disabled','disabled');    			
    			$("#nombres").attr('disabled','disabled');
    			$("#apellidos").attr('disabled','disabled');    			
    			$("#direccion").attr('disabled','disabled');
    			$("#telefono").attr('disabled','disabled');
    			$("#correo").attr('disabled','disabled');
    			$("#tipodecliente").attr('disabled','disabled');
    			    			
    			$("#activo").attr('disabled','disabled');
    			$("#savebutton").hide();    			    	    	
    		
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