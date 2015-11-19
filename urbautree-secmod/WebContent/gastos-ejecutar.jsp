<%@page import="com.urbau.beans.TipoRubroBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.TiposRubrosMain"%>
<%@page pageEncoding="utf-8" %>

<%
	TiposRubrosMain tiposRubrosMain = new TiposRubrosMain();
	ArrayList<TipoRubroBean> listTiposRubro = tiposRubrosMain.getForCombo();	
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
               "<p>" + v.stock +"&nbsp;&nbsp;&nbsp;</p>" +
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
              	<h1></h1>
              	<H3>GASTOS</H3>
                  <div class="col-lg-9  main-chart">
                      <div class="row mt">
                      <span class="pull-right">
          				  	<button type="button" class="btn btn-success" onclick="chooseStore();">+</button>&nbsp;&nbsp;&nbsp;          				  
          				  </span>
                      
					  <br/><br/><br/>
                      <!-- SERVER STATUS PANELS -->
                     </div>
                        
					</div> <!--  content -->
                    </div><!-- /row -->
                 
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  
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
			                          <h4 class="modal-title">Ejecutar un gasto...</h4>
			                      </div>
			                      <div class="modal-body">
				                       <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	 
                              
                              <tbody>
                              <tr>
                              	  <td>
                              	  	Año
                              	  </td>
                              	  <td>
                              	  	<input type="text">
                              	  </td>
                              	  <td>
                              	  	Mes
                              	  </td>
                              	  <td>
                              	  	<input type="text">
                              	  </td>
                              	 
                              	  <td>
                              	  	Rubro
                              	  </td>
                                  <td>
                                  	<select class="formfield">
                              	  		<%
                              	  			for( TipoRubroBean tipoRubro : listTiposRubro ){
                              	  		%>
                              	  		<option value="<%= tipoRubro.getId() %>"><%= tipoRubro.getDescripcion() %></option>
                              	  		<% } %>
                              	  	</select>
								  </td>	
								   </tr>
                              	  <tr>
								  <td>
								  	Tipo
								  </td>   
								  <td>
								  	<select class="formfield">
								  		<option>Debe</option>
								  		<option>Haber</option>
								  	</select>
								  </td>
								  <td>
								  	Monto
								  </td>  
								  <td>
								  	<input type="text" class="formfield">
								  </td>                      
                              </tr>
                             
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setStore();">Ejecutar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>
      <!-- stores modal ends -->
		          
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
  			function addToStore( productid, imagepath, productname, amount, packvalue ){
  				addS( amount, packvalue, productname, imagepath,productid );
  				hideModal('#myModal' + productid );
  				renderVentasList();
  				
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
  			
  			
  			
			$("#savesalebutton").click(function(){
				
    			var form =$('#saleform');
    	     	$.ajax({
    	     		type:'POST',
    	     		dataType: "text",
    	 			url: './bin/IngresoBodega',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		      
    		        	alert( msg );
    		        	if( !msg.startsWith('error') ){
    		        		location.reload();	
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
  		    
  		  function renderVentasList(){
  			$( "#sale-container" ).html( "" );
  			var totalOrden = 0.00;
  			for (i = 0; i < ventasList.length; i++) { 
  				totalOrden +=  ( ventasList[ i ].amount * ventasList[ i ].pack );
				var htmltoadd =
					  "<div class=\"desc\">" +
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
	    $(window).load(function(){
	        $( "#search-query-3" ).keyup(function() {
	        	var value = $( "#search-query-3" ).val();
	        	console.log( "value", value );
	        	searchProducts( value );
			});
	    });
	    setStore();
	</script>
  </body>
</html>
