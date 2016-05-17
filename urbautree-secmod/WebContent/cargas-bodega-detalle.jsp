<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.beans.TwoFieldsBean"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<%
	
	String id = request.getParameter( "id" );
	ExtendedFieldsBaseMain planillaHead = new ExtendedFieldsBaseMain( "CARGAS_BODEGA_DETALLE", 
		new String[]{"ID_CARGA","ID_PRODUCTO","UNIDADES_PRODUCTO","UNITARIO","PACKING_SELECCIONADO"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER
		} );
	
	
	ExtendedFieldsBaseMain cargaHead = new ExtendedFieldsBaseMain( "CARGAS_BODEGA", 
			new String[]{"BODEGA","FECHA","USUARIO","CORRELATIVO"},
				new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER
			} );
	
			ExtendedFieldsBean head = cargaHead.get( Integer.valueOf( id ));
	

	ExtendedFieldsFilter filter = new ExtendedFieldsFilter( new String[]{ "ID_CARGA" }, 
			new int[]{ ExtendedFieldsFilter.EQUALS}, 
			new int[]{Constants.EXTENDED_TYPE_INTEGER}, 
			new String[]{ id });

	
			int from = 0;
			if( request.getParameter( "from" ) != null ){
		from = Integer.parseInt( request.getParameter( "from" ) );
			}
			ArrayList<ExtendedFieldsBean> list = planillaHead.getAll(filter);
			int total_regs = -1;
			
			if( list.size() > 0 ){
		total_regs = ((ExtendedFieldsBean)list.get( 0 )).getTotal_regs();
			}
	%>
	<script>
		function view( id ){
			location.replace( "cargas-bodega-detalle.jsp?id="+id);
		} 
		
	</script>
	<style>
	@page  
		{ 
		    size: auto;   /* auto is the initial value */ 
		
		    /* this affects the margin in the printer settings */ 
		    margin: 25mm 25mm 25mm 25mm;  
		} 
			
	</style>
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
          <br/>
          <div class="col-lg-6"> 
           
          </div>
          <div class="col-lg-6 no-print" >
          		<form>
	          		<div class="top-menu">
			              <ul class="nav pull-right top-menu">
			              		<li><input type="text" class="form-control" id="search-query-3" name="q" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
			                    <li><button class="btn btn-primary">Buscar</button></li>
			              </ul>
		            </div>
			    </form>
			  </div>
			  <br/>
			  
          	
          	<div class="row mt">
          		<div class="col-lg-12">
          		<div class="content-panel">
          					<span class="pull-right no-print">
          				  		<button type="button" class="btn btn-success" onclick="print();">Imprimir</button>&nbsp;&nbsp;&nbsp;
          				  	</span>
          				  <table class="table table-striped table-advance table-hover">
	                  	  	  <h4>
	                  	  	  	<i class="fa fa-angle-left no-print">&nbsp;<a href="cargas-bodega.jsp">Regresar...</a> &nbsp;</i> <BR>
	                  	  	  	<b>Detalle de carga No:</b> <%= head.getValue( "CORRELATIVO") %><br>
	                  	  	  	<b>Bodega :</b> <%= head.getReferenced( "BODEGA", "BODEGAS", "NOMBRE") %><br>
	                  	  	  	<b>Fecha&nbsp;&nbsp;&nbsp;&nbsp;:</b> <%= head.getValue( "FECHA" ) %><br>
	                  	  	  	<b>Usuario&nbsp;:</b> <%= head.getReferenced( "USUARIO" , "USUARIOS", "NOMBRE") %></h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                              	  <th>Producto</th>
                                  <th>Unidades</th>
                                  <th>Unidades en packing</th>
                                  <th>Total Unidades cargadas</th>
                                  
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              %>
                              <tr>
                              	  <td><%= us.getReferenced( "ID_PRODUCTO" , "PRODUCTOS", "DESCRIPCION") %></td>
								  <td><%= us.getValue( "UNITARIO" ) %></td>
								  <td><%= us.getValue( "PACKING_SELECCIONADO" ) %></td>
								  <td><%= us.getValue( "UNIDADES_PRODUCTO" ) %></td>
								  
								 
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
                         
                      </div>
                      <%
			int init = from + 1;
			
			int end  = (from + Constants.ITEMS_PER_PAGE  ) >= total_regs ? total_regs : (from + Constants.ITEMS_PER_PAGE  );
			
			boolean backButton = true;
			boolean forwardButton = true;
			if( from <= 0 ){ 
				backButton = false;
			}
			if( end >= total_regs ){
				forwardButton = false;
			}
		%>
		              <nav class="no-print">
					  <ul class="pager">
					  <% if( backButton ) {%>
					  <li class="previous">
					    		<a href="cargas-bodega.jsp?q=<%= request.getParameter("q") %>&from=<%= from - Constants.ITEMS_PER_PAGE  %>">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } else { %>
					  <li class="previous disabled">
					    		<a href="javascript: return null">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } %>
					    <% if( forwardButton ){  %>
					    <li class="next">
					    	<a href="cargas-bodega.jsp?q=<%= request.getParameter("q") %>&from=<%= end  %>">
					    		Siguiente <span aria-hidden="true">&rarr;</span></a></li>
					    <% } else { %>
					    <li class="next disabled">
					    	<a href="javascript: return null">
					    		Siguiente <span aria-hidden="true">&rarr;</span></a></li>
					    <% } %>
					    
					  </ul>
					</nav>
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
  <%
 	if( "true".equals( request.getParameter( "autoprint" )) ){
 		%>
 		<script>
 			window.print();
 		</script>
 		
 		<% 
 	}
  %>
</html>
