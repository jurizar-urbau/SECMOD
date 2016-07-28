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
	<%@include file="fragment/head.jsp"%>
	<%
	
	int selectedpunto = loggedUser.getPunto_de_venta();
	   String queriedpunto = request.getParameter( "punto_de_venta" );
	   String select = queriedpunto == null || "".equals( queriedpunto.trim() ) ? String.valueOf( selectedpunto ) : queriedpunto;
		
	ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "FACTURAS FACT, ORDENES ORD", 
			new String[]{"FACT.FACTURA","FACT.ORDEN","FACT.FECHA","FACT.SUBTOTAL","FACT.TOTAL","FACT.NIT","FACT.NOMBRE","FACT.ID"},
				new int[]{ 
				Constants.EXTENDED_TYPE_STRING, 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_INTEGER
			} );
	
	ExtendedFieldsFilter filter = new ExtendedFieldsFilter( 
			new String[]{
					"FACT.ORDEN",
					"ORD.ID_PUNTO_VENTA"
					},
			new int[]{
					ExtendedFieldsFilter.EQUALS,
					ExtendedFieldsFilter.EQUALS
					}, 
			new int[]{ 
					Constants.EXTENDED_TYPE_INTEGER,
					Constants.EXTENDED_TYPE_INTEGER
					},
			new String[]{
					"ORD.ID", 
					select
					});

	
			
			int from = 0;
			if( request.getParameter( "from" ) != null ){
		from = Integer.parseInt( request.getParameter( "from" ) );
			}
			ArrayList<ExtendedFieldsBean> list = um.getAllWithoutID(filter);
			int total_regs = -1;
			
			if( list.size() > 0 ){
		total_regs = ((ExtendedFieldsBean)list.get( 0 )).getTotal_regs();
			}
	%>
	<script>
		function imprimirFactura( id ){
			window.open( "print-factura.jsp?id="+id );
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
	                  	  	  <h4><i class="fa fa-angle-right"></i> Facturas 
	                  	  	  <form>
	                  	  	  <select name="punto_de_venta" onchange="submit()">
	                  	  	  	<%
	                  	  	  	   
	                  	  			ArrayList<String[]> puntos = um.getCombo("PUNTOSDEVENTAS", "ID", "NOMBRE");
	                  	  			for( String[] punto : puntos ){
	                  	  				%>
	                  	  				<option value="<%= punto[ 0 ]  %>" <%= punto[ 0 ].equals( select ) ? "selected" : "" %>><%= punto[ 1 ] %></option>
	                  	  				<%
	                  	  			}
	                  	  	  	%>
	                  	  	  </select>
	                  	  	  </form>
	                  	  	  </h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  <th>No. Factura</th>
                                  <th>No. Orden</th>
                                  <th>Fecha</th>
                                  <th>Subtotal</th>
                                  <th>Total</th>
                                  <th>NIT</th>
                                  <th>Nombre</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              %>
                              <tr>
								  <td><%= us.getValue( "FACT.FACTURA" ) %></td>
                                  <td><%= us.getValue( "FACT.ORDEN" ) %></td>
                                  <td><%= us.getValue( "FACT.FECHA" ) %></td>
                                  <td><%= us.getValue( "FACT.SUBTOTAL" ) %></td>
                                  <td><%= us.getValue( "FACT.TOTAL" ) %></td>
                                  <td><%= us.getValue( "FACT.NIT" ) %></td>
                                  <td><%= us.getValue( "FACT.NOMBRE" ) %></td>
                                  
                                  <td>
                                      <button class="btn btn-primary btn-xs" onclick="imprimirFactura('<%= us.getValue("FACT.ID")  %>');"><i class="fa fa-print"></i></button>
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
