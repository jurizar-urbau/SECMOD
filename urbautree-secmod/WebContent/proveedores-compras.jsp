<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
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
	<style>
		.red {
			color: red;
		}
	</style>
	<%@include file="fragment/head.jsp"%>
	<%
	
	ExtendedFieldsBaseMain creditos_cliente = new ExtendedFieldsBaseMain( "COMPRAS", 
			new String[] { "FECHA", "ID_ORDEN_DE_COMPRA", "TIPO_DE_PAGO", "SUBTOTAL", "DESCUENTO","TOTAL","GASTOS","TOTAL_CON_GASTOS", "ESTADO" }	
			, new int[]{ 
					Constants.EXTENDED_TYPE_DATE,
					Constants.EXTENDED_TYPE_INTEGER,
					Constants.EXTENDED_TYPE_INTEGER,
					Constants.EXTENDED_TYPE_DOUBLE,
					Constants.EXTENDED_TYPE_DOUBLE,
					Constants.EXTENDED_TYPE_DOUBLE,
					Constants.EXTENDED_TYPE_DOUBLE,
					Constants.EXTENDED_TYPE_DOUBLE,
					Constants.EXTENDED_TYPE_INTEGER } );
	
	
	
			int from = 0;
			if( request.getParameter( "from" ) != null ){
		from = Integer.parseInt( request.getParameter( "from" ) );
			}
			ExtendedFieldsFilter filter = new ExtendedFieldsFilter( new String[]{"ID_PROVEEDOR"},new int[]{ ExtendedFieldsFilter.EQUALS}, new int[]{ Constants.EXTENDED_TYPE_INTEGER}, new String[]{ request.getParameter( "id-proveedor" ) });
			ArrayList<ExtendedFieldsBean> list = creditos_cliente.getAll( filter );
			int total_regs = -1;
			
			if( list.size() > 0 ){
		total_regs = ((ExtendedFieldsBean)list.get( 0 )).getTotal_regs();
			}
	%>
	<script>
		function detalle( id ){
			location.replace( "proveedores-compras-detalle.jsp?id-proveedor=<%= request.getParameter("id-proveedor")%>&id="+id);
		}
		
	</script>
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
          <div class="col-lg-6">
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
          				  
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-left"><a href="proveedores.jsp">Regresar...</a></i> Compras a proveedor </h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  <th>Fecha</th>
                                  <th># Orden</th>
                                  <th>Subtotal</th>
                                  <th>Descuentos</th>
                                  <th>Total</th>
                                  <th>Gastos</th>
                                  <th>Total con gastos</th>
                                
                                  
                                  
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              %>
                              <tr>
								  <td><%= us.getValue( "FECHA" ) %></td>
                                  <td><%= us.getValue( "ID_ORDEN_DE_COMPRA" ) %></td>
                                  <td><%= Util.formatCurrency( Double.valueOf( us.getValue( "SUBTOTAL" ) )) %></td>
                                  <td><%= Util.formatCurrency( Double.valueOf( us.getValue( "DESCUENTO" ) )) %></td>
                                  <td><%= Util.formatCurrency( Double.valueOf( us.getValue( "TOTAL" ) )) %></td>
                                  <td><%= Util.formatCurrency( Double.valueOf( us.getValue( "GASTOS" ) )) %></td>
                                  <td><%= Util.formatCurrency( Double.valueOf( us.getValue( "TOTAL_CON_GASTOS" ) )) %></td>
                                  
                                  <td>
                                      <button class="btn btn-success btn-xs" onclick="detalle('<%= us.getId()  %>');"><i class="fa fa-eye">Ver detalle</i></button>
                                  </td>
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
		              <nav>
					  <ul class="pager">
					  <% if( backButton ) {%>
					  <li class="previous">
					    		<a href="empleados.jsp?q=<%= request.getParameter("q") %>&from=<%= from - Constants.ITEMS_PER_PAGE  %>">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } else { %>
					  <li class="previous disabled">
					    		<a href="javascript: return null">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } %>
					    <% if( forwardButton ){  %>
					    <li class="next">
					    	<a href="empleados.jsp?q=<%= request.getParameter("q") %>&from=<%= end  %>">
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
</html>
