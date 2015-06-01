<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.UsuarioBean"%>
<%@page import="com.urbau.feeders.UsuariosMain"%>
<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.beans.RolBean"%>
      
<%	
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			UsuariosMain rm = new UsuariosMain();
			RolesMain roles_main = new RolesMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			UsuarioBean bean = rm.get( id );
			
			String rolUser =roles_main.get( bean.getRol() ).getDescription();
			int idRol =roles_main.get( bean.getRol() ).getId();
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE USUARIO</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="users.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" id="form" name="form">
                      <input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>">
                      <input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>">
                      <input type="hidden" name="idRol" id="idRol" value="<%= idRol %>">
                       
                      
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Usuario</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
	                          		<input type="text" class="form-control" name="loginid" id="loginid" value="<%= bean.getUsuario() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="loginid" id="loginid" disabled value="<%= bean.getUsuario() %>">	                          		
	                          	<%}%>   	                                  
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nombres y Apellidos</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
	                          		<input type="text" class="form-control" name="nombresapellidos" id="nombresapellidos" value="<%= bean.getNombre() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="nombresapellidos" id="nombresapellidos" disabled value="<%= bean.getNombre() %>">	                          			                          	
	                          	<%}%>                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Clave</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          			                          		
	                          		<input type="password" class="form-control" name="clave" id="clave" value="<%= bean.getClave() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="password" class="form-control" name="clave" id="clave" disabled value="<%= bean.getClave() %>">	                          			                          	
	                          	<%}%>
                                  
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Correo Electronico</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          			                          		
	                          		<input type="email" class="form-control" name="email" id="email" value="<%= bean.getEmail() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="email" class="form-control" name="email" id="email" disabled value="<%= bean.getEmail() %>">	                          			                          	
	                          	<%}%>                              
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tel&eacute;fono</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          			                          		
	                          		<input type="text" class="form-control" name="telefono" id="telefono" value="<%= bean.getTelefono() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="telefono" id="telefono" disabled value="<%= bean.getTelefono() %>">	                          			                          	
	                          	<%}%>                                  
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Rol</label>
                              <div class="col-sm-10">
                                  <select class="form-control" name="rol" id="rolSelect">
                                  <%
                                  	ArrayList<RolBean> roles_list = roles_main.get(null, 0);
                                  	for( RolBean rol : roles_list ){
                                  %>
                                  	<option value="<%= rol.getId()%>"><%= rol.getDescription() %></option>
                                  <% } %>									  
									  
									</select>
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Activo</label>
                              <div class="col-sm-10">
	                              <div class="col-sm-6 text-left">
			                      	<input type="checkbox" name="activo" id="activo" data-toggle="switch" />
			                      </div>
		                      </div>
                          </div>
                          
                           <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('users.jsp')">Cancelar</button>
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
                loginid: {
                  minlength: 2,
                  maxlength: 10,
                  required: true
                },
                email: {
                  required: true,
                  email: true
                },
                nombresapellidos: {
                  minlength: 3,
                  maxlength: 50,
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
    	 			url: './bin/Users',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "users.jsp" );
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