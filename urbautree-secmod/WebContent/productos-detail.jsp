<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
      
<%
	
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			ProductosMain rm = new ProductosMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			ProductoBean bean = rm.getProducto( id );
			
			String cmd = "Nuevo producto";
			String mode = request.getParameter( "mode" );
			
			String keyReadOnly = "readonly=\"readonly\"";
			String optionalReadOnly = "";
			String mandatoryReadOnly = "";
			String jsFunction = "save();";
			String validateUser = "";
			if( "edit".equals( mode ) ){
				cmd = "Editar producto " + id;
				mandatoryReadOnly = keyReadOnly;
				jsFunction = "edit();";
			} else if( "view".equals( mode )){
				cmd = "Ver producto " + id;
				mandatoryReadOnly = keyReadOnly;
				optionalReadOnly = keyReadOnly;
			} else if( "remove".equals(mode) ){
				cmd = "Eliminar producto " + id;
				optionalReadOnly = keyReadOnly;
				mandatoryReadOnly = keyReadOnly;
				jsFunction = "deleteReg();";
			} else {
				validateUser = "onchange=\"validateUser(this.value)\"";
			}
			
			
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE PRODUCTO</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="productos.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" id="form" name="form">
                      <input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>">
                      <input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>">
                      
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Codigo</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
	                          		<input type="text" class="form-control" name="codigo" id="codigo" value="<%= bean.getCodigo() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="codigo" id="codigo" disabled value="<%= bean.getCodigo() %>">	                          		
	                          	<%}%>   	                                  
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Descripci&oacute;n</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
	                          		<input type="text" class="form-control" name="descripcion" id="descripcion" value="<%= bean.getDescripcion() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="descripcion" id="descripcion" disabled value="<%= bean.getDescripcion() %>">	                          			                          	
	                          	<%}%>                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Coeficiente de unidad</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
	                          		<input type="text" class="form-control" name="coeficiente_unidad" id="coeficiente_unidad" value="<%= bean.getCoeficiente_unidad() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="coeficiente_unidad" id="coeficiente_unidad" disabled value="<%= bean.getCoeficiente_unidad() %>">	                          			                          	
	                          	<%}%>                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Proveedor</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          			                          		
	                          		<input type="text" class="form-control" name="proveedor" id="proveedor" value="<%= bean.getProveedor() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="proveedor" id="proveedor" disabled value="<%= bean.getProveedor() %>">	                          			                          	
	                          	<%}%>
                                  
                              </div>
                          </div>
                           <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Precio</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          			                          		
	                          		<input type="text" class="form-control" name="precio" id="precio" value="<%= bean.getPrecio() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="precio" id="precio" disabled value="<%= bean.getPrecio() %>">	                          			                          	
	                          	<%}%>
                                  
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Precio importaci&oacuten;</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          			                          		
	                          		<input type="text" class="form-control" name="precio_importacion" id="precio_importacion" value="<%= bean.getPrecio_importacion() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="precio_importacion" id="precio_importacion" disabled value="<%= bean.getPrecio_importacion() %>">	                          			                          	
	                          	<%}%>
                                  
                              </div>
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Imagen</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          			                          		
	                          		<input type="text" class="form-control" name="image_path" id="image_path" value="<%= bean.getImage_path() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="image_path" id="image_path" disabled value="<%= bean.getImage_path() %>">	                          			                          	
	                          	<%}%>
                                  
                              </div>
                          </div>
                          
                          </div>
                          
                           <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('productos.jsp')">Cancelar</button>
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
                nombre: {
                  minlength: 2,
                  maxlength: 30,
                  required: true
                },
                direccion: {
                	minlength: 2,
                    maxlength: 250,
                    required: true
                },
                telefono: {
                	minlength: 2,
                    maxlength: 15,
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
    	 			url: './bin/Productos',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "productos.jsp" );
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