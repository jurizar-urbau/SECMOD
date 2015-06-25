<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="com.urbau.beans.ProveedorBean"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page import="com.urbau.feeders.ProveedoresMain"%>
      
<%	
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			ProductosMain productos_main = new ProductosMain();
			ProveedoresMain proveedores_main = new ProveedoresMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			
			ProductoBean bean = productos_main.get( id );						
			
			int idProveedor = proveedores_main.get(bean.getProveedor()).getId();			
			String mode = request.getParameter( "mode" );												
			String imagePath = bean.getImage_path();			
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
                  	  
                      <form class="form-horizontal style-form" id="form">
                      	<input type="hidden" name="mode" id="mode"value="<%= mode%>">
                      	<input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>">
                      	<input type="hidden" name="idProveedor" id="idProveedor" value="<%=idProveedor%>">
                      	<input type="hidden" name="imagePath" id="imagePath" value="<%=imagePath%>">
                      	 
                      	
                       
                      
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Codigo</label>
                              <div class="col-sm-10">                	                          	
	                          		<input type="text" class="form-control" name="codigo" id="codigo" value="<%= bean.getCodigo() %>">	                          	                          	                          	   	                                 
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Descripci&oacute;n</label>
                              <div class="col-sm-10">                              		                          		
	                          		<input type="text" class="form-control" name="descripcion" id="descripcion" value="<%= bean.getDescripcion() %>">	                          	                          	                          	                                
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Coeficiente de unidad</label>
                              <div class="col-sm-10">                              		                          		
	                          		<input type="text" class="form-control" name="coeficiente_unidad" id="coeficiente_unidad" value="<%= bean.getCoeficiente_unidad() %>">	                          	                          	                          	                                
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Proveedor</label>
                              <div class="col-sm-10">
                              
                              		<select class="form-control" name="proveedor" id="proveedor">
	                                  <%
	                                  	ArrayList<ProveedorBean> proveedores_list = proveedores_main.get(null, 0);
	                                  	for( ProveedorBean proveedor : proveedores_list ){
	                                  %>
	                                  	<option value="<%= proveedor.getId()%>"><%= proveedor.getNombre() %></option>
	                                  <% } %>									  
									  
									</select>
                              	
                                  
                              </div>
                          </div>
                           <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Precio</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="precio" id="precio" value="<%= bean.getPrecio() %>">	                          	                          	                         
                                  
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Precio importaci&oacuten;</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="text" class="form-control" name="precio_importacion" id="precio_importacion" value="<%= bean.getPrecio_importacion() %>">	                          	                          	                          	                                  
                              </div>
                          </div>
                                                    
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Stock Minimo</label>
                              <div class="col-sm-10">                              		                          			                          	
	                          		<input type="number" class="form-control" name="stock_minimo" id="stock_minimo" value="<%= bean.getStock_minimo() %>">	                          	                          	                          	                                  
                              </div>
                          </div>
                          
                          <div class="form-group">
                          	
                           	<label class="col-sm-2 col-sm-2 control-label">Imagen</label>   
                                                           
							<%if( "add".equals( mode ) || "edit".equals( mode ) ){%>
                            <div class="col-sm-10">                                                                          	                          			                          	
                       			<input type="file" class="form-control" name="image_path" id="image_path">	                          	                          	                                      
                            </div>
                            <br><br>
                            <%}%>
                            
                            <%if( !"add".equals( mode )){%>
                            
                            <label class="col-sm-2 col-sm-2 control-label"></label>
                       		<div class="col-sm-10">
                           		<img src="http://localhost:8080/urbautree-secmod/bin/RenderImage?imagePath=<%= bean.getImage_path() %>" width="100px">
                            </div>
                            <%}%>                                                           
                          </div>                          
                                                    		         		         
                          </div>
                          
                           <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('productos.jsp?mode=cancel')">Cancelar</button>
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
    		    	
    		$('form#form').submit(function(e){
    			e.preventDefault();
    		    		    	    		    			    		    	
    			var formData = new FormData(this);
    			
    	     	$.ajax({
    	     		type:'POST',
    	 			url: './bin/Productos',    	 			
    	 			data: formData,
    	 			async: false,
    	 		    cache: false,
    	 		    contentType: false,
    	 		    processData: false,
    	 		   dataType: "text",
    	 			
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
    			$("#codigo").attr('disabled','disabled');
    			$("#descripcion").attr('disabled','disabled');
    			$("#coeficiente_unidad").attr('disabled','disabled');
    			$("#proveedor").attr('disabled','disabled');
    			$("#precio").attr('disabled','disabled');
    			$("#precio_importacion").attr('disabled','disabled');
    			$("#image_path").attr('disabled','disabled');
    			$("#stock_minimo").attr('disabled','disabled');
    			
    			$("#savebutton").removeClass("btn btn-success");
    			$("#savebutton").addClass("btn btn-danger");
    			$("#savebutton").html("Borrar");						
    		}else if(mode === "view"){
    			
    			$("#codigo").attr('disabled','disabled');
    			$("#descripcion").attr('disabled','disabled');
    			$("#coeficiente_unidad").attr('disabled','disabled');
    			$("#proveedor").attr('disabled','disabled');
    			$("#precio").attr('disabled','disabled');
    			$("#precio_importacion").attr('disabled','disabled');
    			$("#image_path").attr('disabled','disabled');
    			$("#stock_minimo").attr('disabled','disabled');
    			    		
    			$("#savebutton").hide();    			    	    	
    			
    		}
    		
    		// select option by id 
    		var idProveedor = $("#idProveedor").val();    		    	
    		if(idProveedor){
    			$("#proveedor option[value="+idProveedor+"]").attr('selected','selected');    			
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