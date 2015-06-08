<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.ProveedorBean"%>
<%@page import="com.urbau.beans.PaisBean"%>
<%@page import="com.urbau.beans.MonedaBean"%>
<%@page import="com.urbau.feeders.ProveedoresMain"%>
<%@page import="com.urbau.feeders.MonedasMain"%>
<%@page import="com.urbau.feeders.PaisesMain"%>
      
<%	
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			ProveedoresMain proveedores_main = new ProveedoresMain();
			PaisesMain paises_main = new PaisesMain();
			MonedasMain monedas_main = new MonedasMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			ProveedorBean bean = proveedores_main.get( id );
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE PROVEEDOR</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="proveedores.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" id="form" name="form">
                      <input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>">
                      <input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>">
                      <input type="hidden" name="idPais" id="idPais" value="<%= bean.getPais()%>">
                      <input type="hidden" name="idMoneda" id="idMoneda" value="<%= bean.getMoneda()%>">
                      
                      
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nit</label>
                              <div class="col-sm-10">                              		                          	
	                          		<input type="text" class="form-control" name="nit" id="nit" value="<%= bean.getNit() %>">	                          	                          	                          	   	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">C&oacute;digo</label>
                              <div class="col-sm-10">                              		                          	
	                          		<input type="text" class="form-control" name="codigo" id="codigo" value="<%= bean.getCodigo() %>">	                          	                          
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nombre y Apellido</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="nombre" id="nombre" value="<%= bean.getNombre() %>">	                          	                          	                          	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Raz&oacute;n Social</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="razonsocial" id="razonsocial" value="<%= bean.getRazonSocial() %>">	                          	                          	                          	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Cont&aacute;cto</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="contacto" id="contacto" value="<%= bean.getContacto() %>">	                          	                          	                          	                                 
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
	                          		<input type="email" class="form-control" name="correo" id="correo" value="<%= bean.getEmail() %>">	                          	                          	                          	                             
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Pa&iacute;s</label>
                              <div class="col-sm-10">
                                  <select class="form-control" name="pais" id="pais">
                                  <%
                                  	ArrayList<PaisBean> paises_list = paises_main.get(null, 0);
                                  	for( PaisBean pais : paises_list ){
                                  		if(bean.getPais() == pais.getId()){
                                  		%>
                                  			<option selected value="<%= pais.getId()%>"><%= pais.getNombre() %></option>
                                  		<%	
                                  		}else{
                                		%>
                                    		<option  value="<%= pais.getId()%>"><%= pais.getNombre() %></option>
                                    	<%                                  		
                                  		}
                                  	} %>									  									  
								 </select>
                              </div>
                          </div>
                                
						 <%if("remove".equals( mode ) || "view".equals( mode ) ){%>	                                
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Moneda</label>
                              <div class="col-sm-10">
                                  <select class="form-control" name="moneda" id="moneda">
                                  <%
                                  	ArrayList<MonedaBean> monedas_list = monedas_main.get(null, 0);
                                  	for( MonedaBean moneda : monedas_list ){
                                  		if(bean.getMoneda() == moneda.getId()){
                                  		%>
                                  			<option  selected value="<%= moneda.getId()%>"><%= moneda.getNombre() %></option>
                                  		<%			
                                  		}else{
                                  		%>
                                  			<option value="<%= moneda.getId()%>"><%= moneda.getNombre() %></option>
                                  		<%	
                                  		}
                                   } 
                                   %>									  									  
								 </select>
                              </div>
                          </div>
                          <%} %>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">L&iacute;mite Cr&eacute;dito</label>
                              <div class="col-sm-10">                              		                          			                          		
	                          		<input type="text" class="form-control" name="limitecredito" id="limitecredito" value="<%= bean.getLimiteCredito() %>">	                          	                          	                          	                                 
                              </div>
                          </div>
                                
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Saldo</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="saldo" id="saldo" value="<%= bean.getSaldo() %>">	                          	                          	                          	
                              </div>
                          </div>                                                    
                          <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('proveedores.jsp')">Cancelar</button>
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
                codigo: {
                    minlength: 2,
                    maxlength: 15,
                    required: true
                  },
                nombre: {
                    minlength: 3,
                    maxlength: 50,
                    required: true
                  },
                razonsocial: {
                    minlength: 3,
                    maxlength: 50                  
                  },    
                contacto: {
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
                email: {
                  required: true,
                  email: true
                },
                limitecredito: {
                    required: true                    
                  },
                saldo: {
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
    	 			url: './bin/Proveedores',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		      
    		        	alert(msg);
    		            location.replace( "proveedores.jsp" );
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
    			$("#codigo").attr('disabled','disabled');
    			$("#nombre").attr('disabled','disabled');
    			$("#razonsocial").attr('disabled','disabled');
    			$("#contacto").attr('disabled','disabled');
    			$("#direccion").attr('disabled','disabled');
    			$("#telefono").attr('disabled','disabled');
    			$("#correo").attr('disabled','disabled');
    			$("#limitecredito").attr('disabled','disabled');
    			$("#saldo").attr('disabled','disabled');    			
    			$("#pais").attr('disabled','disabled');
    			$("#moneda").attr('disabled','disabled');
    			$("#activo").attr('disabled','disabled');
    			
    			$("#savebutton").removeClass("btn btn-success");
    			$("#savebutton").addClass("btn btn-danger");
    			$("#savebutton").html("Borrar");						
    		}else if(mode === "view"){
    			$("#nit").attr('disabled','disabled');
    			$("#codigo").attr('disabled','disabled');
    			$("#nombre").attr('disabled','disabled');
    			$("#razonsocial").attr('disabled','disabled');
    			$("#contacto").attr('disabled','disabled');
    			$("#direccion").attr('disabled','disabled');
    			$("#telefono").attr('disabled','disabled');
    			$("#correo").attr('disabled','disabled');
    			$("#limitecredito").attr('disabled','disabled');
    			$("#saldo").attr('disabled','disabled');    			
    			$("#pais").attr('disabled','disabled');
    			$("#moneda").attr('disabled','disabled');
    			
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