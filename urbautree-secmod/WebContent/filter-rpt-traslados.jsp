
<%@page import="com.urbau.beans.BodegaUsuarioBean"%>
<%@page import="com.urbau.feeders.BodegasUsuariosMain"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
      

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<%	
			
			BodegasUsuariosMain mainBodegas = new BodegasUsuariosMain();
			BodegasMain main = new BodegasMain();

			ArrayList<BodegaUsuarioBean>  listOfBodegas = mainBodegas.getFromUser( loggedUser.getId() );
			
%>  
	
	</head>
   
   <body>
  <section id="container" >
      
      <header class="header black-bg">
      		<%@include file="fragment/header.jsp"%>        
        </header>
      <aside>
          <div id="sidebar"  class="nav-collapse ">
            
              <%@include file="fragment/sidebar.jsp"%>
            
          </div>
      </aside>
      
      <section id="main-content">
          <section class="wrapper site-min-height">
          
          	
          	<div class="row mt">
          	
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			    <h3>REPORTE DE TRASLADOS</h3><br/>
          			  <form class="form-horizontal style-form" id="form" name="form" action="rpt-traslados.jsp" method="POST">
                      
                      <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Bodega</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="bodega" id="bodega">
	                              	<%
	                              		for( BodegaUsuarioBean bodega : listOfBodegas ){
	                              			BodegaBean bod = main.getBodega( bodega.getIdBodega());
	                              	%>
	                              		<option value="<%= bod.getId() %>"><%= bod.getNombre() %></option>
	                              	<% 
	                              		}
	                              	%>
	                              	</select>
		                      </div>
		                      
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tipo de transacci&oacute;n</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="tipo" id="tipo">
	                              		<option value="r">Recibe</option>
	                              		<option value="e">Env&iacute;a</option>
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
                           	    <button type="button" class="btn btn-success" id="savebutton" onclick="enviar()">Generar</button>
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
        			document.form.action = "rpt-traslados.jsp";	
        		} else if(document.form.agrupado.value == 'c' ){
        			document.form.action = "rpt-traslados-correlativo.jsp";	
        		}  
        		document.form.submit();
        		
        	}
        </script>   
        
  </body>
</html>
