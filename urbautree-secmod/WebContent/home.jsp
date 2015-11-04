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
                  <div class="col-lg-9 main-chart">
                  
                    <div class="row mtbox">
                     
                      <div class="col-md-2 col-sm-2 col-md-offset-1 box0">
                        	<div class="box1">
                        		<a href="venta.jsp">
                  					<span class="li_shop"></span>
                  					<h3>Pedido</h3>
                  				</a>
                        	</div>
                  			<p>Ingresar un nuevo pedido.</p>
                      </div>
                      
                      
                      <div class="col-md-2 col-sm-2 box0">
                        <div class="box1">
                        	<a href="ordenes-caja.jsp">
			                  <span class="li_stack"></span>
			                  <h3>Cobro</h3>
			                </a>
		                </div>
		                <p>Cobrar un pedido.</p>
                      </div>
                     
                      <div class="col-md-2 col-sm-2  box0">
                      	<div class="box1">
                        	<a href="carga-bodega.jsp">
                  				<span class="li_data"></span>
                  				<h3>Bodega</h3>
                  	        </a>
                        </div>
                  		<p>Cargar productos a Bodega.</p>
                      </div>
                      
                     
                      <div class="col-md-2 col-sm-2 box0">
                      	<div class="box1">
                      		<a href="ingreso-gasto.jsp">
			                	<span class="li_banknote"></span>
			                  	<h3>Gastos</h3>
			                </a>
		                </div>
		                <p>Ingresar un gasto</p>
		              </div>
		                      
                      <div class="col-md-2 col-sm-2 box0">
                      	<div class="box1">
                      		<a href="traslado-bodega.jsp">
	                  			<span class="li_truck"></span>
	                  			<h3>Traslado</h3>
                  			</a>
                        </div>
                  		<p>Trasladar producto entre bodegas</p>
                      </div>
                      
                    </div><!-- /row mt -->  
                  
                      
                      
                      
                      
                      
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
                  
                  <div class="col-lg-3 ds">
                  <!-- CALENDAR-->
                        <div id="calendar" class="mb">
                            <div class="panel green-panel no-margin">
                                <div class="panel-body">
                                    <div id="date-popover" class="popover top" style="cursor: pointer; disadding: block; margin-left: 33%; margin-top: -50px; width: 175px;">
                                        <div class="arrow"></div>
                                        <h3 class="popover-title" style="disadding: none;"></h3>
                                        <div id="date-popover-content" class="popover-content"></div>
                                    </div>
                                    <div id="my-calendar"></div>
                                </div>
                            </div>
                        </div><!-- / calendar -->
                    <!-- div class="fb-page" data-href="https://www.facebook.com/naturaloilgt" data-hide-cover="false" data-show-facepile="false" data-show-posts="true"></div -->
                    <!--COMPLETED ACTIONS DONUTS CHART-->
            

                        
                      
                  </div><!-- /col-lg-3 -->
              </div><!--/row -->
          </section>
      </section>

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
    <script src="assets/js/sparkline-chart.js"></script>    
  <script src="assets/js/zabuto_calendar.js"></script>  
  
  <script type="text/javascript">
        $(document).ready(function () {
        	
        	/*
        var unique_id = $.gritter.add({
            // (string | mandatory) the heading of the notification
            title: 'Bienvenido Alejandro!',
            // (string | mandatory) the text inside the notification
            text: '"Cuando veo a un adulto sobre una bicicleta, aún creo que hay esperanza para la humanidad."',
            // (string | optional) the image to display on the left
            image: 'assets/img/ui-jur.jpg',
            // (bool | optional) if you want it to fade out on its own or just sit there
            sticky: false,
            // (int | optional) the time you want it to be alive for before fading out
            time: '',
            // (string | optional) the class name you want to apply to that specific message
            class_name: 'my-sticky-class'
        });

        return false;
        });
        */
  </script>
  
  <script type="application/javascript">
        $(document).ready(function () {
            $("#date-popover").popover({html: true, trigger: "manual"});
            $("#date-popover").hide();
            $("#date-popover").click(function (e) {
                $(this).hide();
            });
        
            $("#my-calendar").zabuto_calendar({
                action: function () {
                    return myDateFunction(this.id, false);
                },
                action_nav: function () {
                    return myNavFunction(this.id);
                },
                ajax: {
                    url: "show-data.jsp?action=1",
                    modal: true
                },
                legend: [
                    {type: "text", label: "Special event", badge: "00"},
                    {type: "block", label: "Regular event", }
                ]
            });
        });
        
        function myDateFunction(id) {
            var date = $("#" + id).data("date");
            var hasEvent = $("#" + id).data("hasEvent");
        }
        function myNavFunction(id) {
            $("#date-popover").hide();
            var nav = $("#" + id).data("navigation");
            var to = $("#" + id).data("to");
            console.log('nav ' + nav + ' to: ' + to.month + '/' + to.year);
        }
    </script>
  <script type="text/javascript">
  $(document).idle({
	  onIdle: function(){
	    alert('Since you waited so long, the answer to the Ultimate Question of Life, the Universe, and Everything is 42');
	  },
	  idle: 10000
	});
	</script>  

  </body>
</html>
