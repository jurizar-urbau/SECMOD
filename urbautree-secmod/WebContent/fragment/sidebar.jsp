
<%@page import="com.urbau.security.Authorization"%>
<ul class="sidebar-menu no-print" id="nav-accordion">
              
                  <!--  p class="centered">
                  <a href="home.jsp">
                  <img src="https://scontent-mia.xx.fbcdn.net/hphotos-xap1/v/t1.0-9/10742_714103018653633_713490040812823849_n.png?oh=1e76af0ab2ff870bbeffd15cb90b57ff&oe=55CE1A43" class="img-circle" width="60">
                  </a></p>
                  <h5 class="centered">the name</h5-->
                    
                  <li class="mt">
                      <a class="active" href="home.jsp">
                          <i class="fa fa-dashboard"></i>
                          <span>Inicio</span>
                      </a>
                  </li>
                  
                  <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_SEGURIDAD")) { 
                   %>
                  
                  <li class="sub-menu" id="menu-seguridad">
                      <a href="javascript:;" >
                          <i class="fa fa-lock"></i>
                          <span>Seguridad</span> 
                      </a>
                      <ul class="sub">
                      	<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.UsuariosMain")) { %>
                      	  <li><a  href="users.jsp">Usuarios</a></li>
                      	<% } %>
                      	<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.RolesMain")) { %>
                          <li><a  href="rols.jsp">Roles</a></li>
                        <% } %>
                        <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.ProgramsMain")) { %>
                          <li><a  href="programs.jsp">Programas</a></li>
                        <% } %>
                        <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.OptionsMain")) { %>
                          <li><a  href="options.jsp">Opciones</a></li>
                        <% } %>
                        <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.OptionsByProgramMain")) { %>
                          <li><a  href="optionsprogram.jsp">Opciones/Programa *</a></li>
                        <% } %>
                      </ul>
                  </li>
                  
                  <% } %>

					<li class="sub-menu" id="menu-inventario">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Inventario</span> 
					                      </a>
					                      <ul class="sub">
					                      <li><a  href="carga-bodega.jsp">Carga De Productos</a></li>
 										<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.BodegasMain")) { %>
					                          <li><a  href="bodegas.jsp">Bodegas</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.BodegasMain")) { %>
					                          <li><a  href="cargas-bodega.jsp">Cargas a Bodega</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.ProductosMain")) { %>
					                          <li><a  href="productos.jsp">Productos</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.FamiliasMain")) { %>
					                          <li><a  href="familias.jsp">Familias</a></li>
					                      <% } %>
					                      
					                      </ul>
					</li>
					
					
					<li class="sub-menu" id="menu-clientes">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Clientes</span> 
					                      </a>
					                      <ul class="sub">
					                      <li><a  href="clientes.jsp">Clientes</a></li>
					                      </ul>
					</li>
					
					<li class="sub-menu" id="menu-ventas">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Ventas</span> 
					                      </a>
					                      <ul class="sub">
					                      
					                      <li><a  href="venta.jsp">VENTAS</a></li>
				                          <li><a  href="ordenes-caja.jsp">CAJA</a></li>
				                          <li><a  href="eliminar-ordenes-caja.jsp">Eliminar orden</a></li>
				                          <!-- li><a  href="precios.jsp">Precios</a></li-->
				                          <li><a  href="puntosdeventas.jsp">Puntos De Ventas</a></li>
					                      <li><a  href="ordenes.jsp">Ordenes</a></li>
					                      </ul>
					</li>
					
					<li class="sub-menu" id="menu-bancos">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Bancos</span> 
					                      </a>
					                      <ul class="sub">
					                      <li><a  href="bancos.jsp">Bancos</a></li>
                      
						                      
					                      </ul>
					</li>
					                      
					<li class="sub-menu" id="menu-facturacion">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Facturaci&oacute;n</span> 
					                      </a>
					                      <ul class="sub">
					                       		<li><a  href="facturas.jsp">Facturas</a></li>
					                      </ul>
					</li>
					
					<li class="sub-menu" id="menu-proveedores">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Proveedores</span> 
					                      </a>
					                      <ul class="sub">
					                       		<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.ProveedoresMain")) { %>
						                          <li><a  href="proveedores.jsp">Proveedores</a></li>
						                      <% } %>
						                      

					                      </ul>
					</li>
					 <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_PRESUPUESTO")) { 
                   %>
                  
                  <li class="sub-menu" id="menu-presupuesto">
                  	<a href="javascript:;" >
                          <i class="fa fa-money"></i>
                          <span>Presupuesto</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="presupuestos.jsp">Presupuesto</a></li>
                          <li><a  href="tiposrubros.jsp">Rubros</a></li>
                          <li><a  href="clasificacion_rubros.jsp">Clasificacion Rubros</a></li>
                          
                          <li><a  href="planilla.jsp">Planilla</a></li>
                      	<li><a  href="empleados.jsp">Empleados</a></li>
                        <li><a  href="puestos.jsp">Puestos</a></li>
                      	
                      	<li><a  href="municipios.jsp">Municipios</a></li>
                      	<li><a  href="motivos.jsp">Motivos de Permisos</a></li>
                      	<li><a  href="permisos.jsp">Permisos</a></li>
                      	<li><a  href="adelantos.jsp">Adelantos</a></li>
                      </ul>
                  </li>
                  <!-- li class="sub-menu" id="menu-compras">
                  	<a href="javascript:;" >
                          <i class="fa fa-money"></i>
                          <span>Compras</span>
                      </a>
                      <ul class="sub">
                          <li><a  href="compras.jsp">Compras</a></li>
                          <li><a  href="gastos.jsp">Gastos</a></li>
                      </ul>
                  </li> -->
                  <% } %>
                  
				 
                   <li class="sub-menu" id="menu-reportes">
                      <a href="javascript:;" >
                          <i class="fa fa-tasks"></i>
                          <span>Reportes</span>
                      </a>
                      <ul class="sub">
                        <li><a  href="rpt-cuentas-por-cobrar.jsp">Cuentas por cobrar</a></li>
                        <li><a  href="rpt-ingresos-empresa.jsp">Ingresos empresa</a></li>
                      </ul>
                  </li> 
                  
                  
                  
                  
                  
                  <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_CONFIGURACION")) { 
                   %>
                  
                  <li class="sub-menu" id="menu-configuracion">
                  	<a href="javascript:;" >
                          <i class="fa fa-cogs"></i>
                          <span>Configuraci&oacute;n</span>
                      </a>
                      <ul class="sub">
                      
                          
                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.PaisesMain")) { %>
                          <li><a  href="paises.jsp">Paises</a></li>
                      <% } %>
                       <li><a  href="tipos-de-pago.jsp">Tipos de pago</a></li>
                          <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.TiposDeMovimientosMain")) { %>
                          <li><a  href="tipo_movimiento.jsp">Tipos de Movimientos</a></li>
                      <% } %>
                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.MonedasMain")) { %>
                          <li><a  href="monedas.jsp">Monedas</a></li>
                      <% } %>
                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"CORRELATIVOS")) { %>
                          <li><a  href="correlativos.jsp">Correlativos</a></li>
                      <% } %>
                      </ul>
                  </li>
                  
                  <% } %>
                  
              </ul>
              