<div class="no-print">
<div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Ocultar/Mostrar navegaci&oacute;n"></div>
              </div>
            <!--logo start-->
            <a href="home.jsp" class="logo"><b><img src="assets/img/logoytel.png" width="50%"></b></a>
            <!--logo end-->
            <div class="nav notify-row" id="top_menu">
                <!--  notification start -->
                <ul class="nav top-menu">
                    <!-- taks start -->
                    	<%@include file="tasks.jsp"%>
                    <!-- taks end -->
                    <!-- inbox dropdown start-->
                    	<%@include file="inbox.jsp"%>
                    <!-- inbox dropdown end -->
                </ul>
                <!--  notification end -->
            </div>
            <div class="top-menu">
              <ul class="nav pull-right top-menu">
              		<li><a class="profile" href="#">[ <%= loggedUser.getNombre() %> ]@[ <%= loggedUser.getNombre_punto_venta() %> ]@[ <%= loggedUser.getNombre_caja_punto_venta() %> ] </a></li>
                    <li><a class="logout" href="bin/Logout">Salir</a></li>
              </ul>
            </div>
            </div>
            
            