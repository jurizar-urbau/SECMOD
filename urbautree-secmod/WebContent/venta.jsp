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
						<a data-toggle="modal" href="venta.jsp#myModal<%= pbean.getId() %>"> 

                        <div class="col-md-3 col-sm-3 mb">
                          <div class="white-panel pn">
                            <div class="white-header">
                    <h5 style="color:red"><%= pbean.getDescripcion() %></h5>
                            </div>
                <div class="row">
                  <div class="col-sm-6 col-xs-6 goleft">
                    <p><i class="fa fa-heart"></i> <%= pbean.getCodigo() %></p>
                  </div>
                  <div class="col-sm-6 col-xs-6"></div>
                            </div>
                            <div class="centered">
                            
                    <img src="./bin/RenderImage?imagePath=<%= pbean.getImage_path() %>" width="90">
                    <p style="color:red"><%= pbean.getPrecio() %></p>
                            </div>
                          </div>
                        </div><!-- /col-md-4 -->
             </a>  
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
			                          </div>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="addSale();">Agregar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>         
            <% } %>
                        

                    </div><!-- /row -->
                     	
                            
          
          
          
          
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  <div class="col-lg-3 ds">
                   <h3>ORDEN ACTUAL</h3>
                                        
                      <!-- First Action -->
                      <div class="desc">
                        <div style="float:left">
                          <img width="70" src="./bin/RenderImage?imagePath=/Users/xumakgt/imagespath/hqdefault.jpg">
                        </div>
                        <div class="details">
                          <p style="color:black; font-size:12pt">
                             <span style="color:red; font-size:20pt">3</span> Ametralladora 2mt <br/> Q100.00
                          </p>
                        </div>
                      </div>
                      
                      
                      <div class="desc">
                        <div style="float:left">
                          <img width="70" src="./bin/RenderImage?imagePath=/Users/xumakgt/imagespath/cat-2-pack.jpg">
                        </div>
                        <div class="details">
                          <p style="color:black; font-size:12pt">
                             <span style="color:red; font-size:20pt">1</span> Bateria #5 <br/> Q80.00
                          </p>
                        </div>
                      </div>
                      
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
                      
                  </div>
                  
              </div><!--/row -->
          </section>
      </section>
					<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
						<form id="modalform" name="modalform">
						<input name="productid" type="hidden">
						<input name="amount" type="hidden">
						<input name="price"  type="hidden">
 			              <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Agregar producto a orden...</h4>
			                      </div>
			                      <div class="modal-body">
			                          <p>Cantidad</p>
			                          <input type="text" name="cantidad" autocomplete="off" class="form-control placeholder-no-fix">
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="addSale();">Enviar</button>
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
  
  			function addSale(){
  				alert( parseSecond( 'productid' ));
  			}
	</script>  

  </body>
</html>
