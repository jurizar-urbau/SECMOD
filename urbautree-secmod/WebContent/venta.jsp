<%@page import="com.urbau.beans.ClienteBean"%>
<%@page import="com.urbau.feeders.ClientesMain"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page pageEncoding="utf-8" %>
<%@page import="com.urbau.feeders.BodegasMain"%>
<% 
	BodegasMain bm = new BodegasMain();
    ProductosMain pm = new ProductosMain();
	long total_bodegas = bm.count();
	long total_productos = pm.count();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<script>
		function setClient(){
			
			
		}
		
		function clickon( id ){
			var ele = $( "#product-" + id );
			ele.trigger('click');
			console.log( 'clicking:', ele );
		
		} 
		function searchProducts( q ){
			// select DESCRIPCION,CODIGO,COEFICIENTE_UNIDAD,PRECIO,PRECIO_1,PRECIO_2,PRECIO_3,PRECIO_4 from productos where descripcion like '%P0%' or codigo like'%P0%' or ID in (select id_producto from Alias where descripcion like '%P0%');
			console.log( "looking for products with [" + q + "]");
			$( "#product-container" ).html("");
			 $.get( "./bin/searchp?q=" + q, null, function(response){
                 $.each(response, function(i, v) {
                	 console.log( i, v );
                	 
                	 var rootele;
                	 
                	 var htmltoadd = 
              "<a  href=\"javascript: clickon('" + v.id + "');\">" + 
                     "<div class=\"col-md-3 col-sm-3 mb\">" +
                       "<div class=\"white-panel pn\">" +
                         "<div class=\"white-header\">" +
                 "<h5 style=\"color:red\">" + v.descripcion + "</h5>" +
                         "</div>" +
             "<div class=\"row\">" +
               "<div class=\"col-sm-6 col-xs-6 goleft\">" +
                 "<p><i class=\"fa fa-heart\"></i>" + v.codigo +"</p>" +
               "</div>" +
               "<div class=\"col-sm-6 col-xs-6\"></div>" +
                         "</div>" +
                         "<div class=\"centered\">" +
                         
                 "<img src=\"./bin/RenderImage?imagePath=" + v.imagepath + "\" width=\"90\">" +
                 "<p style=\"color:red\">"+ v.precio_1 +"</p>" +
                  "       </div>" +
                  "     </div>" +
                  "   </div>" +
         "</a>";
         			$( "#product-container" ).append( htmltoadd );
                	
                	 
                 });
              });
		}
	</script>
	<style>
		div.separator {
		    margin-top: 30px;
		}
	</style>
	</head>
   
   <body>
   
<!-- div id="fb-root"></div>  FACEBOOK DIV -->
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
          <section class="wrapper">

              <div class="row">
                  <div class="col-lg-9  main-chart">
                      <div class="row mt">
                      <div class="col-lg-12" onclick="chooseClient()">
                      	Cliente: <b><span id="clientdisplay"></span></b>
                      </div>
                      <div class="col-lg-12">
		          		<form>
			          		<div class="top-menu">
					              <ul class="nav pull-right top-menu">
					              		<li><input type="text" class="form-control" id="search-query-3" name="q" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
					                    <li><button class="btn btn-primary">Buscar</button></li>
					              </ul>
				            </div>
					    </form>
					  </div>
					  <br/><br/><br/>
                      <!-- SERVER STATUS PANELS -->
                     
                        <%
                        	ArrayList<ProductoBean> plist = pm.get(null, 0 );
                        for( ProductoBean pbean: plist ){
                            %>
    			<a data-toggle="modal" href="venta.jsp#myModal<%= pbean.getId() %>" id="product-<%= pbean.getId() %>"></a>
    			<% } 
                        %>    	
                        <%
                        	for( ProductoBean pbean: plist ){
                        %>
						
             <div aria-hidden="true" aria-labelledby="myModalLabel<%= pbean.getId() %>" role="dialog" tabindex="-1" id="myModal<%= pbean.getId() %>" class="modal fade">
						<form id="modalform" name="modalform">
						<input name="productid" type="hidden" value="<%= pbean.getId() %>">
						<input name="price"  type="hidden" value="<%= pbean.getPrecio() %>">
 			              <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Agregar a orden...</h4>
			                      </div>
			                      <div class="modal-body col-lg-12">
			                      <div class="col-sm-6">
			                      	<img src="./bin/RenderImage?imagePath=<%= pbean.getImage_path() %>" width="220">
			                      	</div>
			                      	<div class="col-sm-6">
			                      	<h3><%= pbean.getDescripcion() %></h3>
			                      	<hr/>
			                          <p>Cantidad</p>
			                          <input type="text" name="cantidad" autocomplete="off" class="form-control placeholder-no-fix" value="1">
			                          </br>
			                          <p>Precio unitario:</p>
			                          <input type="text" name="precio" autocomplete="off" class="form-control placeholder-no-fix" value="<%= pbean.getPrecio() %>">
			                          </br>
			                          <p>Precio 1:</p>
			                          <input type="text" name="precio1" autocomplete="off" class="form-control placeholder-no-fix" value="<%= pbean.getPrecio_1() %>">
			                          </br>
			                          <p>Precio 2:</p>
			                          <input type="text" name="precio2" autocomplete="off" class="form-control placeholder-no-fix" value="<%= pbean.getPrecio_2() %>">
			                          </br>
			                          <p>Precio 3:</p>
			                          <input type="text" name="precio3" autocomplete="off" class="form-control placeholder-no-fix" value="<%= pbean.getPrecio_3() %>">
			                          </br>
			                          <p>Precio 4:</p>
			                          <input type="text" name="precio4" autocomplete="off" class="form-control placeholder-no-fix" value="<%= pbean.getPrecio_4() %>">
			                          </div>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="addSale('<%= pbean.getId() %>','<%= pbean.getImage_path() %>','<%= pbean.getDescripcion() %>','<%= pbean.getPrecio() %>','1');">Agregar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>         
            <% } %>
            <div id="product-container" class="separator">
                        
					</div> <!--  content -->
                    </div><!-- /row -->
                     	
                            
          
          
          
          
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  <div class="col-lg-3 ds">
                   <h3>ORDEN ACTUAL</h3>
                   <div class="desc">
                        <div style="float:left">
                          Total:
                        </div>
                        <div class="details">
                          <p style="color:blue; font-size:18pt; text-align: right;">
                             Q 180.00
                          </p>
                        </div>
                      </div>  
                   <div id="sale-container">
                                      
                      
                      
                  </div>
                  </div>
              </div><!--/row -->
          </section>
      </section>
      	 
					<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione un cliente...</h4>
			                          <span class="pull-right">
			          				  	<a data-toggle="modal" class="btn btn-success" href="venta.jsp#myModalNewClient">+</a>          				  
			          				  </span>
			                          
			                      </div>
			                      <div class="modal-body">
				                      <%
											ClientesMain um = new ClientesMain();			
											int from = 0;
											if( request.getParameter( "from" ) != null ){
												from = Integer.parseInt( request.getParameter( "from" ) );
											}
											
											ArrayList<ClienteBean> list = um.get( request.getParameter("q"), from );
											int total_regs = -1;
											
											if( list.size() > 0 ){
												total_regs = ((ClienteBean)list.get( 0 )).getTotal_regs();
											}
										%>
										 <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	  <thead>
                              <tr>
                                  <th></th>
                                  <th>Nit</th>                                  
                                  <th>Nombres</th>
                                  <th>Apellidos</th>                                                                    
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for(ClienteBean bean: list ){
                              %>
                              <tr>
                              	  <td><input type="radio" name="clienteid" value="<%= bean.getId() %>,<%= bean.getNombres() + " " + bean.getApellidos()  %>"></td>
                                  <td><%= bean.getNit() %></td>                                  
                                  <td><%= bean.getNombres() %></td>
                                  <td><%= bean.getApellidos() %></td>         
                                                                            
                                  
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setClient();">Seleccionar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>
		          
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModalNewClient" class="modal fade">
						<form id="modalformnewclient" name="modalformnewclient" >
						<input type="hidden" name="mode" id="mode"value="add">
						<input type="hidden" name="id" id="id" value="-1">
						<input type="hidden" name="modal" id="modal" value="true">
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Crear cliente...</h4>
			                      </div>
			                      <div class="modal-body">
			                      
			                  <table class="table table-striped table-advance table-hover">
	                  	  	  <tbody>
                                  <tr>
	                                  <td>Nit</td>
	                                  <td><input type="text" class="form-control" name="nit" id="nit" value=""></td>                                  
	                              </tr>
	                               <tr>
	                                  <td>Nombres</td>
	                                  <td><input type="text" class="form-control" name="nombres" id="nombres" value=""></td>                                  
	                               </tr>
	                               <tr>
	                                  <td>Apellidos</td>
	                                  <td><input type="text" class="form-control" name="apellidos" id="apellidos" value=""></td>                                  
	                               </tr>
	                               <tr>
	                                  <td>Direcci&oacute;n</td>
	                                  <td><input type="text" class="form-control" name="direccion" id="direccion" value=""></td>                                  
	                               </tr>
	                               <tr>
	                                  <td>Tel&eacute;fono</td>
	                                  <td><input type="text" class="form-control" name="telefono" id="telefono" value=""></td>                                  
	                               </tr>
	                               <tr>
	                                  <td>Correo Electr&oacute;nico</td>
	                                  <td><input type="text" class="form-control" name="correo" id="correo" value=""></td>                                  
	                               </tr>
	                               <tr>
	                                  <td>Tipo De Cliente</td>
	                                  <td><select class="form-control" name="tipodecliente" id="tipodecliente" >
	                          			<option value="interno">Interno</option>
	                          			<option value="interno">Externo</option>
	                          		</select></td>                                  
	                               </tr>
                              </tbody>
                          </table>
			               
                                          </div>                                                                                                                                                                          
                         <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="saveclientbutton">Guardar</button>
			                      </div>
                                                                                                                           
                      
				                      
			                      
			                      
			                  </div>
			              </div>
		              </form>
		          </div>
		          
      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <div class="text-center">
               <a href="http://www.urbau-digital.com">2015 - Urbau Digital</a>
              <a href="home.jsp" class="go-top">
                  <i class="fa fa-angle-up"></i>
              </a>
          </div>
      </footer>
      <!--footer end-->
  </section>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/jquery-1.8.3.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="assets/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="assets/js/jquery.scrollTo.min.js"></script>
    <script src="assets/js/jquery.nicescroll.js" type="text/javascript"></script>
    <script src="assets/js/jquery.sparkline.js"></script>


    <!--common script for all pages-->
    <script src="assets/js/common-scripts.js"></script>
    
    <script type="text/javascript" src="assets/js/gritter/js/jquery.gritter.js"></script>
    <script type="text/javascript" src="assets/js/gritter-conf.js"></script>

    <!--script for this page-->
  
  
  <script type="text/javascript">
  		  var selected_client_id;
  		  var allowed_prices;
  		  
		  function parseSecond(val) {
			    var result = "Not found",
			        tmp = [];
			    var items = location.search.substr(1).split("&");
			    for (var index = 0; index < items.length; index++) {
			        tmp = items[index].split("=");
			        if (tmp[0] === val) result = decodeURIComponent(tmp[1]);
			    }
			    return result;
			}
  
		    function setClient(){
		    	var value = $('input[name=clienteid]:checked').val();
		    	var values = value.split(',');
		    	console.log('cliente', values[0]);
				$('#clientdisplay').html(value);
		    	hideClient();
		    }
  			function addSale( productid, imagepath, productname, price, amount ){
  				var htmltoadd =
  					  "<div class=\"desc\">" +
		              "  <div style=\"float:left\">" +
		              "    <img width=\"70\" src=\"./bin/RenderImage?imagePath=" + imagepath + "\">" +
		              "  </div>" +
		              "  <div class=\"details\">" +
		              "    <p style=\"color:black; font-size:12pt\">" +
		              "       <span style=\"color:red; font-size:20pt\">" + amount + "</span>" + productname + "<br/> Q" + price + " " +
		              "    </p>" +
		              "  </div>" +
		              "</div>";
  				$( "#sale-container" ).append( htmltoadd );
  				hideModal('#myModal' + productid );
  			}
  			function chooseClient(){
  				$('#myModal').modal('show');
  			}
  			function hideModal( id ){
  				$(id).modal('hide');
  			}
  			function hideClient(){
  				$('#myModal').modal('hide');
  			}
  			function hideNewClient(){
  				$('#myModalNewClient').modal('hide');
  			}
  			$("#saveclientbutton").click(function(){
				
    			var form =$('#modalformnewclient');
    	     	$.ajax({
    	     		type:'POST',
    	     		dataType: "text",
    	 			url: './bin/Clientes',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		      
    		        	
    		        	if( msg.startsWith('clientid') ){
    		        		alert( "Cliente creado con exito." );
    		        		var ci = msg.substring( 10 );
    		        		var values = ci.split(',');
    				    	$('#clientdisplay').html(ci);
    				    	hideClient();
    				    	hideNewClient();
    		        		
    		        	}
    		            //location.replace( "clientes.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operaciòn");	
    	 			}
    		            		        
    	       });
    	     	
    	     	return false;
    	 	});
  			if (typeof String.prototype.startsWith != 'function') {
  			  // see below for better implementation!
  			  String.prototype.startsWith = function (str){
  			    return this.indexOf(str) === 0;
  			  };
  			}
	</script>  
	
	<script type="text/javascript">
	    $(window).load(function(){
	        $('#myModal').modal('show');
	        
	        $( "#search-query-3" ).keyup(function() {
	        	var value = $( "#search-query-3" ).val();
	        	console.log( "value", value );
	        	searchProducts( value );
			});
	    });
	</script>
  </body>
</html>
