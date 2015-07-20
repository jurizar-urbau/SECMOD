<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.PreciosClienteBean"%>
<%@page import="com.urbau.feeders.PreciosClientesMain"%>

<%@page import="com.urbau.feeders.PreciosMain"%>
<%@page import="com.urbau.beans.PrecioBean"%>    
<%				
	
	String clienteParameter = request.getParameter("cliente");
	int idCliente  = -1;
	try{
		idCliente = Integer.parseInt(clienteParameter);	
	}catch(NumberFormatException e){
		System.out.print("Error to parse a string to int for cliente parameter : message : "+ e.getMessage());
	}
	
	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" )) && idCliente >= 0 ){

		int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
		
		
		PreciosClientesMain main = new PreciosClientesMain();		
		PreciosClienteBean bean = main.get( idCliente );		
		
		PreciosMain preciosMain = new PreciosMain();
		String mode = request.getParameter( "mode" );				
		
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				var cliente = <%=idCliente%>;
				location.replace( "cliente_precios.jsp?cliente="+cliente);
			}			
		</script>
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE INVENTARIO</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="cliente_precios.jsp?cliente=<%=idCliente %>">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" method="POST" id="form" name="form">
                      	                      
                      	<input type="hidden" name="mode" value="<%= mode%>">
						<input type="hidden" name="id" value="<%= id%>">
                      	<input type="hidden" name="cliente" value="<%= idCliente%>">
                      	<input type="hidden" name="idPrecioBorrar" value="<%= request.getParameter("precio")%>">                      	                                                                  	
                                                          		                      	
                      	<div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Producto</label>
                              <div class="col-sm-10">
                              
                              		<select class="form-control" name="precio" id="precio">
	                                  <%
	                                  	ArrayList<PrecioBean> precioList = preciosMain.get(null, 0);
	                                  	for( PrecioBean precio : precioList ){
	                                  %>
	                                  	<option value="<%= precio.getId()%>"><%= precio.getNombre() %></option>
	                                  <% } %>									  
									  
									</select>
                              	
                                  
                              </div>
                        </div>
                          
                          
                      	<!-- 
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Estatus</label>
                          	<div class="col-sm-10">                          	            
								<input type="text" class="form-control" name="estatus" id="estatus" value="">	                          	                                                                                                  
                          	</div>
                      	</div>
                      	
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Cantidad</label>
                          	<div class="col-sm-10">                          	            
								<input type="text" class="form-control" name="cantidad" id="cantidad" value="">	                          	                                                                                                  
                          	</div>
                      	</div>
                          
                           -->
                       <div class="form-actions">
       	    				<button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
			            	<button class="btn" onclick="back()">Cancelar</button>
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
	    	
	     	$('#form').validate({
		      rules: {                        		  
		        precio: {			    
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
	    });                                  
	</script>
	<script>
	
		$(function() {
		//twitter bootstrap script
					
			$('#form').submit(function(e){
				e.preventDefault();
			});
			
			$savebutton  = $("#savebutton");
			$precio = $("#precio");
						
			$savebutton.click(function(){
				
				console.log("precio: ", $precio.val());
				if($precio.val()){		
					
					var form =$('#form');					
		     		$.ajax({
			     		type:'POST',
			 			url: './bin/PreciosCliente',
			 			data: form.serialize(),
			 			dataType: "text",		 			
				        success: function(msg){				        	
				        	alert(msg);
				        	var cliente = getUrlParameter('cliente');
				            location.replace( "cliente_precios.jsp?cliente="+cliente );
				        },
			 			error: function(jqXHR, textStatus, errorThrown){
			 				console.log("ERROR srtatus: ", textStatus);
			 				console.log("ERROR errorThrown: ", errorThrown);
			 				alert("Se prudujo un error al hacer la operaciòn");	
			 			}
		       		});
						
				}						
	     		return false;
	 		});
				 
		
			var mode = getUrlParameter('mode');		
			if(mode === "remove"){
				$precio.attr('disabled','disabled');		
				
				$savebutton.removeClass("btn btn-success");				
				$savebutton.addClass("btn btn-danger");
				$savebutton.html("Borrar");
				
			}else if(mode === "view"){				
				$precio.attr('disabled','disabled');
								
				$savebutton.hide();
			}			
			
			
			
			// select option by id 
    		var idPrecio = getUrlParameter('precio');
			console.log("idPrecio: " ,idPrecio);
    		if(idPrecio){
    			$("#precio option[value="+idPrecio+"]").attr('selected','selected');    			
    		}
    		
		});
		 
		 
		function getUrlParameter(sParam){
			
		    var sPageURL = window.location.search.substring(1);
		    var sURLVariables = sPageURL.split('&');
		    
		    for (var i = 0; i < sURLVariables.length; i++) {
				var sParameterName = sURLVariables[i].split('=');
		        if (sParameterName[0] == sParam) {
					return sParameterName[1];
		        }
		    }
		} 
		 
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