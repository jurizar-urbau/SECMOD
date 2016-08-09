<%@page import="com.urbau.feeders.ProveedoresMain"%>
<%@page import="java.util.ArrayList"%>      
<%	
			ProveedoresMain proveedoresMain = new ProveedoresMain();
			ArrayList<String[]> proveedoresList = proveedoresMain.getCombo("PROVEEDORES ORDER BY NOMBRE", "ID", "NOMBRE" );
%>  

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
          			    <h3>REPORTE DE COMPRAS</h3><br/>
          			  <form class="form-horizontal style-form" id="form" name="form" action="rpt-compras.jsp" method="POST">
                      
                      <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Proveedor</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="proveedor" id="proveedor">
	                              		<option value="*">**Todos**</option>
	                              	<%
	                              		for( String[] proveedor : proveedoresList ){
	                              	%>
	                              		<option value="<%= proveedor[0] %>"><%= proveedor[ 1 ] %></option>
	                              	<% 
	                              		}
	                              	%>
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
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Agrupado por</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="agrupado" id="agrupado">
	                              		<option value="P">Proveedor</option>
	                              		<option value="I">Id de orden</option>
	                              	</select>
		                      </div>
		                      
                          </div>                                                
                            <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Generar</button> 
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
        
  </body>
</html>
