<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
    
<%						

		
		BodegasMain bodegaMain = new BodegasMain();
		ProductosMain productoMain = new ProductosMain();
		
		
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				location.replace( "paises.jsp");
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
          
          	<h3><i class="fa fa-angle-right"></i> INGRESO DE PRODUCTOS</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="paises.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" method="POST" id="form" name="form">
                      	                      
                      	
                      	<input type="hidden" name="id" value="<%= request.getParameter("id")%>">                      
                                                          		
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
                      	
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Producto</label>
                          	<div class="col-sm-10">
								<select class="form-control" name="producto" id="producto">
								<option value=""></option>
								  <%
								  	ArrayList<ProductoBean> productoList = productoMain.get(null, 0);
								  	System.out.println(">>> productoList Size ::: " + productoList.size());
								  	for( ProductoBean producto : productoList ){
								  %>
							  		<option value="<%= producto.getId()%>"><%= producto.getDescripcion() %></option>
							  	  <% } %>									  
							  	  												  
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
		        coin: {			          
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
			$name = $("#name");
			$coin = $("#coin");								
    		
    		    		    		
    		
    		$.ajax({
				url: './bin/MonedasList',
	     		type:'POST',    	 				 		            	 		
		        success: function(data, textStatus, jqXHR){		        			        	 		        		        			        	
		        	
		        	if(data instanceof Array){
		        		
		        		for(var i=0; i < data.length; i++){		        					        		
		        			if(data[i].name){		        				
		        				if(coin === String(data[i].id)){		        					
		        					$coin.append($("<option />").val(data[i].id).text(data[i].name).attr('selected',true));	
		        				}else{
		        					$coin.append($("<option />").val(data[i].id).text(data[i].name));
		        				}
			        				
		        			}
		        					        	                                    	                    		                    	
		        		}
		        	}
		            		        	
		        },
	 			error: function(jqXHR, textStatus, errorThrown){
	 				console.log("ERROR srtatus: ", textStatus);
	 				console.log("ERROR errorThrown: ", errorThrown);
	 				console.log("ERROR jqXHR: ", jqXHR);
	 				alert("Se prudujo un error al hacer la operacion");	
	 			}
		            		        
	       });
			
			
			$savebutton.click(function(){
				
				if($name.val() && $coin.val()){
					
					var form =$('#form');					
		     		$.ajax({
			     		type:'POST',
			 			url: './bin/Paises',
			 			data: form.serialize(),
			 			dataType: "text",		 			
				        success: function(msg){				        	
				        	alert(msg);
				            location.replace( "paises.jsp" );
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
				$name.attr('disabled','disabled');				
				$coin.attr('disabled','disabled');
				$savebutton.removeClass("btn btn-success");
				$savebutton.addClass("btn btn-danger");
				$savebutton.html("Borrar");
				
			}else if(mode === "view"){				
				$name.attr('disabled','disabled');
				$coin.attr('disabled','disabled');
				$savebutton.hide();
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
