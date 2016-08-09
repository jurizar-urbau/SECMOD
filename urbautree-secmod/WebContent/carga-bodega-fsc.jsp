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
	long total_productos = pm.count();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<script>
		
		 
		function searchProducts( q ){
			console.log( "looking for products with [" + q + "]");
			$( "#product-container" ).html("");
			$.get( "./bin/searchexistentp?q=" + q , null, function(response){
			
                 $.each(response, function(i, v) {
                	 console.log( i, v );
                	 
                	 var rootele;
                	 
                	 var htmltoadd = 
                		 
              "<a  href=\"javascript: setProductModalValues( "+ v.id + ", '" + v.imagepath + "', '" + v.descripcion + "', " + v.packingsarray + " );\">" + 
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
                 "<p>"+v.packings+"</p>" + 
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
              	<h1></h1>
                  <div class="col-lg-9  col-md-9 col-sm-9  main-chart">
                  <h3>INGRESO A BODEGA</h3>
                      <div class="row mt">
                      <div class="col-lg-12" onclick="chooseStore()">
                      	Bodega: <b><span id="storedisplay"></span></b>
                      </div>
                      <div class="col-lg-4 pull-right">
                      Busqueda:
		          		<form onsubmit="searchByQuery(); return false;">
			          		<div class="top-menu">
					              <ul class="nav pull-right top-menu">
					              		<li><input type="text" class="form-control" id="search-query-3" name="q" autocomplete="off" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
					                    <li><span class="btn btn-primary" onclick="searchByQuery()">Buscar</span></li>
					              </ul>
				            </div>
					    </form>
					  </div>
					  <br/><br/><br/>
                      <!-- SERVER STATUS PANELS -->
            		 <div id="product-container" class="separator">
                     </div>
                   </div>
              </div>
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  <div class="col-lg-3 ds col-md-3 col-sm-3">
                   <h3>INGRESO ACTUAL</h3>
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
      
      <script>
      	function setProductModalValues(productid, imagePath, descripcion, packings ){
			$("#productid").val(productid);
			$("#imagePath").val(imagePath);
			$("#descripcion").val(descripcion);
			$("#modalImage").attr("src", './bin/RenderImage?imagePath=' + imagePath);
			$("#modalDescription").html( descripcion );
			$('#modalpackingscontainer').html("");
			contador = 0;
			$.each( packings, function( key, value ) {
				$('#modalpackingscontainer').append(
						'<input type="radio" name="packing" value="'+value.value+'" '+( contador==0 ?'checked':'' )+'   >&nbsp;'+value.descripcion+'<br>');
				contador ++;
 			});
			$("#productModal").modal("show");
      	}
      </script>
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
			                          <input type="text" name="cantidad" autocomplete="off" class="form-control placeholder-no-fix" value="1">
			                          
			                          <!--  loop -->
			                          <div id="modalpackingscontainer">
			                          	<input type="radio" name="packing" value="thevalue" checked>&nbsp;Unidad<br>
			                          </div> 
			                          <!--  end loop  -->
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
  		  
  		  var selected_bodega_id;
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
		    var addingToStore = false;
  			function addToStore( productid, imagepath, productname, amount, packvalue ){
  				if( !addingToStore ){
	  				addingToStore = true;
	  				addS( amount, packvalue, productname, imagepath,productid );
	  				$("#productModal").modal("hide");
	  				renderVentasList();
	  				addingToStore = false;
  				} else {
  					alert("already adding... what is doing this?");
  				}
  				
  			}
  			
  			function chooseStore(){
  				$('#myStores').modal('show');
  			}
  			function hideModal( id ){
  				$(id).modal('hide');
  			}
  			
  			
  			function hideStore(){
  				$('#myStores').modal('hide');
  			}
  			
  			
  			
			$("#savesalebutton").click(function(e){
				e.preventDefault();
				$("#savesalebutton").prop('disabled',true);
				if(confirm('Confirma que desea hacer la carga?')){
	    			var form =$('#saleform');
	    	     	$.ajax({
	    	     		type:'POST',
	    	     		dataType: "text",
	    	 			url: './bin/IngresoBodega',
	    	 			data: form.serialize(),
	    	 			
	    		        success: function(msg){
	    		        	console.log( "msg:", msg );
	    		        	var messages = msg.split('|');
	    		        	alert( messages[ 1 ] );
	    		        	if( !msg.startsWith('error') ){
	    		        		
	    		        		if( confirm( "Desea imprimir la carga?" ) ){
	    		        			location.replace( 'rpt-cargas-bodega.jsp?referer=carga-bodega.jsp&id=' + messages[ 0 ] );
	    		        		} else {
	    		        			location.reload();
	    		        		}
	    		        	}
	    		        },
	    	 			error: function(jqXHR, textStatus, errorThrown){
	    	 				console.log("ERROR srtatus: ", textStatus);
	    	 				console.log("ERROR errorThrown: ", errorThrown);
	    	 				alert("Se prudujo un error al hacer la operacion");	
	    	 			}
	    	       });
	    	     	return false;
				} else {
					$("#savesalebutton").prop('disabled',false );
				}
    	 	});
  			
  			if (typeof String.prototype.startsWith != 'function') {
  			  // see below for better implementation!
  			  String.prototype.startsWith = function (str){
  			    return this.indexOf(str) === 0;
  			  };
  			}
  			
  			
  			
  		    var ventasList = [];
  		    function addS( amount, packval, description, imagepath,productid ){
  		    	console.log("actually adding sale productid: "+ productid + ", amount:" + amount + ", packval:" + packval );
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
  			for (i = 0; i < ventasList.length; i++) { 
  				totalOrden +=  ( ventasList[ i ].amount * ventasList[ i ].pack );
				var htmltoadd =
					  "<div class=\"desc\">" +
					  "<button type='button' class='close' aria-hidden='true' onclick='removeItem(\"" + i + "\")'>×</button>" +
					  "<input type='hidden' name='productid' value='" + ventasList[ i ].id + "'>" +
					  "<input type='hidden' name='amount' value='" + ventasList[ i ].amount + "'>" +
					  "<input type='hidden' name='pack' value='" + ventasList[ i ].pack + "'>" +
					  "  <div style=\"float:left\">" +
		              "    <img width=\"70\" src=\"./bin/RenderImage?imagePath=" + ventasList[ i ].imagepath + "\">" +
		              "  </div>" +
		              "  <div class=\"details\">" +
		              "    <p style=\"color:black; font-size:12pt\">" +
		              "       <span style=\"color:red; font-size:20pt\">" +( ventasList[ i ].amount * ventasList[ i ].pack ) + "</span>" + ventasList[ i ].description + "<br/>" +
		              "    </p>" +
		              "  </div>" +
		              "</div>";
				$( "#sale-container" ).append( htmltoadd );
				
			}
  			$( "#totalOrden" ).html( totalOrden);
  		  }
  		    
  			
	</script>  
	
	<script type="text/javascript">
	    /*$(window).load(function(){
	        $( "#search-query-3" ).keyup(function() {
	        	var value = $( "#search-query-3" ).val();
	        	console.log( "value", value );
	        	searchProducts( value );
			});
	    });*/
	    
	    function searchByQuery( ){
	    	var value = $( "#search-query-3" ).val();
        	console.log( "value", value );
        	searchProducts( value );
	    }
	    setStore();
	</script>
  </body>
</html>
