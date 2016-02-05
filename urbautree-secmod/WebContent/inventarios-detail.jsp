<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.InvetarioBean"%>
<%@page import="com.urbau.feeders.InventariosMain"%>
<%@page import="com.urbau.feeders.ProductosMain"%>    
<%@page import="com.urbau.beans.ProductoBean"%>     

<%				
	ProductosMain pm = new ProductosMain();
	String idBodegaParameter = request.getParameter("bodega");
	int idBodega  = -1;
	try{
		idBodega = Integer.parseInt(idBodegaParameter);	
	}catch(NumberFormatException e){
		System.out.print("Error to parse a string to int for bodega parameter : message : "+ e.getMessage());
	}
	
	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" )) && idBodega >= 0 ){
		int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
		String estatus = request.getParameter( "estatus" );
		InventariosMain main = new InventariosMain();		
		InvetarioBean bean = main.get( id, estatus, idBodega );		
		
		ProductosMain productoMain = new ProductosMain();
		String mode = request.getParameter( "mode" );				
						
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				var bodega = <%=idBodega%>;
				location.replace( "inventarios.jsp?bodega="+bodega);
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE INVENTARIO</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="inventarios.jsp?bodega=<%=idBodega %>">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" method="POST" id="form" name="form">
                      	                      
                      	<input type="hidden" name="mode" value="<%= mode%>">
                      	<input type="hidden" name="id" value="<%= request.getParameter("id")%>">
                      	<input type="hidden" name="bodega" value="<%= request.getParameter("bodega")%>">                      
                      	<input type="hidden" name="estatusremove" value="<%= request.getParameter("estatus")%>">
                                                          		                      	
                      	<div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Producto</label>
                              <div class="col-sm-10">
                              
                              		<select class="form-control" name="producto" id="producto">
	                                  <%
	                                  	ArrayList<ProductoBean> producto_list = productoMain.get(null, 0);
	                                  	for( ProductoBean producto : producto_list ){
	                                  %>
	                                  	<option value="<%= producto.getId()%>"><%= producto.getDescripcion() %></option>
	                                  <% } %>									  
									  
									</select>
                              	
                                  
                              </div>
                        </div>
                          
                                                                                         	
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Cantidad</label>
                          	<div class="col-sm-10">                          	            									                       
								<input type="text" class="form-control" name="cantidad" id="cantidad" value="<%=bean.getAmount()%>">  	                                                                                                  
                          	</div>
                      	</div>
                      	
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Estado</label>
                          	<div class="col-sm-10">                          	 
                          		<select name="estatus" id="estatus" class="form-control">
                          			<option value="a">ACTIVO</option>
                          			<option value="i">INACTIVO</option>
                          			<option value="e">EN TRANSITO</option>
                          		</select>           
                          	</div>
                      	</div>
                          
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
		        name: {
		          minlength: 3,
		          maxlength: 50,
		          required: true
		        },
		        symbol: {
			          minlength: 1,
			          maxlength: 50,
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
			$producto = $("#producto");
			$estatus = $("#estatus");
			$cantidad = $("#cantidad");
			
			$savebutton.click(function(){
				
				if($producto.val() && $estatus.val()){									
					var form =$('#form');					
		     		$.ajax({
			     		type:'POST',
			 			url: './bin/Inventarios',
			 			data: form.serialize(),
			 			dataType: "text",		 			
				        success: function(msg){				        	
				        	alert(msg);
				        	var bodega = getUrlParameter('bodega');
				            location.replace( "inventarios.jsp?bodega="+bodega );
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
				$producto.attr('disabled','disabled');				
				$estatus.attr('disabled','disabled');
				$cantidad.attr('disabled','disabled');
				$savebutton.removeClass("btn btn-success");
				$savebutton.addClass("btn btn-danger");
				$savebutton.html("Borrar");
				
			}else if(mode === "view"){				
				$producto.attr('disabled','disabled');
				$estatus.attr('disabled','disabled');
				$cantidad.attr('disabled','disabled');
				$savebutton.hide();
			}			
			
			
			
			// select option by id 
    		var id = getUrlParameter('id');    		
			console.log("id:" + id);
    		if(id){
    			$("#producto option[value="+id+"]").attr('selected','selected');    			
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