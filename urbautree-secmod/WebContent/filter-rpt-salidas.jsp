
<%@page import="com.urbau.beans.BodegaUsuarioBean"%>
<%@page import="com.urbau.feeders.BodegasUsuariosMain"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
      
  

<%@page pageEncoding="utf-8" %>
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
      		<%	
			BodegasMain main = new BodegasMain();
			
			BodegasUsuariosMain mainBodegas = new BodegasUsuariosMain();
			ArrayList<BodegaUsuarioBean>  listOfBodegasUsuarios = mainBodegas.getFromUser( loggedUser.getId() );
				
			
			
			
%>       
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
          <section class="wrapper site-min-height">
          
          	
          	<div class="row mt">
          	
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			    <h3>REPORTE DE SALIDAS</h3><br/>
          			  <form class="form-horizontal style-form" id="form" name="form" action="rpt-inventario.jsp" method="POST">
                      
                      <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Bodega</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="bodega" id="bodega">
	                              	<option value="">Todas</option>
	                              	<%
	                              		for( BodegaUsuarioBean list : listOfBodegasUsuarios ){
	                              			BodegaBean bod = main.getBodega( list.getIdBodega() );
	                              	%>
	                              		<option value="<%= bod.getId() %>"><%= bod.getNombre() %></option>
	                              	<% 
	                              		}
	                              	%>
	                              	</select>
		                      </div>
		                      
                          </div>
                          
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tipo</label>
                              <div class="col-sm-10">
                              		                          		
									<select  class="form-control" name="tipo" id="tipo">
									
									<% if( Authorization.isAuthorizedOption( loggedUser.getRol(), "REPORTE_SALIDAS", 13 )){ // RPT-VALORIZADO %>
										<option value="V">Valorizado</option>
									<% } %>
										<option value="U">Unidades</option>
									</select>	                          	                          
	                          	
                              </div>
                          </div>   
                           <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Agrupado por</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="agrupado" id="agrupado">
	                              		<option value="p">Producto</option>
	                              		<option value="c">#Traslado</option>
	                              	</select>
		                      </div>
		                      
                          </div>
                          
                           <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Fecha inicial</label>
                              <div class="col-sm-10">
                              		                          		
									<input type="date" class="form-control" name="fecha-inicio" id="fecha-inicio"/>	                          	                          
	                          	
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Fecha final</label>
                              <div class="col-sm-10">
                              		                          		
									<input type="date" class="form-control" name="fecha-fin" id="fecha-fin"/>	                          	                          
	                          	
                              </div>
                          </div> 
                            
                      
                           <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton" onclick="enviar()">Generar Reporte</button>
					        </div>  
                                                                                                                           
                      </form>
                  </div>

                     
          		</div>
          	</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
        <script type="text/javascript">
        	function enviar(){
        		if(document.form.agrupado.value == 'p' ){
        			document.form.action = "rpt-salidas.jsp";	
        		} else if(document.form.agrupado.value == 'c' ){
        			document.form.action = "rpt-salidas-correlativo.jsp";	
        		}  
        		document.form.submit();
        		
        	}
        </script>
  </body>
</html>
