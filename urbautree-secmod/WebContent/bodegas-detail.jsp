<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
      
<%	
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			BodegasMain rm = new BodegasMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			BodegaBean bean = rm.getBodega( id );						
			String mode = request.getParameter( "mode" );
			Boolean estado = bean.getEstado();
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE BODEGA</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="bodegas.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" id="form" name="form">
                      
                      
                      <input type="hidden" name="mode" id="mode" value="<%= request.getParameter( "mode" )%>"> 
                      <input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>">
                      
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nombre</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
	                          		<input type="text" class="form-control" name="nombre" id="nombre" value="<%= bean.getNombre() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="nombre" id="nombre" disabled value="<%= bean.getNombre() %>">	                          		
	                          	<%}%>   	                                  
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Direcci&oacute;n</label>
                              <div class="col-sm-10">
                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
	                          		<input type="text" class="form-control" name="direccion" id="direccion" value="<%= bean.getDireccion() %>">	                          	                          
	                          	<%}else{%>
	                          		<input type="text" class="form-control" name="direccion" id="direccion" disabled value="<%= bean.getDireccion() %>">	                          			                          	
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
                              <label class="col-sm-2 col-sm-2 control-label">Principal</label>
                              <%if( !bean.getExisteBodegaPrincipal() && !bean.getEstadoEsEditable() ){%>
                              <div class="col-sm-10">
	                              <div class="col-sm-6 text-left">
			                      	<input type="checkbox" name="principal" id="principal" data-toggle="switch" />
			                      </div>
		                      </div>
		                      <%} else if(bean.getEstadoEsEditable()){%>
		                      <div class="col-sm-10">
	                              <div class="col-sm-6 text-left">
			                      	<input type="checkbox" name="principal" id="principal" data-toggle="switch" />
			                      </div>
		                      </div>
		                      	
		                      <%}%>
                          </div>
                                                                           
                          </div>
                          
                           <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('bodegas.jsp')">Cancelar</button>
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
    	 			url: './bin/Bodegas',
    	 			data: form.serialize(),
    	 			dataType: "text",    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "bodegas.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operacion");	
    	 			}
    		            		        
    	       });
    	     	
    	     	return false;
    	 	});
    				 
    		
    		var estado  = <%= estado%>;    		    	    
    		if(estado){    			
    			$("#principal").prop('checked', true);
    		}
    		
    		
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