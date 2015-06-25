<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page import="com.urbau.feeders.ProveedoresMain"%>
<%@page import="com.urbau.security.Authorization"%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<%    
		ProductosMain productos_main = new ProductosMain();
		ProveedoresMain proveedores_main = new ProveedoresMain();
					
		int from = 0;
		if( request.getParameter( "from" ) != null ){
			from = Integer.parseInt( request.getParameter( "from" ) );
		}
		ArrayList<ProductoBean> list = productos_main.get( request.getParameter("q"), from );
		int total_regs = -1;
		
		if( list.size() > 0 ){
			total_regs = ((ProductoBean)list.get( 0 )).getTotal_regs();
		}
		
		
		//System.out.println("host>>:: " + pageContext.getRequest().getServerName());
	%>
	<script>
		function edit( id ){
			location.replace( "productos-detail.jsp?mode=edit&id="+id);
		}
		function removereg( id ){
			location.replace( "productos-detail.jsp?mode=remove&id="+id);
		}
		function view( id ){
			location.replace( "productos-detail.jsp?mode=view&id="+id);
		} 
		function add(){
			location.replace( "productos-detail.jsp?mode=add" );
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
          				  <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), Constants.NAME_PRODUCTOS, Constants.OPTIONS_ADD)){ %>
          				  <button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;
          				  <%} %>
          				  
          				  </span>
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> PRODUCTOS </h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  
                                  <th>Codigo</th>
                                  <th>Descripcion</th>
                                  <th class="hidden-phone">Coeficient Unidad</th>
                                  <th class="hidden-phone">Proveedor</th>
                                  <th>Precio</th>
                                  <th class="hidden-phone">Precio importaci&oacute;n</th>
                                  <th >Stock M&iacute;nimo</th>
                                  <th>Foto</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ProductoBean us : list ){
                              %>
                              <tr>
                                  <td><%= us.getCodigo() %></td>
                                  <td><%= us.getDescripcion() %></td>
                                  <td><%= us.getCoeficiente_unidad() %></td>
                                  <td><%= proveedores_main.get(us.getProveedor()).getNombre()  %></td>
                                  <td><%= us.getPrecio() %></td>
                                  <td ><%= us.getPrecio_importacion() %></td>
                                  <td ><%= us.getStock_minimo() %></td>
                                  <td>
                                  	<img src="http://localhost:8080/urbautree-secmod/bin/RenderImage?imagePath=<%= us.getImage_path() %>" width="100px">
                                  </td>
                                  <td>
                                	<% if(Authorization.isAuthorizedOption(loggedUser.getRol(), Constants.NAME_PRODUCTOS, Constants.OPTIONS_MODIFY)){ %>	                                     
                                      <button class="btn btn-primary btn-xs" onclick="edit('<%= us.getId()  %>');"><i class="fa fa-pencil"></i></button>
                                    <%} %>  
                                    <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), Constants.NAME_PRODUCTOS, Constants.OPTIONS_DELETE)){ %>  
                                      <button class="btn btn-danger btn-xs" onclick="removereg('<%= us.getId()  %>');"><i class="fa fa-trash-o "></i></button>
                                    <%} %>  
                                    <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), Constants.NAME_PRODUCTOS, Constants.OPTIONS_VIEW)){ %>  
                                      <button class="btn btn-success btn-xs" onclick="view('<%= us.getId()  %>');"><i class="fa fa-check"></i></button>
                                    <%} %>  
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
					    		<a href="productos.jsp?q=<%= request.getParameter("q") %>&from=<%= from - Constants.ITEMS_PER_PAGE  %>">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } else { %>
					  <li class="previous disabled">
					    		<a href="javascript: return null">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } %>
					    <% if( forwardButton ){  %>
					    <li class="next">
					    	<a href="productos.jsp?q=<%= request.getParameter("q") %>&from=<%= end  %>">
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
			
		</section><! --/wrapper -->
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
