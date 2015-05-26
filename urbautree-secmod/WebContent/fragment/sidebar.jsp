
<ul class="sidebar-menu" id="nav-accordion">
              
                  <p class="centered">
                  <a href="home.jsp">
                  <img src="https://scontent-mia.xx.fbcdn.net/hphotos-xap1/v/t1.0-9/10742_714103018653633_713490040812823849_n.png?oh=1e76af0ab2ff870bbeffd15cb90b57ff&oe=55CE1A43" class="img-circle" width="60">
                  </a></p>
                  <h5 class="centered"><%= loggedUser.getNombre() %></h5>
                    
                  <li class="mt">
                      <a class="active" href="home.jsp">
                          <i class="fa fa-dashboard"></i>
                          <span>Inicio</span>
                      </a>
                  </li>

                  

                   <li class="sub-menu" id="menu-operaciones">
                      <a href="javascript:;" >
                          <i class="fa fa-tasks"></i>
                          <span>Operaciones</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="bodegas.jsp">Bodegas</a></li>
                          <li><a  href="productos.jsp">Productos</a></li>
                          <li><a  href="bancos.jsp">Bancos</a></li>
                      </ul>
                  </li> 
                  <li class="sub-menu" id="menu-seguridad">
                      <a href="javascript:;" >
                          <i class="fa fa-cogs"></i>
                          <span>Seguridad</span>
                      </a>
                      <ul class="sub">
                      	  <li><a  href="users.jsp">Usuarios</a></li>
                          <li><a  href="rols.jsp">Roles</a></li>
                          <li><a  href="programs.jsp">Programas</a></li>
                          <li><a  href="options.jsp">Opciones</a></li>
                          <li><a  href="optionsprogram.jsp">Opciones/Programa *</a></li>
                      </ul>
                  </li>
                  
                  
                  <!-- 
                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-book"></i>
                          <span>Extra Pages</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="blank.html">Blank Page</a></li>
                          <li><a  href="login.html">Login</a></li>
                          <li><a  href="lock_screen.html">Lock Screen</a></li>
                      </ul>
                  </li>
                   -->
                   <!-- 
                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-tasks"></i>
                          <span>Forms</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="form_component.html">Form Components</a></li>
                      </ul>
                  </li>
                   -->
                   <!--  
                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class="fa fa-th"></i>
                          <span>Data Tables</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="basic_table.html">Basic Table</a></li>
                          <li><a  href="responsive_table.html">Responsive Table</a></li>
                      </ul>
                  </li>
                  <li class="sub-menu">
                      <a href="javascript:;" >
                          <i class=" fa fa-bar-chart-o"></i>
                          <span>Charts</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="morris.html">Morris</a></li>
                          <li><a  href="chartjs.html">Chartjs</a></li>
                      </ul>
                  </li>
 					-->
              </ul>
              