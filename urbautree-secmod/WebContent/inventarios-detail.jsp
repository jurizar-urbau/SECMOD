<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.InvetarioBean"%>
<%@page import="com.urbau.feeders.InventariosMain"%>
<%@page import="com.urbau.feeders.ProductosMain"%>    
<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.beans.ProductoBean"%>     
<%@page import="com.urbau.beans.BodegaBean"%>

<%				
	ProductosMain pm = new ProductosMain();
	
	String mode = request.getParameter( "mode" );
	String idBodegaParameter = request.getParameter("bodega");
	
	Boolean fromInventario = true;
	String fromInventarioParameter = request.getParameter("fromInventario");
	if(null != fromInventarioParameter){
		fromInventario = false;	
	}
	
	String idParameter = request.getParameter( "id" );
	
	int idBodega  = -1;
	try{
		idBodega = Integer.parseInt(idBodegaParameter);	
	}catch(NumberFormatException e){
		System.out.print("Error to parse a string to int for bodega parameter : message : "+ e.getMessage());
	}
	
	if((idParameter != null || "add".equals( mode) || "addModal".equals(mode) && idBodega >= 0) || !fromInventario  ){

		int id = -1;
		if(null != idParameter){
			id = Integer.valueOf( idParameter );
		}
					
		String estatus = request.getParameter( "status" );
		
		InventariosMain main = new InventariosMain();		
		InvetarioBean bean = main.get( id, estatus, idBodega );		
	
		BodegasMain bodegaMain = new BodegasMain();
		ProductosMain productoMain = new ProductosMain();
						
				
		ArrayList<ProductoBean> list = pm.get(null, 0);
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				var bodega = <%=idBodega%>;
				var fromInventario = <%= fromInventario  %>;

				if(fromInventario){
					location.replace( "inventarios.jsp?bodega="+bodega);	
				}else{
					location.replace("home.jsp");					
				}				
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
						<%if(fromInventario ){ %> 			   
                  			<h4 class="mb"><i class="fa fa-angle-left"></i><a href="inventarios.jsp?bodega=<%=idBodega %>">&nbsp;Regresar</a> </h4>
                  		<%}%>	
                  	  
                      	<form class="form-horizontal style-form" method="POST" id="form" name="form">
                      	                      
	                      	<input type="hidden" name="mode" value="<%= mode%>">
	                      	<input type="hidden" name="id" value="<%= request.getParameter("id")%>">	                      	                     
	                      	<input type="hidden" name="estatusremove" value="<%= request.getParameter("estatus")%>">
                                                    
							<%if(fromInventario ){ %>
							<input type="hidden" name="bodega" value="<%= request.getParameter("bodega")%>">							
							<%}else{%>
							<div class="form-group">                      	
                          		<label class="col-sm-2 col-sm-2 control-label">Bodega</label>
	                          	<div class="col-sm-10">
									<select class="form-control" name="bodega" id="bodega">
									<option value=""></option>
									  <%
									  	ArrayList<BodegaBean> bodegaList = bodegaMain.getBodega(null, 0);
									  	for( BodegaBean bodega : bodegaList ){
									  %>
								  		<option value="<%= bodega.getId()%>"><%= bodega.getNombre() %></option>
								  	  <% } %>									  							  	  												 
								 	</select>
								</div>
                      		</div>
                      		<%}%>							      		             														      		           
							      		                      	                          	                       
                      </form>
                      
                      
					<div id="product-container" class="separator">
                        
					</div> <!--  content -->
                  
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
			
		
			$bodega = $("#bodega");		
			$bodega.click(function(){
				var bodegaSelected = $bodega.val();				
				if(bodegaSelected){
					console.log("BodegaSelected: " , bodegaSelected);
					
					$.ajax({
			     		type:'POST',
			 			url: './bin/ProductosPorBodega',
			 			data: { 
					        'q': null, 
					        'from': null,
					        'bodega':bodegaSelected
					    },			 				 		
			 			success: function(data, textStatus, jqXHR){		        	
        	 		        
				        	$('#product-container > tr:gt(0)').remove();
				        					        	
				        	var trHTML="";
				        	
				        	
				        	if(data instanceof Array){
				        		console.log("data::::  ", data);					        					        		
				        		for(var i=0; i<data.length; i++){
				        			
				        			
				        			trHTML += "<div class='col-md-4 col-sm-4 mb'>";
				        			trHTML += "	<div class='white-panel pn'>";
				        			trHTML += "		<div class='white-header'>";
				        			trHTML += "			<h5>"+data[i].prodDescripcion+"</h5>";    
				        			trHTML += "		</div>";		
				        			trHTML += "		<div class='row'>";    
				        			trHTML += "			<div class='col-sm-6 col-xs-6 goleft'>";				        			
			        				trHTML += "				<p><i class='fa fa-heart'></i> 122</p>";
				        			trHTML += "			</div>";
				        			trHTML += "			<div class='col-sm-6 col-xs-6'></div>";		        
				        			trHTML += "		</div>";
				        			trHTML += "		<div class='centered'>";
				        			trHTML += "			<img src=./bin/RenderImage?imagePath="+data[i].prodImagePath+" width='120'>";
				        			trHTML += "		</div>";			                            			                    						                          			                         
		                            trHTML += "	</div>";
			                        trHTML += "</div>";
			                        			                        
			                        			                            			                            			                					                  
			                				        			
	//trHTML += '<div class="form-actions"><button type="submit" class="btn btn-danger" onClick="removeItem('+data[i].id+')"  idRol="'+data[i].idRol+'" >&nbsp;Borrar&nbsp;</button></div>';	
				        			
				        			
				        			
				        			                                 	                    		                    	
				        		}
				        	}
				            
				        	$('#product-container').append(trHTML);
				        	
				        	
				        },
			 			error: function(jqXHR, textStatus, errorThrown){
			 				console.log("ERROR srtatus: ", textStatus);
			 				console.log("ERROR errorThrown: ", errorThrown);
			 				alert("Se prudujo un error al hacer la operaciòn");	
			 			}
		       		});
					
					
				}
			});
			
			
		
			$('#form').submit(function(e){
				e.preventDefault();
			});
			
			$savebutton  = $("#savebutton");			
			$producto = $("#producto");
			$estatus = $("#status");
			$cantidad = $("#cantidad");
			
			$savebutton.click(function(){
				
				console.log("producto: " , $producto.val() );
				console.log("estatus: " ,$estatus.val());
				
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
				        	if(bodega){
				        		location.replace( "inventarios.jsp?bodega="+bodega );	
				        	}else{
				        		location.replace( "inventarios-detail.jsp?mode=add&fromInventario=false" );
				        	}				        					           
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