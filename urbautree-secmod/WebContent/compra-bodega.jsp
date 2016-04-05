<%@page import="com.urbau.feeders.ProveedoresMain"%>
<%@page import="com.urbau.beans.ProveedorBean"%>
<%@page import="com.urbau.beans.PackingBean"%>
<%@page import="com.urbau.feeders.PackingMain"%>
<%@page import="com.urbau.feeders.BodegasUsuariosMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page pageEncoding="utf-8" %>
<%@page import="com.urbau.feeders.BodegasMain"%>
<% 
	BodegasUsuariosMain bm = new BodegasUsuariosMain();
    ProductosMain pm = new ProductosMain();
    PackingMain packmain = new PackingMain();
	//long total_bodegas = bm.count();
	long total_productos = pm.count();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<script>
		
		function clickon( id ){
			var ele = $( "#product-" + id );
			ele.trigger('click');
			console.log( 'clicking:', ele );
		
		} 
		function searchProducts( q ){
			// select DESCRIPCION,CODIGO,COEFICIENTE_UNIDAD,PRECIO,PRECIO_1,PRECIO_2,PRECIO_3,PRECIO_4 from productos where descripcion like '%P0%' or codigo like'%P0%' or ID in (select id_producto from Alias where descripcion like '%P0%');
			console.log( "looking for products with [" + q + "]");
			$( "#product-container" ).html("");
			$.get( "./bin/searchexistentp?q=" + q , null, function(response){
			
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
                 "<p>" + v.codigo +"</p>" +
               "</div>" +
               "<div class=\"col-sm-6 col-xs-6 goright\">" +
               "<p>&nbsp;&nbsp;&nbsp;</p>" +
             "</div>" +
               "<div class=\"col-sm-6 col-xs-6\"></div>" +
                         "</div>" +
                         "<div class=\"centered\">" +
                         
                 "<img src=\"./bin/RenderImage?imagePath=" + v.imagepath + "\" width=\"90\">" +
                 "<p style=\"color:red\"></p>" +
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
              	<h1></h1>
                  <div class="col-lg-9  col-md-9 col-sm-9  main-chart">
                  <h3>COMPRAS A PROVEEDORES</h3>
                      <div class="row mt">
                      <div class="col-lg-12" onclick="chooseStore()">
                      	Bodega: <b><span id="storedisplay"></span></b>
                     </div>
                      <div class="col-lg-12" onclick="chooseProveedor()">
                      	Proveedor: <b><span id="proveedordisplay"></span></b>
                      </div>
                      <!-- div class="col-lg-3 pull-left">
                      	Fecha carga: <input type="date" name="fecha_carga" id="fecha_carga" class="form-control">
                      	</div>
                      	<div class="col-lg-3 pull-left">
                      	No. Compra: <input type="text" name="no_compra" id="no_compra" class="form-control">
                      </div-->
                      
                      <div class="col-lg-4 pull-right">
                      Busqueda:
		          		<form>
			          		<div class="top-menu">
					              <ul class="nav pull-right top-menu">
					              		<li><input type="text" class="form-control" id="search-query-3" name="q" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
					                    <li><span class="btn btn-primary" onclick="searchByQuery()">Buscar</span></li>
					              </ul>
				            </div>
					    </form>
					  </div>
					  <br/><br/><br/>
                      <!-- SERVER STATUS PANELS -->
                     
                        <%
                        	ArrayList<ProductoBean> plist = pm.get(null, -1 );
                        for( ProductoBean pbean: plist ){
                            %>
    			<a data-toggle="modal" href="carga-bodega.jsp#myModal<%= pbean.getId() %>" id="product-<%= pbean.getId() %>"></a>
    			<% } 
                        %>    	
                        <%
                        	for( ProductoBean pbean: plist ){
                        %>
						
             <div aria-hidden="true" aria-labelledby="myModalLabel<%= pbean.getId() %>" role="dialog" tabindex="-1" id="myModal<%= pbean.getId() %>" class="modal fade">
						<form id="modalform<%= pbean.getId() %>" name="modalform<%= pbean.getId() %>">
						<input name="productid" type="hidden" value="<%= pbean.getId() %>">
						
 			              <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Agregar a bodega...</h4>
			                      </div>
			                      <div class="modal-body col-lg-12">
			                      <div class="col-sm-6">
			                      	<img src="./bin/RenderImage?imagePath=<%= pbean.getImage_path() %>" width="220">
			                      	</div>
			                      	<div class="col-sm-6">
			                      	<h3><%= pbean.getDescripcion() %></h3>
			                      	
			                          <p>Cantidad</p>
			                          <input type="text" name="cantidad" autocomplete="off" class="form-control placeholder-no-fix" value="1">
			                          <br/><p>Costo por unidad</p>
			                          <input type="text" name="costo" autocomplete="off" class="form-control placeholder-no-fix" value="">
			                          <br/>
			                         
			                          <%
			                          	ArrayList<PackingBean> packlist = packmain.getAll( pbean.getId() );
			                          	int count = 0;
			                          	
			                          	
			                          	for( PackingBean pb : packlist ){
			                          	
			                          %>
			                          	<input type="radio" name="packing" value="<%= pb.getMultiplicador() %>" <%= ( count == 0 ? "checked" : "" ) %>>&nbsp;<%= pb.getNombre() %> <br> 
			                          <%
			                          
			                          count++ ;
			                          	} %>
			                          
			                          </br>
			                          </br>
			                          <!--p>Precio unitario:</p>
			                          <input type="text" name="precio" autocomplete="off" class="form-control placeholder-no-fix" value="<%= pbean.getPrecio() %>">
			                          </br>  -->
			                          
			                          </div>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="addToStore(<%= pbean.getId() %>,'<%= pbean.getImage_path() %>','<%= pbean.getDescripcion() %>',document.modalform<%= pbean.getId() %>.cantidad.value,document.modalform<%= pbean.getId() %>.packing.value,document.modalform<%= pbean.getId() %>.costo.value);">Agregar</button>
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
                  <div class="col-lg-3 ds col-md-3 col-sm-3">
                   <form name="saleform" id="saleform" method="POST">
                   <h3>INGRESO ACTUAL</h3>
                   <div class="desc">
                        <div style="float:left">
                        Subtotal: <input type="text" name="monto" id="monto" class="form-control" readonly>
                        Descuento: <input type="text" name="descuento" id="descuento" class="form-control" onchange="updateTotals()">
                        Total: <input type="text" name="total" id="total" class="form-control" readonly>

                        Tipo de pago: <select name="monto" class="form-control">
                        <option value="efectivo">Efectivo</option>
                        <option value="credito">Credito</option>
                        <option value="tarjeta">Tarjeta</option>
                        <option value="cheque">Cheque</option>
                        </select>
                          Total Productos:
                        </div>
                        <div class="details">
                          <p style="color:blue; font-size:18pt; text-align: right;" id="totalOrden">
                             
                          </p>
                        </div>
                      </div>  
                     
                           <input type='hidden' name='bodegaid' id='bodegaid' value=''>
                           <input type='hidden' name='proveedorid' id='proveedorid' value=''>
                           
		                   <div id="sale-container">
		                                      
		                      
		                      
		                  </div>
		                  <button class="btn btn-theme" type="button" id="savesalebutton">Guardar</button>
                  	</form>
                  </div>
              </div><!--/row -->
          </section>
      </section>
      
      <!-- stores modal starts -->
      <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myStores" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione una bodega...</h4>
			                      </div>
			                      <div class="modal-body">
				                      <%
				                      		int fromS = 0;
											if( request.getParameter( "from" ) != null ){
												fromS = Integer.parseInt( request.getParameter( "from" ) );
											}
											
											ArrayList<BodegaBean> listS = bm.getForUser( loggedUser.getId() );
											int total_regsS = -1;
											
											if( listS.size() > 0 ){
												total_regsS = ((BodegaBean)listS.get( 0 )).getTotal_regs();
											}
										%>
										 <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	  <thead>
                              <tr>
                              	<th></th>
                              	<th>Id</th>
                                  <th>Nombre</th>                                                                                                      
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              int bodegaCount = 0;
                              	for(BodegaBean bean: listS ){
                              %>
                              <tr>
                              	  <td>
                              	  	<input type="radio" name="bodegaid" value="<%= bean.getId() %>,<%= bean.getNombre()  %>" <%= bodegaCount == 0 ? "checked" : "" %>>
                              	  </td>
                                  <td>
                                  	<%= bean.getId() %>
								  </td>
								  <td>
								  	<%= bean.getNombre() %>
								 </td>                                  
                                                                            
                                  
                              </tr>
                              <% 
                              bodegaCount++;
                              	} %>
                              
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setStore();">Seleccionar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>
      <!-- stores modal ends -->
      
      
      <!-- proveedores modal starts -->
      <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myProveedores" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione un proveedor...</h4>
			                      </div>
			                      <div class="modal-body">
				                      <%
				                      		ProveedoresMain proveedoresMain = new ProveedoresMain();
				                      		ArrayList<ProveedorBean> listProveedores = proveedoresMain.get( null, -1 );
										%>
										 <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	  <thead>
                              <tr>
                              	<th></th>
                              	<th>Id</th>
                                  <th>Nombre</th>                                                                                                      
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              int proveedorCount = 0;
                              	for(ProveedorBean bean: listProveedores ){
                              %>
                              <tr>
                              	  <td>
                              	  	<input type="radio" name="proveedorid" value="<%= bean.getId() %>,<%= bean.getNombre()  %>" <%= proveedorCount == 0 ? "checked" : "" %>>
                              	  </td>
                                  <td>
                                  	<%= bean.getId() %>
								  </td>
								  <td>
								  	<%= bean.getNombre() %>
								 </td>                                  
                                                                            
                                  
                              </tr>
                              <% 
                              proveedorCount++;
                              	} %>
                              
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setProveedor();">Seleccionar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>
      <!-- proveedores modal ends -->
      
		          
      <!--main content end-->
      <!--footer start-->
      <!-- footer class="site-footer">
          <div class="text-center">
               <a href="http://www.urbau-digital.com">2015 - Urbau Digital</a>
              <a href="home.jsp" class="go-top">
                  <i class="fa fa-angle-up"></i>
              </a>
          </div>
      </footer -->
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
  		  
  		  var selected_bodega_id;
  		  var selected_proveedor_id;
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
  
		    
		    function setStore(){
		    	var value = $('input[name=bodegaid]:checked').val();
		    	var values = value.split(',');
		    	console.log('bodega', values[0]);
		    	selected_bodega_id = values[0];
				$('#storedisplay').html(value);
				$('#bodegaid').val( selected_bodega_id );
		    	hideStore();
		    }
		    
		    function setProveedor(){
		    	var value = $('input[name=proveedorid]:checked').val();
		    	var values = value.split(',');
		    	console.log('proveedor', values[0]);
		    	selected_proveedor_id = values[0];
				$('#proveedordisplay').html(value);
				$('#proveedorid').val( selected_proveedor_id );
		    	hideProveedor();
		    }
		    
		    
  			function addToStore( productid, imagepath, productname, amount, packvalue, preciounitario ){
  				addS( amount, packvalue, productname, imagepath,productid,preciounitario );
  				hideModal('#myModal' + productid );
  				renderVentasList();
  				
  			}
  			
  			function chooseStore(){
  				$('#myStores').modal('show');
  			}
  			function chooseProveedor(){
  				$('#myProveedores').modal('show');
  			}
  			function hideModal( id ){
  				$(id).modal('hide');
  			}
  			
  			
  			function hideStore(){
  				$('#myStores').modal('hide');
  			}
  			function hideProveedor(){
  				$('#myProveedores').modal('hide');
  			}
  			
  			
  			
			$("#savesalebutton").click(function(){
				
    			var form =$('#saleform');
    	     	$.ajax({
    	     		type:'POST',
    	     		dataType: "text",
    	 			url: './bin/IngresoBodega',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){
    		        	var messages = msg.split('|');
    		        	alert( messages[ 1 ] );
    		        	if( !msg.startsWith('error') ){
    		        		
    		        		if( confirm( "Desea imprimir la carga?" ) ){
    		        			window.open( 'cargas-bodega-detalle.jsp?autoprint=true&id=' + messages[ 0 ] );
    		        			location.reload();
    		        		} else {
    		        			location.reload();
    		        		}
    		        		// if( confirm("desea imprimir la carga?") ){
    		        		//	location.replace( 'cargas-bodega-detalle.jsp?id=6' );
    		        		 //} else {
    		        			
    		        		//}
    		        	}
    		            
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
  			
  			
  			
  		    var ventasList = [];
  		    function addS( amount, packval, description, imagepath,productid,preciounitario ){
  		    	console.log("actually adding sale productid: "+ productid + ", amount:" + amount + ", packval:" + packval +", preciounitario:" + preciounitario );
  		    	var o = {};
  			    o.amount = amount;
  			    o.pack = packval;
  			    o.description = description;
  			    o.imagepath = imagepath;
  			    o.id = productid;
  			    o.preciounitario = preciounitario;
  	  		    ventasList.push( o );  	
  		    }
  		    
  		    
  		  function removeItem( index ){
			  	ventasList.splice( index, 1 );
				renderVentasList();
		  }  
  		  function renderVentasList(){
  			$( "#sale-container" ).html( "" );
  			var totalOrden = 0.00;
  			var montoTotal = 0;
  			for (i = 0; i < ventasList.length; i++) { 
  				totalOrden +=  ( ventasList[ i ].amount * ventasList[ i ].pack );
  				montoTotal += ( ventasList[ i ].amount * ventasList[ i ].pack  * ventasList[ i ].preciounitario ); 
				var htmltoadd =
					  "<div class=\"desc\">" +
					  "<button type='button' class='close' aria-hidden='true' onclick='removeItem(\"" + i + "\")'>×</button>" +
					  "<input type='hidden' name='productid' value='" + ventasList[ i ].id + "'>" +
					  "<input type='hidden' name='amount' value='" + ventasList[ i ].amount + "'>" +
					  "<input type='hidden' name='pack' value='" + ventasList[ i ].pack + "'>" +
					  "<input type='hidden' name='price' value='" + ventasList[ i ].preciounitario + "'>" +
					  "  <div style=\"float:left\">" +
		              "    <img width=\"70\" src=\"./bin/RenderImage?imagePath=" + ventasList[ i ].imagepath + "\">" +
		              "  </div>" +
		              "  <div class=\"details\">" +
		              "    <p style=\"color:black; font-size:12pt\">" +
		              "       <span style=\"color:red; font-size:20pt\">" +( ventasList[ i ].amount * ventasList[ i ].pack ) + "</span>" + ventasList[ i ].description + "<br/>" +
		              "       <span style=\"color:green; font-size:12pt\">Q. " +( ventasList[ i ].amount * ventasList[ i ].pack * ventasList[ i ].preciounitario ) + "</span>" + ventasList[ i ].description + "<br/>" +
		              "    </p>" +
		              "  </div>" +
		              "</div>";
				$( "#sale-container" ).append( htmltoadd );
				
			}
  			$( "#totalOrden" ).html( totalOrden);
  			$( "#monto" ).val( montoTotal ) ;
  			var descuentoVal = $( "#descuento" ).val(  ) ;
  			$( "#total" ).val( montoTotal - descuentoVal ) ;
  			
  		  }
  			
  		  function updateTotals(){
  			  var monto     = $( "#monto" ).val() ;
  			  var descuento = $( "#descuento" ).val() ;
  			  var total = monto - descuento;
  			$( "#total" ).val(  total  ) ;
  		  }
  			
	</script>  
	
	<script type="text/javascript">
	    $(window).load(function(){
	        $( "#search-query-3" ).keyup(function() {
	        	var value = $( "#search-query-3" ).val();
	        	console.log( "value", value );
	        	searchProducts( value );
			});
	    });
	    
	    function searchByQuery( ){
	    	var value = $( "#search-query-3" ).val();
        	console.log( "value", value );
        	searchProducts( value );
	    }
	    setStore();
	    
	</script>
  </body>
</html>
