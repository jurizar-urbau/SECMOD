<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasUsuariosMain"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page pageEncoding="utf-8" %>

<% 
	BodegasUsuariosMain bm = new BodegasUsuariosMain();

%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	
	<style>
		div.separator {
		    margin-top: 30px;
		}
	</style>
	</head>
   
   <body>
   

  <section id="container" >
      <header class="header black-bg">
      		<%@include file="fragment/header.jsp"%>        
        </header>
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <%@include file="fragment/sidebar.jsp"%>
          </div>
      </aside>
      <section id="main-content">
          <section class="wrapper">

              <div class="row">
                  <div class="col-lg-9  col-md-9 col-sm-9 main-chart">
                  <h3>PEDIDO</h3>
                      <div class="row mt">
                      <div class="col-lg-12">
                      	<span class="btn-xs btn-success" onclick="chooseClient()">Cambiar</span> Cliente: <b><span id="clientdisplay"></span></b>
                      </div>
                      <br/><br/>
                      <div class="col-lg-12">
                      	<span class="btn-xs btn-success" onclick="chooseStore()">Cambiar</span> Bodega: <b><span id="storedisplay"></span></b>
                      </div>
                      <div class="col-lg-12">
		          		<form>
			          		<div class="top-menu">
					              <ul class="nav pull-right top-menu">
					              		<li><input type="text" class="form-control" id="search-query-3" name="q" autocomplete="off" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
					                    <li><span class="btn btn-primary" onclick="searchByQuery()">Buscar</span></li>
					              </ul>
					             					              
				            </div>
					    </form>
					  </div>
					  
					  <br/><br/><br/>
                     <div id="loadingDIV" style="display: none; width:100%; padding:70px 2px;text-align:center;">
	              	<div style="background:url(ripple.gif) no-repeat center center;height:125px;">
	              	<br/><br/><br/>BUSCANDO...
	              	</div>
	              </div>
	              <div id="noresultsDIV" style="display: none; width:100%; padding:70px 2px;text-align:center;">
	              	<div style="background:height:125px;">
	              	<br/><br/><br/>NO SE ENCONTRARON PRODUCTOS...
	              	</div>
	              </div>
           			<div id="product-container" class="separator">
                    </div> <!--  content -->
                    
              </div><!-- /row -->
                     	
                            
          
          
          
          
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  <div class="col-lg-3 ds col-md-3 col-sm-3">
                   <h3>ORDEN ACTUAL</h3>
                   <div class="desc">
                        <div style="float:left">
                          Total:
                        </div>
                        <div class="details">
                          <p style="color:blue; font-size:18pt; text-align: right;" id="totalOrden">
                             
                          </p>
                        </div>
                      </div>  
                      <form name="saleform" id="saleform" method="POST">
                           <input type='hidden' name='clientid' id='clientid' value=''>
                           <input type='hidden' name='bodegaid' id='bodegaid' value=''>
                           Fecha: <input class="form-control" type="date" name="postfecha"><br/>
                           Nombre:<input class="form-control" type="text" name="name" id="name">
		                   <div id="sale-container">
		                  </div>
		                  <button class="btn btn-theme" type="button" id="savesalebutton">Guardar Pedido</button>
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
      <!-- clients modal -->
      	 
					<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione un cliente...</h4>
			                          <span class="pull-right">
			          				  	<a data-toggle="modal" class="btn btn-success" href="javascript: createNewClient()">+</a>  
			          				  </span>
			          				  
							              <ul class="nav pull-left top-menu">
							              		<li><input type="text" class="form-control" autocomplete="off" id="search-client" name="q"></li>
							                    <li><button class="btn" type="button" onclick="searchClientsNew()">Buscar</button></li>
							              </ul>
						            <br/><br/><br/>

			          				   
			                      </div>
			                      <div class="modal-body">
				                      
						 <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	  <thead>
                              <tr>
                                  <th></th>
                                  <th>Nit</th>                                  
                                  <th>Nombres</th>
                                  <th>Apellidos</th>                                                                    
                              </tr>
                              </thead>
                              <tbody id="client-container">
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
		          
             			  
                 
		  <!-- INICIA MODAL UNICO -->
		          <div aria-hidden="true" aria-labelledby="productModalLabel" role="dialog" tabindex="-1" id="productModal" class="modal fade">
		          		
						
 			            
		          
		          
						<form id="productmodalform" name="productmodalform">
							<input id="productid" name="productid" type="hidden">
							<input id="imagePath" name="imagePath" type="hidden">
							<input id="descripcion" name="descripcion" type="hidden">
							<input name="price"  type="hidden" value="<% // pbean.getPrecio() %>">  <!--  TODO  ??????  -->
							
 			              <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Agregar a compra...</h4>
			                      </div>
			                      <div class="modal-body col-lg-12">
			                      <div class="col-sm-6">
			                      	<img id="modalImage" src="" width="220">
			                      	</div>
			                      	<div class="col-sm-6">
			                      	<h3><span id="modalDescription"></span></h3>
			                      	
			                          <p>Cantidad</p>
			                          <input type="text" name="cantidad" id="cantidad" autocomplete="off" class="form-control placeholder-no-fix" value="1">
			                          <br/>
			                          <!--  loop -->
			                          <div id="modalpackingscontainer">
			                          	<input type="radio" name="packing" value="thevalue" checked>&nbsp;Unidad<br>
			                          </div> 
			                          <!--  end loop  -->
			                          </br>
			                          </br>
			                          <p>Precio:</p>
			                          <div class="price1" style="display: none;">
			                          	(1)<input type="radio" name="precio" id="precio1" value="" checked><span id="precio1value"></span> <br/>
			                          </div>
			                          <div class="price2" style="display: none;">
				                        (2)<input class="price2" id="precio2" type="radio" name="precio" value="" ><span id="precio2value"></span><br/>
			                          </div>
			                          <div class="price3" style="display: none;">
			                          	(3)<input class="price3" id="precio3" type="radio" name="precio" value="" ><span id="precio3value"></span><br/>
			                          </div>
			                          <div class="price4" style="display: none;">
			                          	(4)<input class="price4" id="precio4" type="radio" name="precio" value="" ><span id="precio4value"></span><br/>
			                          </div>
			                          
			                          </div>
			                      </div>
			                      <div class="modal-footer">
				                      <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="addSaleButton" onclick="addSale(document.productmodalform.productid.value,document.productmodalform.imagePath.value,document.productmodalform.descripcion.value,document.productmodalform.precio.value,document.productmodalform.cantidad.value,document.productmodalform.packing.value);">Agregar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>         
            

            <!-- FINALIZA MODAL UNICO -->
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
  
  <script>
  	  console.log( "NEW VERSION. " );
  	   
  	  
  	  var selected_client_id;
	  var selected_bodega_id;
	  var selected_punto_de_venta = '<%= loggedUser.getPunto_de_venta() %>';
	  var allowed_prices;
	  var current_stock = 0;
	  var ventasList = [];
	  var MAXLENGTH = 20;
	  var addingToStore = false;
	  
	  
		function searchProducts( q ){
			$('#loadingDIV').show();
			$('#noresultsDIV').hide();
			$( "#product-container" ).html("");
			 $.get( "./bin/searchp?q=" + q + "&bodega=" + selected_bodega_id + "&cliente=" + selected_client_id, null, function(response){
				 $('#loadingDIV').hide();
				 $('#noresultsDIV').hide();
				 
				 var totalproducts = 0;
                 $.each(response, function(i, v) {
                	 totalproducts++;
                	 var rootele;
                	 
                	 var htmltoadd =
              "<a  href=\"javascript: setProductModalValues( "+ v.id + ", '" + v.imagepath + "', '" + v.descripcion + "', " + v.packingsarray + "," + v.stock + ",'"+ v.precio_1 +"','"+ v.precio_2 +"','"+ v.precio_3 +"','"+ v.precio_4 +"',"+ v.precio_1_value +","+ v.precio_2_value +","+ v.precio_3_value +","+ v.precio_4_value +" );\">" + 		  
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
               "<p>" + v.stock +"&nbsp;&nbsp;&nbsp;</p>" +
             "</div>" +
               "<div class=\"col-sm-6 col-xs-6\"></div>" +
                         "</div>" +
                         "<div class=\"centered\">" +
                         
                 "<img src=\"./bin/RenderImage?imagePath=" + v.imagepath + "&w=90&type=smooth\" width=\"90\">" +
                 "<p style=\"color:red\">"+ v.precio_1 +"</p>" +
                 "<p>"+v.packings+"</p>" +
                  "       </div>" +
                  "     </div>" +
                  "   </div>" +
         "</a>";
         			$( "#product-container" ).append( htmltoadd );
                 });
                 if( totalproducts === 0 ){
                	 $('#noresultsDIV').show();
                 }
              });
		}
		
		function setProductModalValues(productid, imagePath, descripcion, packings, stock, precio_1, precio_2, precio_3, precio_4, precio_1_value, precio_2_value, precio_3_value, precio_4_value ){
			$("#cantidad").val("1");
			$("#productid").val(productid);
			$("#imagePath").val(imagePath);
			$("#descripcion").val(descripcion);
			$("#precio1").val(precio_1_value);
			$("#precio2").val(precio_2_value);
			$("#precio3").val(precio_3_value);
			$("#precio4").val(precio_4_value);
			
			$("#precio1value").html(precio_1);
			$("#precio2value").html(precio_2);
			$("#precio3value").html(precio_3);
			$("#precio4value").html(precio_4);
			
			$("#modalImage").attr("src", './bin/RenderImage?imagePath=' + imagePath);
			$("#modalDescription").html( descripcion );
			$('#modalpackingscontainer').html("");
			setPrices();
			current_stock = stock;
			
			contador = 0;
			console.log("packings",packings);
			$.each( packings, function( key, value ) {
				$('#modalpackingscontainer').append(
						'<input type="radio" name="packing" value="'+value.value+'" '+( contador==0 ?'checked':'' )+'   >&nbsp;'+value.descripcion+'<br>');
				contador ++;
 			});
			$("#productModal").modal("show");
      	}
		
		function searchClients( q ){
			$( "#client-container" ).html("");
			 $.get( "./bin/searchc?q=" + q, null, function(response){
                 $.each(response, function(i, v) {
                	 var rootele;
                	 var htmltoadd =
                		"<tr>" +
                 	  	"<td><input type='radio' name='clienteid' value='" + v.id + "," + v.nombres + " " + v.apellidos + "'></td>" +
                     	"<td>"+v.nit+"</td>" +                                  
                     	"<td>"+v.nombres+"</td>" +
                     	"<td>"+v.apellidos+"</td>" +         
	                 	"</tr>";
         			$( "#client-container" ).append( htmltoadd );
                	
                	 
                 });
              });
		}
	
		function setClient(){
		    	var value = $('input[name=clienteid]:checked').val();
		    	var values = value.split(',');
		    	selected_client_id = values[0];
				$('#clientdisplay').html(value);
				$('#clientid').val( selected_client_id );
		    	hideClient();
		    	setPrices();
		    }
		    function setStore(){
		    	var value = $('input[name=bodegaid]:checked').val();
		    	var values = value.split(',');
		    	selected_bodega_id = values[0];
				$('#storedisplay').html(value);
				$('#bodegaid').val( selected_bodega_id );
		    	hideStore();
		    	setPrices();
		    }
  			function addSale( productid, imagepath, productname, price, amount, packing ){
  				if( ! $.isNumeric( amount ) ){
  					alert( "El valor debe ser numerico" );
  					return false;
  				}
  				if( amount < 1 ){
  					alert( "El valor debe ser un numero positivo" );
  					return false;
  				}
  				if( amount > current_stock ){
  					alert( "Cantidad sobrepasa la existencia de " + current_stock + "." );
  					return false;
  				}
  				if( !addingToStore ){
  					addingToStore = true;
  					addS( amount, price, productname, imagepath,productid, packing );
  					$("#productModal").modal("hide");
  					renderVentasList();
  					addingToStore = false;
  				} else {
  					alert("already added... porque esto?");
  				}
  				
  				
  				
  				
  			}
  			
  			function chooseClient(){
  				
  				$('#myModal').modal('show');
  				$('#search-client').focus();
  				
  			}
			function createNewClient(){
  				$('#myModalNewClient').modal('show');
  			}
  			function chooseStore(){
  				$('#myStores').modal('show');
  			}
  			function hideModal( id ){
  				$(id).modal('hide');
  			}
  			function hideClient(){
  				$('#myModal').modal('hide');
  			}
  			
  			function hideStore(){
  				$('#myStores').modal('hide');
  			}
  			
  			function hideNewClient(){
  				$('#myModalNewClient').modal('hide');
  			}
  			$("#saveclientbutton").click(function(){
				
    			var form =$('#modalformnewclient');
    			if( form.valid() ){
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
    				    	$('#clientid').val( values[ 0 ] );
    				    	
    				    	
    				    	console.log("hidding NEW client");
    				    	hideNewClient();
    				    	console.log("hidding client");
    				    	hideClient();
    		        		
    		        	}
    		            //location.replace( "clientes.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operaciòn");	
    	 			}
    		            		        
    	       });
    			} else {
    				alert( "Errores en el formulario." );
    			}
    	     	return false;
    	 	});
  			function setPrices(){
  				 
  				 $.get( "./bin/checkPrice?price=1&store=" + selected_punto_de_venta + "&client=" + selected_client_id, null, function(response){
  					 if( response ){
  						 $('.price1').show();
  					 } else {
  						$('.price1').hide();
  					 }
  				 });
  				$.get( "./bin/checkPrice?price=2&store=" + selected_punto_de_venta + "&client=" + selected_client_id, null, function(response){
  					if( response) {
  						$('.price2').show();
  					} else {
	  				    $('.price2').hide();
	  				}
 				 });
  				$.get( "./bin/checkPrice?price=3&store=" + selected_punto_de_venta + "&client=" + selected_client_id, null, function(response){
  					if( response ){
  						$('.price3').show();	
  					} else {
  						$('.price3').hide();
  					}
 				 });
  				$.get( "./bin/checkPrice?price=4&store=" + selected_punto_de_venta + "&client=" + selected_client_id, null, function(response){
  					if( response ){
  						$('.price4').show();
  					} else {
  						$('.price4').hide();
  					}
 				 });
  			}
			$("#savesalebutton").click(function(e){
				e.preventDefault();
				$("#savesalebutton").prop('disabled',true);
				if( ( selected_client_id > 0 ) || (selected_client_id == 0 ) && ($.trim($("#name").val())!=="") ){
				if( confirm( "Confirma que desea guardar esta orden?" ) ){
    			var form =$('#saleform');
    	     	$.ajax({
    	     		type:'POST',
    	     		dataType: "text",
    	 			url: './bin/Ordenes',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		      
    		        	
    		        	if( !msg.startsWith('error') && !msg.startsWith('No ') ){
    		        		if( msg.indexOf('|') > 0 ){
    		        			var messages = msg.split('|');
    		        			alert( messages[1] );
    		        			//location.replace( "print-orden.jsp?id=" + messages[0] );
    		        			location.reload();
    		        			console.log( messages[0] );
    		        			console.log( messages[1] );
    		        		} else {
    		        			alert( msg );
    		        			console.log( msg );	
    		        		}
    		        		
    		        		//location.reload();	
    		        	} else {
    		        		alert( msg );
    		        	}
    		            //location.replace( "clientes.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operaciòn");	
    	 			}
    		            		        
    	       });
				}
			} else { 
				alert( "Ingrese un nombre para el pedido" );
			}
				
				$("#savesalebutton").prop('disabled', false);
    	     	return false;
    	 	});
  			
  			if (typeof String.prototype.startsWith != 'function') {
  			  // see below for better implementation!
  			  String.prototype.startsWith = function (str){
  			    return this.indexOf(str) === 0;
  			  };
  			}
  			
  			
  			
  		    
  		    function addS( amount, price, description, imagepath,productid,packing ){
  		    	if( ventasList.length == MAXLENGTH ){
  		    		alert("No es posible agregar mas de " + MAXLENGTH + " productos en un mismo pedido.");
  		    		return;
  		    	}
  		    	var o = {};
  			    o.amount = amount;
  			    o.price = price;
  			    o.description = description;
  			    o.imagepath = imagepath;
  			    o.id = productid;
  			    o.packing = packing;
  	  		    ventasList.push( o );  	
  		    }
  		    
  		  function removeItem( index ){
  			  	ventasList.splice( index, 1 );
  				renderVentasList();
  		  }
  		  function renderVentasList(){
  			$( "#sale-container" ).html( "" );
  			var totalOrden = 0.00;
  			for (i = 0; i < ventasList.length; i++) { 
  				totalOrden +=  ( ventasList[ i ].amount * ventasList[ i ].packing * ventasList[ i ].price );
				var htmltoadd =
					"<div class='desc'>" +
					"<button type='button' class='close' aria-hidden='true' onclick='removeItem(\"" + i + "\")'>×</button>" +
					" 	<input type='hidden' name='productid' value='" + ventasList[ i ].id + "'>" +
					" 	<input type='hidden' name='amount' value='" + ventasList[ i ].amount + "'>" +
					" 	<input type='hidden' name='price' value='" + ventasList[ i ].price + "'>" +
					" 	<input type='hidden' name='packing' value='" + ventasList[ i ].packing + "'>" +
					" 	<div style='float:left'>" +    
					" 		<img width='70' src='./bin/RenderImage?imagePath=" + ventasList[ i ].imagepath + "'>" +  
					" 	</div>" +
					"	<div class='details'>" +
					"		<p style='color:black; font-size:12pt'>" +
					"			&nbsp;&nbsp;&nbsp;" + ventasList[ i ].description + "<br>" +
					"			&nbsp;&nbsp;" +
					"			&nbsp;" +
					"			<span style='color:red; font-size:10pt'>(" + ventasList[ i ].amount + " * " + ventasList[ i ].packing + ")</span>" +
					"			<span style='color:black; font-size:10pt'>X</span>" +
					"			<span style='color:blue; font-size:10pt'>Q "+ventasList[ i ].price+" </span>" +
					"			<span style='color:black; font-size:10pt'>=</span>" +
					"			<span style='color:blue; font-size:10pt'>Q " + ( ventasList[ i ].amount * ventasList[ i ].packing * ventasList[ i ].price ).format(2) + "</span>" +
					"		</p>" +  
					"	</div>" +
					"</div>" ;
					  
				$( "#sale-container" ).append( htmltoadd );
				
			}
  			$( "#totalOrden" ).html("Q " + totalOrden.format(2)
  					);
  		  }
  		    
  			
	</script>  
	
	<script type="text/javascript">
	    $(window).load(function(){
	    	setPrices();
	    	$('#search-client').focus();
	        $('#myModal').modal('show');
	        
	    });
	    function searchClientsNew(){
	    	var value = $( "#search-client" ).val();
        	searchClients( value );	
	    }
	    function searchByQuery( ){
	    	
	    	
	    	var value = $( "#search-query-3" ).val();
        	console.log( "value", value );
        	searchProducts( value );
	    }
	    
	    setStore();
	    
	</script>
	<%@include file="fragment/footerscripts.jsp"%>
	<script>
	$(document).ready(function(){
        $('#modalformnewclient').validate(
        {
         rules: {
       	  
       	  nit: {
                 minlength: 2,
                 maxlength: 15,
                 required: true,
                 remote: {
                     url: "./bin/CheckNit",
                     type: "post",
                     data: {
                       nit: function() {
                         return $( "#nit" ).val();
                       }
                     }
                   }
               },                
           nombres: {
               minlength: 3,
               maxlength: 50,
               required: true
             },
           appelidos: {
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
           correo: {
             required: true,
             email: true
           },
           tipodecliente: {
               required: true                   
             }
           
         },
         messages: {
     	    nit: {
     	      remote: "Ya existe un cliente asociado a ese NIT."
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
  </body>
</html>
