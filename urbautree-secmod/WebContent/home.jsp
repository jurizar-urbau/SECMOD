<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="com.urbau.beans.reports.StatusPresupuesto"%>
<%@page import="com.urbau.beans.reports.beans.PresupuestoReportBean"%>
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
                  <div class="col-lg-12 main-chart">
                  
                    <div class="row mtbox">
                     
                       <div class="col-md-2 col-sm-2 col-md-offset-1  box0">
                      	<div class="box1">
                        	<a href="carga-bodega.jsp">
                  				<span class="li_data"></span>
                  				<h3>Bodegas</h3>
                  	        </a>
                        </div>
                  		<p>Cargar productos a Bodega.</p>
                      </div>
                      
                     
                      <!--  div class="col-md-2 col-sm-2 box0">
                      	<div class="box1">
                      		<a href="ingreso-gasto.jsp">
			                	<span class="li_banknote"></span>
			                  	<h3>Gastos</h3>
			                </a>
		                </div>
		                <p>Ingresar un gasto</p>
		              </div-->
		                      
                      <div class="col-md-2 col-sm-2 box0">
                      	<div class="box1">
                      		<a href="traslado-bodega.jsp">
	                  			<span class="li_paperplane"></span>
	                  			<h3>Traslados</h3>
                  			</a>
                        </div>
                  		<p>Trasladar producto entre bodegas</p>
                      </div>
                      
                      <div class="col-md-2 col-sm-2 box0">
                      	<div class="box1">
                      		<a href="traslado-transito.jsp">
	                  			<span class="li_truck"></span>
	                  			<h3>Transito</h3>
                  			</a>
                        </div>
                  		<p>Productos en transito</p>
                      </div>
                      
                      
                      <div class="col-md-2 col-sm-2 box0">
                        	<div class="box1">
                        		<a href="venta.jsp">
                  					<span class="li_shop"></span>
                  					<h3>Pedidos</h3>
                  				</a>
                        	</div>
                  			<p>Ingresar un nuevo pedido.</p>
                      </div>
                      
                      
                      <div class="col-md-2 col-sm-2 box0">
                        <div class="box1">
                        	<a href="ordenes-caja.jsp">
			                  <span class="li_stack"></span>
			                  <h3>Cobros</h3>
			                </a>
		                </div>
		                <p>Cobrar un pedido.</p>
                      </div>
                      
                      </div>
                      <!-- /row mt -->
                      
                      <div class="row mt">
                      <%
		                StatusPresupuesto statusPresupuesto = new StatusPresupuesto();
                      	Calendar c = Calendar.getInstance();
		                PresupuestoReportBean prb = statusPresupuesto.get(c.get( Calendar.MONTH), c.get( Calendar.YEAR ));
		                
		                PresupuestoReportBean enero = statusPresupuesto.get     (0  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean febrero = statusPresupuesto.get   (1  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean marzo = statusPresupuesto.get     (2  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean abril = statusPresupuesto.get     (3  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean mayo = statusPresupuesto.get      (4  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean junio = statusPresupuesto.get     (5  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean julio = statusPresupuesto.get     (6  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean agosto = statusPresupuesto.get    (7  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean septiembre = statusPresupuesto.get(8  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean octubre = statusPresupuesto.get   (9  , c.get( Calendar.YEAR ));
		                PresupuestoReportBean noviembre = statusPresupuesto.get (10 , c.get( Calendar.YEAR ));
		                PresupuestoReportBean diciembre = statusPresupuesto.get (11 , c.get( Calendar.YEAR ));
		                
		                %>
                      <!-- SERVER STATUS PANELS -->
                        
                        
                        <div class="col-lg-12">
                          <div class="content-panel">
							  <h5>&nbsp;&nbsp;&nbsp;&nbsp;Presupuesto <%= enero.getAnio() %></h5>
                              <div class="panel-body text-center">
                                  <canvas id="line" height="300" width="700"></canvas>
                              </div>
                          </div>
                      </div>
                        
			<script>
			var lineChartData = {
			        labels : ["Ene","Feb","Mar","Abr","May","Jun","Jul","Ago","Sep","Oct","Nov","Dic"],
			        datasets : [
			            {
			                fillColor : "rgba(220,220,220,0.5)",
			                strokeColor : "rgba(220,220,220,1)",
			                pointColor : "rgba(220,220,220,1)",
			                pointStrokeColor : "#fff",  
			                data :[<%= enero.getProyectado().longValue() %>,
			                        <%= febrero.getProyectado().longValue() %>,
			                        <%= marzo.getProyectado().longValue() %>,
			                        <%= abril.getProyectado().longValue() %>,
			                        <%= mayo.getProyectado().longValue() %>,
			                        <%= junio.getProyectado().longValue() %>,
			                        <%= julio.getProyectado().longValue() %>,
			                        <%= agosto.getProyectado().longValue() %>,
			                        <%= septiembre.getProyectado().longValue() %>,
			                        <%= octubre.getProyectado().longValue() %>,
			                        <%= noviembre.getProyectado().longValue() %>,
			                        <%= diciembre.getProyectado().longValue() %>]
			            },
			            {
			                fillColor : "rgba(151,187,205,0.5)",
			                strokeColor : "rgba(151,187,205,1)",
			                pointColor : "rgba(151,187,205,1)",
			                pointStrokeColor : "#fff",
			                data :  [<%= enero.getEjecutado().longValue() %>,
				                        <%= febrero.getEjecutado().longValue() %>,
				                        <%= marzo.getEjecutado().longValue() %>,
				                        <%= abril.getEjecutado().longValue() %>,
				                        <%= mayo.getEjecutado().longValue() %>,
				                        <%= junio.getEjecutado().longValue() %>,
				                        <%= julio.getEjecutado().longValue() %>,
				                        <%= agosto.getEjecutado().longValue() %>,
				                        <%= septiembre.getEjecutado().longValue() %>,
				                        <%= octubre.getEjecutado().longValue() %>,
				                        <%= noviembre.getEjecutado().longValue() %>,
				                        <%= diciembre.getEjecutado().longValue() %>]
			            }
			        ]

			    };
		    new Chart(document.getElementById("line").getContext("2d")).Line(lineChartData);

			</script>

					  



                        
                        
			   			<div class="col-md-4 mb">
			              <!-- WHITE PANEL - TOP USER -->
			             
			            </div><!-- /col-md-4 -->
                        

                    </div><!-- /row -->
                    
                            
          
          
          
          
                  </div><!-- /col-lg-9 END SECTION MIDDLE -->
                  
                  
      <!-- **********************************************************************************************************************************************************
      RIGHT SIDEBAR CONTENT
      *********************************************************************************************************************************************************** -->                  
                  
                  
              </div><!--/row -->
          </section>
      </section>

      <!--main content end-->
      
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
    <script src="assets/js/sparkline-chart.js"></script>    
  <script src="assets/js/zabuto_calendar.js"></script>  
  
    

  </body>
</html>
