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
	TwoFieldsBaseMain motivos = new TwoFieldsBaseMain("MOTIVOS");
	
	ExtendedFieldsBaseMain empleadosMain = new ExtendedFieldsBaseMain( "EMPLEADOS", 
			new String[]{"NOMBRES","APELLIDOS","DIRECCION","TELEFONO","NUMERO_CEDULA","NIT","ESTADO_CIVIL","SEXO","FECHA_DE_NACIMIENTO","HIJOS","MUNICIPIO","ESTADO"},
				new int[]{ 
				Constants.EXTENDED_TYPE_STRING, 
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER
			} );
	
	
	ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "PERMISOS", 
			new String[]{"EMPLEADO","FECHA","MOTIVO","OBSERVACIONES","GOCE_DE_SUELDO"},
				new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER, 
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_BOOLEAN
			} );
			
			int from = 0;
			if( request.getParameter( "from" ) != null ){
		from = Integer.parseInt( request.getParameter( "from" ) );
			}
			ArrayList<ExtendedFieldsBean> list = um.get( request.getParameter("q"), from );
			int total_regs = -1;
			
			if( list.size() > 0 ){
		total_regs = ((ExtendedFieldsBean)list.get( 0 )).getTotal_regs();
			}
	%>
	<script>
		function edit( id ){
			location.replace( "permisos-detail.jsp?mode=edit&id="+id);
		}
		function removereg( id ){
			location.replace( "permisos-detail.jsp?mode=remove&id="+id);
		}
		function view( id ){
			location.replace( "permisos-detail.jsp?mode=view&id="+id);
		} 
		function add(){
			location.replace( "permisos-detail.jsp?mode=add" );
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
          				  <span class="pull-right">
          				  <button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;
          				  
          				  </span>
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> Permisos </h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  <th>Empleado</th>
                                  <th>Fecha</th>
                                  <th>Motivo</th>
                                  <th>Con goce de sueldo</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              		ExtendedFieldsBean efb = empleadosMain.get( Integer.valueOf( us.getValue( "EMPLEADO" )));
                              		TwoFieldsBean motivo = motivos.get( Integer.valueOf( us.getValue( "MOTIVO" )) );
                              %>
                              <tr>
								  <td><%= efb.getValue( "NOMBRES" ) %> <%= efb.getValue( "APELLIDOS" ) %></td>
                                  <td><%= us.getValue( "FECHA" ) %></td>
                                  <td><%= motivo.getDescripcion() %></td>
                                  <td><%= "1".equals( us.getValue( "GOCE_DE_SUELDO" )) ? "Si" : "No" %></td>
                                  <td>
                                      <button class="btn btn-primary btn-xs" onclick="edit('<%= us.getId()  %>');"><i class="fa fa-pencil"></i></button>
                                      <button class="btn btn-danger btn-xs" onclick="removereg('<%= us.getId()  %>');"><i class="fa fa-trash-o "></i></button>
                                      <button class="btn btn-success btn-xs" onclick="view('<%= us.getId()  %>');"><i class="fa fa-eye"></i></button>
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
					    		<a href="permisos.jsp?q=<%= request.getParameter("q") %>&from=<%= from - Constants.ITEMS_PER_PAGE  %>">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } else { %>
					  <li class="previous disabled">
					    		<a href="javascript: return null">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } %>
					    <% if( forwardButton ){  %>
					    <li class="next">
					    	<a href="permisos.jsp?q=<%= request.getParameter("q") %>&from=<%= end  %>">
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
