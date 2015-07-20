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
                        <a href="bodegas.jsp">
                  <span class="li_data"></span>
                  <h3>BODEGAS</h3>
                        </div>
                  <p><%= total_productos %> Productos en <%= total_bodegas %> Bodegas</p>
                      </div>
                      </a>
                      <div class="col-md-2 col-sm-2 box0">
                        <div class="box1">
                  <span class="li_cloud"></span>
                  <h3>1,148</h3>
                        </div>
                  <p>1,148 Productos activos en inventario</p>
                      </div>
                      <div class="col-md-2 col-sm-2 box0">
                        <div class="box1">
                  <span class="li_stack"></span>
                  <h3>23</h3>
                        </div>
                  <p>You have 23 unread messages in your inbox.</p>
                      </div>
                      <div class="col-md-2 col-sm-2 box0">
                        <div class="box1">
                  <span class="li_news"></span>
                  <h3>+10</h3>
                        </div>
                  <p>More than 10 news were added in your reader.</p>
                      </div>
                      <div class="col-md-2 col-sm-2 box0">
                        <div class="box1">
                  <span class="li_data"></span>
                  <h3>OK!</h3>
                        </div>
                  <p>Tu servidor esta trabajando perfecto, relajate y disfruta.</p>
                      </div>
                    
                    </div><!-- /row mt -->  
                  
                      
                      <div class="row mt">
                      <!-- SERVER STATUS PANELS -->
                        <div class="col-md-4 col-sm-4 mb">
                          <div class="white-panel pn donut-chart">
                            <div class="white-header">
                    <h5>USO DE PRESUPUESTO</h5>
                            </div>
                <div class="row">
                  <div class="col-sm-6 col-xs-6 goleft">
                    <p><i class="fa fa-database"></i> 70%</p>
                  </div>
                            </div>
                <canvas id="serverstatus01" height="120" width="120"></canvas>
                <script>
                  var doughnutData = [
                      {
                        value: 70,
                        color:"#C70D0D"
                      },
                      {
                        value : 30,
                        color : "#424a5d"
                      }
                    ];
                    var myDoughnut = new Chart(document.getElementById("serverstatus01").getContext("2d")).Doughnut(doughnutData);
                </script>
                          </div><! --/grey-panel -->
                        </div><!-- /col-md-4-->
                        

                        <div class="col-md-4 col-sm-4 mb">
                          <div class="white-panel pn">
                            <div class="white-header">
                    <h5>PRODUCTO ESTRELLA</h5>
                            </div>
                <div class="row">
                  <div class="col-sm-6 col-xs-6 goleft">
                    <p><i class="fa fa-heart"></i> 122</p>
                  </div>
                  <div class="col-sm-6 col-xs-6"></div>
                            </div>
                            <div class="centered">
                    <img src="assets/img/product.png" width="120">
                            </div>
                          </div>
                        </div><!-- /col-md-4 -->
                        
            <div class="col-md-4 mb">
              <!-- WHITE PANEL - TOP USER -->
              <div class="white-panel pn">
                <div class="white-header">
                  <h5>VENDEDOR ESTRELLA</h5>
                </div>
                <p><img src="assets/img/ui-zac.jpg" class="img-circle" width="80"></p>
                <p><b>Zac Snider</b></p>
                <div class="row">
                  <div class="col-md-6">
                    <p class="small mt">MEMBER SINCE</p>
                    <p>2012</p>
                  </div>
                  <div class="col-md-6">
                    <p class="small mt">TOTAL SPEND</p>
                    <p>$ 47,60</p>
                  </div>
                </div>
              </div>
            </div><!-- /col-md-4 -->
                        

                    </div><!-- /row -->
                    
                            
          <div class="row">
            <!-- TWITTER PANEL -->
            <div class="col-md-4 mb">
                          <div class="darkblue-panel pn">
                            <div class="darkblue-header">
                    <h5>DROPBOX STATICS</h5>
                            </div>
                <canvas id="serverstatus02" height="120" width="120"></canvas>
                <script>
                  var doughnutData = [
                      {
                        value: 60,
                        color:"#68dff0"
                      },
                      {
                        value : 40,
                        color : "#444c57"
                      }
                    ];
                    var myDoughnut = new Chart(document.getElementById("serverstatus02").getContext("2d")).Doughnut(doughnutData);
                </script>
                <p>April 17, 2014</p>
                <footer>
                  <div class="pull-left">
                    <h5><i class="fa fa-hdd-o"></i> 17 GB</h5>
                  </div>
                  <div class="pull-right">
                    <h5>60% Used</h5>
                  </div>
                </footer>
                          </div><! -- /darkblue panel -->
            </div><!-- /col-md-4 -->
            
            
            <div class="col-md-4 mb">
              <!-- INSTAGRAM PANEL -->
              <div class="instagram-panel pn">
                <i class="fa fa-instagram fa-4x"></i>
                <p>@THISISYOU<br/>
                  5 min. ago
                </p>
                <p><i class="fa fa-comment"></i> 18 | <i class="fa fa-heart"></i> 49</p>
              </div>
            </div><!-- /col-md-4 -->
            
            <div class="col-md-4 col-sm-4 mb">
              <!-- REVENUE PANEL -->
              <div class="darkblue-panel pn">
                <div class="darkblue-header">
                  <h5>REVENUE</h5>
                </div>
                <div class="chart mt">
                  <div class="sparkline" data-type="line" data-resize="true" data-height="75" data-width="90%" data-line-width="1" data-line-color="#fff" data-spot-color="#fff" data-fill-color="" data-highlight-line-color="#fff" data-spot-radius="4" data-data="[200,135,667,333,526,996,564,123,890,464,655]"></div>
                </div>
                <p class="mt"><b>$ 17,980</b><br/>Month Income</p>
              </div>
            </div><!-- /col-md-4 -->
            
          </div><!-- /row -->
          
          <div class="row mt">
                      <!--CUSTOM CHART START -->
                      <div class="border-head">
                          <h3>VISITS</h3>
                      </div>
                      <div class="custom-bar-chart">
                          <ul class="y-axis">
                              <li><span>10.000</span></li>
                              <li><span>8.000</span></li>
                              <li><span>6.000</span></li>
                              <li><span>4.000</span></li>
                              <li><span>2.000</span></li>
                              <li><span>0</span></li>
                          </ul>
                          <div class="bar">
                              <div class="title">JAN</div>
                              <div class="value tooltips" data-original-title="8.500" data-toggle="tooltip" data-placement="top">85%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">FEB</div>
                              <div class="value tooltips" data-original-title="5.000" data-toggle="tooltip" data-placement="top">50%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">MAR</div>
                              <div class="value tooltips" data-original-title="6.000" data-toggle="tooltip" data-placement="top">60%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">APR</div>
                              <div class="value tooltips" data-original-title="4.500" data-toggle="tooltip" data-placement="top">45%</div>
                          </div>
                          <div class="bar">
                              <div class="title">MAY</div>
                              <div class="value tooltips" data-original-title="3.200" data-toggle="tooltip" data-placement="top">32%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">JUN</div>
                              <div class="value tooltips" data-original-title="6.200" data-toggle="tooltip" data-placement="top">62%</div>
                          </div>
                          <div class="bar">
                              <div class="title">JUL</div>
                              <div class="value tooltips" data-original-title="7.500" data-toggle="tooltip" data-placement="top">75%</div>
                          </div>
                      </div>
                      <!--custom chart end-->
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
            <h3>NOTIFICACIONES</h3>
                                        
                      <!-- First Action -->
                      <div class="desc">
                        <div class="thumb">
                          <span class="badge bg-theme"><i class="fa fa-clock-o"></i></span>
                        </div>
                        <div class="details">
                          <p><muted>Hacd 2 Dias</muted><br/>
                             <a href="#">James Brown</a> subscribed to your newsletter.<br/>
                          </p>
                        </div>
                      </div>
                      

                       <!-- USERS ONLINE SECTION -->
            <h3>TAREAS PENDIENTES</h3>
                      <!-- First Member -->
                      <div class="desc">
                        <div class="thumb">
                          <img class="img-circle" src="assets/img/ui-divya.jpg" width="35px" height="35px" align="">
                        </div>
                        <div class="details">
                          <p><a href="#">DIVYA MANIAN</a><br/>
                             <muted>Available</muted>
                          </p>
                        </div>
                      </div>
                     

                        
                      
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
                    url: "show_data.php?action=1",
                    modal: true
                },
                legend: [
                    {type: "text", label: "Special event", badge: "00"},
                    {type: "block", label: "Regular event", }
                ]
            });
        });
        
        
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
