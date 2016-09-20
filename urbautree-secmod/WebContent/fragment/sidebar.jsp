
            
<%@page import="com.urbau.security.Authorization"%>
<%
	String actualpath = this.getClass().getSimpleName().replaceFirst("_jsp","").replaceAll("_002d","-") + ".jsp";
%>
<div rendered-url="<%=actualpath%>"></div>

<ul class="sidebar-menu no-print" id="nav-accordion">
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
 				   <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_INVENTARIO")) { 
                   %>
                 
					<li class="sub-menu" id="menu-inventario">
					                      <a href="javascript:;">
					                          <i class="fa fa-tasks"></i>
					                          <span>Inventario</span> 
					                      </a>
					                      <ul class="sub">
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"CARGA_DE_PRODUCTO")) { %>
					                      <li><a  href="carga-bodega.jsp">Ingreso a Bodega</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"SALIDAS_BODEGA")) { %>
					                      <li><a  href="salida-bodega.jsp">Salida de Bodega</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"SALIDAS_BODEGA")) { %>
					                          <li><a  href="descargas-bodega.jsp">Descargas de Bodega</a></li>
					                      <% } %>
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
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"BASE_DE_DATOS")) { %>
					                          <li><a  href="filter-rpt-base-de-datos-productos.jsp">Base de Datos de productos</a></li>
					                      <% } %>
					                      
					                      <% 
						                      	 	if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"REPORTE_TRASLADOS")) { 
						                   		%>
						                        <li><a  href="filter-rpt-traslados.jsp">Reporte de traslados</a></li>
						                        <% } %>
					                      <li><a  href="filter-revert.jsp">Revertir carga</a></li>
					                      
					                      <% 
						                      	 	if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"REPORTE_SALIDAS")) { 
						                   		%>
						                        <li><a  href="filter-rpt-salidas.jsp">Reporte de salidas </a></li>
						                        <% } %>
					                      
					                      </ul>
					</li>
					<% } %>
					<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_CLIENTES")) { 
                 	%>
                 
					<li class="sub-menu" id="menu-clientes">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Clientes</span> 
					                      </a>
					                      <ul class="sub">
					                      <li><a  href="clientes.jsp">Clientes</a></li>
					                      <li><a  href="pago-credito-cliente.jsp">Pago cr&eacute;dito clientes</a></li>
					                      </ul>
					</li>
					<% } %>
					<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_VENTAS")) { 
                 	%>
                 
					<li class="sub-menu" id="menu-ventas">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Ventas</span> 
					                      </a>
					                      <ul class="sub">
					                      
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"INICIO_PEDIDOS")) { %>
					                      <li><a  href="venta.jsp">Pedidos</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"INICIO_COBROS")) { %>
				                          <li><a  href="ordenes-caja.jsp">Cobros</a></li>
				                          <% } %>
				                          <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"ORDENES")) { %>
				                          <li><a  href="eliminar-ordenes-caja.jsp">Eliminar orden</a></li>
				                          <% } %>
				                          <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"UBICACIONES")) { %>
				                          <li><a  href="puntosdeventas.jsp">Ubicaciones</a></li>
				                          <% }  %>
				                          <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"ORDENES")) { %>
					                      <li><a  href="ordenes.jsp">Ordenes</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"CUPONES_DE_DESCUENTO")) { %>
					                      <li><a  href="descuentos.jsp">Cupones de Descuento</a></li>
					                      <% } %>
					                      <% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MOTIVOS_DE_DESCUENTO")) { %>
					                      <li><a  href="motivos-de-descuento.jsp">Motivos de Descuento</a></li>
					                      <% } %>
					                      
					                      </ul>
					</li>
					<% } %>
					<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_BANCOS")) { 
                 	%>
                 
					<li class="sub-menu" id="menu-bancos">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Bancos</span> 
					                      </a>
					                      <ul class="sub">
					                      <li><a  href="bancos.jsp">Bancos</a></li>
                      
						                      
					                      </ul>
					</li>
					<% } %>
					<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_FACTURACION")) { 
                 	%>
                                       
					<li class="sub-menu" id="menu-facturacion">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Facturaci&oacute;n</span> 
					                      </a>
					                      <ul class="sub">
					                       		<li><a  href="facturas.jsp">Facturas</a></li>
					                      </ul>
					</li>
					<% } %>
					<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_PROVEEDORES")) { 
                 	%>
                 
					<li class="sub-menu" id="menu-proveedores">
					                      <a href="javascript:;" >
					                          <i class="fa fa-tasks"></i>
					                          <span>Proveedores</span> 
					                      </a>
					                      <ul class="sub">
					                       		<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"com.urbau.feeders.ProveedoresMain")) { %>
						                          <li><a  href="proveedores.jsp">Proveedores</a></li>
						                      <% } %>
						                      
											<li><a  href="compra-bodega.jsp">Compras</a></li>
											<li><a  href="pago-compra-proveedor.jsp">Pago compras a proveedor</a></li>
					                      </ul>
					</li>
					<% } %>
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
                          
                      </ul>
                  </li>
                  <li class="sub-menu" id="menu-nomina">
                  	<a href="javascript:;" >
                          <i class="fa fa-money"></i>
                          <span>Nomina</span>
                      </a>
                      <ul class="sub">
                          
                          
                          <li><a  href="planilla.jsp">Planilla</a></li>
                      	<li><a  href="empleados.jsp">Empleados</a></li>
                        <li><a  href="puestos.jsp">Puestos</a></li>
                      	
                      	<li><a  href="municipios.jsp">Municipios</a></li>
                      	<li><a  href="motivos.jsp">Motivos de Permisos</a></li>
                      	<li><a  href="permisos.jsp">Permisos</a></li>
                      	<li><a  href="adelantos.jsp">Adelantos</a></li>
                      	<li><a  href="prestamos.jsp">Prestamos</a></li>
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
                  
				 
					<% if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"MENU_REPORTES")) { 
                 	%>
                 
                   <li class="sub-menu" id="menu-reportes">
                      <a href="javascript:;" >
                          <i class="fa fa-tasks"></i>
                          <span>Reportes</span>
                      </a>
                      <ul class="sub">
                        <% 
                      	 	if( Authorization.isAuthorizedProgram( loggedUser.getRol(),"REPORTE_INVENTARIO")) { 
                   		%>
                        <li><a  href="filter-rpt-inventario.jsp">Inventario</a></li>
                        <% } %>
                        <li><a  href="filter-rpt-compras.jsp">Compras</a></li>
                        <li><a  href="filter-rpt-utilidades.jsp">Utilidades</a></li>
                        <li><a  href="filter-rpt-movimientos.jsp">Movimientos</a></li>
                        <li><a  href="rpt-cuentas-por-cobrar.jsp">Cuentas por cobrar</a></li>
                        <li><a  href="rpt-ingresos-empresa.jsp">Ingresos empresa</a></li>
                      </ul>
                  </li> 
                  
                  
                  <% } %>
					
                  
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
              