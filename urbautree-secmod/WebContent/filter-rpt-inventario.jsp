
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
			ArrayList<String[]> listOfBodegas = main.getCombo( "BODEGAS", "ID", "NOMBRE");
			
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
          			    <h3>REPORTE DE INVENTARIO</h3><br/>
          			  <form class="form-horizontal style-form" id="form" name="form" action="rpt-inventario.jsp" method="GET">
                      
                      <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Bodega</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="bodega" id="bodega">
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
                              <label class="col-sm-2 col-sm-2 control-label">Incluir imagen?</label>
                              <div class="col-sm-10">
                              		                          		
									<input type="checkbox" class="form-control" name="imagen" id="imagen"/>	                          	                          
	                          	
                              </div>
                          </div>                                                 
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tipo</label>
                              <div class="col-sm-10">
                              		                          		
									<select  class="form-control" name="tipo" id="tipo">
										<option value="V">Valorizado</option>
										<option value="U">Unidades</option>
									</select>	                          	                          
	                          	
                              </div>
                          </div>   
                            <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Agrupado por</label>
                              <div class="col-sm-10">
                              		                          		
									<select  class="form-control" name="agrupado" id="agrupado">
										<option value="F">Familias</option>
										<option value="C">Codigos</option>
									</select>	                          	                          
	                          	
                              </div>
                          </div>                                                 
                          
                      
                           <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton" onclick="enviar()">Generar Reporte</button>
                           	    <button type="submit" class="btn btn-info"  onclick="generarConteo()">Generar Conteo</button> 
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
        	function generarConteo(){
        		document.form.action = "rpt-inventario-adj.jsp";
        		document.form.submit();
        		
        	}
        	function enviar(){
        		if(document.form.agrupado.value == 'F' ){
        			document.form.action = "rpt-inventario.jsp";	
        		} else if(document.form.agrupado.value == 'C' ){
        			document.form.action = "rpt-inventario-codigo.jsp";	
        		}  
        		document.form.submit();
        		
        	}
        </script>
  </body>
</html>
