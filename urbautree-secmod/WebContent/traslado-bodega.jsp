<%@page import="com.urbau.feeders.BodegasUsuariosMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>
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
              	
              	  <div class="col-lg-9  col-md-9 col-sm-9  main-chart">
              	  <h3>TRASLADO ENTRE BODEGAS</h3>
                      <div class="row mt">
                      <div class="col-lg-12">
                      <span class="btn-xs btn-success" onclick="chooseStore()">Cambiar</span> Bodega origen: <b><span id="storedisplay"></span></b>
                      </div>
                      <br/><br/>
                      <div class="col-lg-12">
                      <span class="btn-xs btn-success" onclick="chooseStore2()">Cambiar</span> Bodega destino: <b><span id="storedisplay2"></span></b>
                      </div>
                      <div class="col-lg-12">
		          		<form>
			          		<div class="top-menu">
					              <ul class="nav pull-right top-menu">
					              		<li><input type="text" class="form-control" id="search-query-3" name="q" autocomplete="off" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
					                    <li><button class="btn btn-primary" onclick="searchProducts();return false">Buscar</button></li>
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
                  <div class="col-lg-3 ds  col-md-3 col-sm-3">
                   <h3>TRASLADO ACTUAL</h3>
                   <div class="desc">
                        <div style="float:left">
                          Total Productos:
                        </div>
                        <div class="details">
                          <p style="color:blue; font-size:18pt; text-align: right;" id="totalOrden">
                             
                          </p>
                        </div>
                      </div>  
                      <form name="saleform" id="saleform" method="POST">
                           <input type='hidden' name='bodegaid' id='bodegaid' value=''>
                           <input type='hidden' name='bodega2id' id='bodega2id' value=''>
		                   <div id="sale-container">
		                  </div>
		                  <button class="btn btn-theme" type="button" id="savesalebutton">Trasladar</button>
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
			                          <h4 class="modal-title">Seleccione la bodega origen...</h4>
			                      </div>
			                      <div class="modal-body">
				                      <%
											ArrayList<BodegaBean> listS = bm.getForUser( loggedUser.getId() );
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

    <!-- stores2 modal starts -->
      <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myStores2" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione la bodega destino...</h4>
			                      </div>
			                      <div class="modal-body">
				                      <%	
											ArrayList<BodegaBean> listS2 = bm.getForUser( loggedUser.getId() );
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
                              int bodega2Count = 0;
                              	for(BodegaBean bean: listS2 ){
                              %>
                              <tr>
                              	  <td>
                              	  	<input type="radio" name="bodega2id" value="<%= bean.getId() %>,<%= bean.getNombre()  %>" <%= bodega2Count == 0 ? "checked" : "" %>>
                              	  </td>
                                  <td>
                                  	<%= bean.getId() %>
								  </td>
								  <td>
								  	<%= bean.getNombre() %>
								 </td>                                  
                              </tr>
                              <% 
                              bodega2Count++;
                              	} %>
                              
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setStore2();">Seleccionar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>
      <!-- stores2  modal ends -->		          
	  <!--  INICIA MODAL UNICO  -->
             <div aria-hidden="true" aria-labelledby="productModalLabel" role="dialog" tabindex="-1" id="productModal" class="modal fade">
						<form id="productmodalform" name="productmodalform">
							<input id="productid" name="productid" type="hidden">
							<input id="imagePath" name="imagePath" type="hidden">
							<input id="descripcion" name="descripcion" type="hidden">
							
 			              <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Agregar a bodega...</h4>
			                      </div>
			                      <div class="modal-body col-lg-12">
			                      <div class="col-sm-6">
			                      	<img id="modalImage" src="" width="220">
			                      	</div>
			                      	<div class="col-sm-6">
			                      	<h3><span id="modalDescription"></span></h3>
			                      	
			                          <p>Cantidad</p>
			                          <input type="text" name="cantidad"  id="cantidad" autocomplete="off" class="form-control placeholder-no-fix" value="1">
			                          <div id="modalpackingscontainer">
			                          	<input type="radio" name="packing" value="thevalue" checked>&nbsp;Unidad<br>
			                          </div> 
			                          <br/>
			                          <br/>
			                          
			                          </div>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="addToStoreButton" onclick="addToStore(document.productmodalform.productid.value,document.productmodalform.imagePath.value,document.productmodalform.descripcion.value,document.productmodalform.cantidad.value,document.productmodalform.packing.value);">Agregar</button>
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
  
  
  <script type="text/javascript">
  		  
  		  	var ventasList = [];	
  		  	var selected_bodega_id;
  		  	var selected_bodega_id2;
  		  	var allowed_prices;
			var addingToStore = false;
			var current_stock = 0;
			
		function searchProducts( q, bo ){
			var value = $( "#search-query-3" ).val();
			$('#loadingDIV').show();
			$('#noresultsDIV').hide();
			$( "#product-container" ).html("");
			var totalproducts = 0;
			$.get( "./bin/sepis?q=" + value + "&bo=" + selected_bodega_id, null, function(response){
				$('#loadingDIV').hide();
				 $('#noresultsDIV').hide();
				 
                 $.each(response, function(i, v) {
                	 totalproducts++;
                	 var rootele;
                	 var htmltoadd =
                		 
              "<a  href=\"javascript: setProductModalValues( "+ v.id + ", '" + v.imagepath + "', '" + v.descripcion + "', " + v.packingsarray + ","+ v.stock +" );\">" +
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
                 "<p style=\"color:green\">"+v.stock+" disponibles</p>" +
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
		
      	function setProductModalValues(productid, imagePath, descripcion, packings, stock ){
      		
      		$("#cantidad").val("1");
			$("#productid").val(productid);
			$("#imagePath").val(imagePath);
			$("#descripcion").val(descripcion);
			$("#modalImage").attr("src", './bin/RenderImage?imagePath=' + imagePath);
			$("#modalDescription").html( descripcion );
			$('#modalpackingscontainer').html("");
			current_stock = stock;
			contador = 0;
			$.each( packings, function( key, value ) {
				$('#modalpackingscontainer').append(
						'<input type="radio" name="packing" value="'+value.value+'" '+( contador==0 ?'checked':'' )+'   >&nbsp;'+value.descripcion+'<br>');
				contador ++;
 			});
			$("#productModal").modal("show");
      	}
		  	    
		    function setStore(){
		    	var value = $('input[name=bodegaid]:checked').val();
		    	var values = value.split(',');
		    	selected_bodega_id = values[0];
				$('#storedisplay').html(value);
				$('#bodegaid').val( selected_bodega_id );
		    	hideStore();
		    }
		    function setStore2(){
		    	var value = $('input[name=bodega2id]:checked').val();
		    	var values = value.split(',');
		    	selected_bodega_id2 = values[0];
				$('#storedisplay2').html(value);
				$('#bodega2id').val( selected_bodega_id2 );
		    	hideStore2();
		    }
		    
		    function addToStore( productid, imagepath, productname, amount, packvalue ){
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
		    	$.each( ventasList, function( i, vl ) {
		    		if( vl.id == productid ){
		    			alert( "El producto seleccionado ya fue agregado." );
		    			return false;
		    		}
		    	});	
	  			
  				if( !addingToStore ){
	  				addingToStore = true;
	  				addS( amount, packvalue, productname, imagepath,productid );
	  				$("#productModal").modal("hide");
	  				renderVentasList();
	  				addingToStore = false;
  				} else {
  					alert("already added... porque esto?");
  				}
  			}
		    
  			function chooseStore(){
  				$('#myStores').modal('show');
  			}
  			function chooseStore2(){
  				$('#myStores2').modal('show');
  			}
  			function hideModal( id ){
  				$(id).modal('hide');
  			}
  			
  			
  			function hideStore(){
  				$('#myStores').modal('hide');
  			}
  			function hideStore2(){
  				$('#myStores2').modal('hide');
  			}
			$("#savesalebutton").click(function(e){
				e.preventDefault();
				$("#savesalebutton").prop('disabled',true);
				if( confirm( "Confirma que desea hacer el traslado?" ) ){
	    			var form =$('#saleform');
	    	     	$.ajax({
	    	     		type:'POST',
	    	     		dataType: "text",
	    	 			url: './bin/TrasladoBodega',
	    	 			data: form.serialize(),
	    	 			
	    		        success: function(msg){		
	    		        	var messages = msg.split("|");
	    		        	var idm =-1;
	    		        	var msgm;
	    		        	if ( messages.length == 2){
	    		        		idm = messages[ 0 ];
	    		        		msgm = messages[ 1 ];
	    		        	} else {
	    		        		msgm = msg;
	    		        	}
	    		        	alert(msgm);
	    		            if( idm !== -1 ){ 
	    		        		location.replace( "print-traslado.jsp?id="+idm);
	    		        	 } 
	    		            
	    		        },
	    	 			error: function(jqXHR, textStatus, errorThrown){
	    	 				console.log("ERROR srtatus: ", textStatus);
	    	 				console.log("ERROR errorThrown: ", errorThrown);
	    	 				alert("Se prudujo un error al hacer la operaciòn");	
	    	 			}
	    		            		        
	    	       });
	    	     	return false;
				} else {
					$("#savesalebutton").prop('disabled',false );
				}
				return false;
    	 	});
			
            
  		    function addS( amount, packval, description, imagepath,productid ){
  		    	var o = {};
  			    o.amount = amount;
  			    o.pack = packval;
  			    o.description = description;
  			    o.imagepath = imagepath;
  			    o.id = productid;
  	  		    ventasList.push( o );  	
  		    }
  		    
  		  function removeItem( index ){
			  	ventasList.splice( index, 1 );
				renderVentasList();
		  }
  		    
  		  function renderVentasList(){
  			$( "#sale-container" ).html( "" );
  			var totalOrden = 0.00;
  			$.each( ventasList, function( i, vl ) {
  				
  				totalOrden +=  ( vl.amount * vl.pack );
				var htmltoadd =
					  "<div class=\"desc\">" +
					  "<button type='button' class='close' aria-hidden='true' onclick='removeItem(\"" + i + "\")'>×</button>" +
					  "<input type='hidden' name='productid' value='" + vl.id + "'>" +
					  "<input type='hidden' name='amount' value='" + vl.amount + "'>" +
					  "<input type='hidden' name='pack' value='" + vl.pack + "'>" +
					  "  <div style=\"float:left\">" +
		              "    <img width=\"70\" src=\"./bin/RenderImage?imagePath=" + vl.imagepath + "\">" +
		              "  </div>" +
		              "  <div class=\"details\">" +
		              "    <p style=\"color:black; font-size:12pt\">" +
		              "       <span style=\"color:red; font-size:20pt\">" +( vl.amount * vl.pack ) + "</span>" + vl.description + "<br/>" +
		              "    </p>" +
		              "  </div>" +
		              "</div>";
				$( "#sale-container" ).append( htmltoadd );
			});
  			
  			
  			$( "#totalOrden" ).html( totalOrden);
  		  }
	    setStore();
	    setStore2();
	    
	    /**
	        function keepMeAlive(imgName) {
		       myImg = document.getElementById(imgName);
		       if (myImg) myImg.src = myImg.src.replace(/?.*$/, '?' + Math.random());
		    }
		    window.setInterval("keepMeAlive('keepAliveIMG')", 100000);

	    **/
	    
	    
	</script>
	<img id="keepAliveIMG" width="1" height="1" src="assets/img/spacer.gif" />
  </body>
</html>
