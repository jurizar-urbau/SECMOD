<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.InvetarioBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.InventariosMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>


<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page import="com.urbau.beans.ProductoBean"%>

<%
	
	System.out.print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>< ");

	String idBodegaParameter = request.getParameter("bodega");
	int idBodega  = -1;
	try{
		idBodega = Integer.parseInt(idBodegaParameter);	
	}catch(NumberFormatException e){
		System.out.println("Error to parse a string to int for bodega parameter : message : "+ e.getMessage());
	}	
	
	
	if(idBodega >= 0){
	
		System.out.println("idBodega: " + idBodega);
		
		InventariosMain inventario_main = new InventariosMain();
		
		int from = 0;
		if( request.getParameter( "from" ) != null ){
			from = Integer.parseInt( request.getParameter( "from" ) );
		}				
		
		ArrayList<InvetarioBean> inventario_list = inventario_main.get( request.getParameter("q"), from ,idBodega);
		int total_regs = -1;
		
		if( inventario_list.size() > 0 ){
			total_regs = ((InvetarioBean)inventario_list.get( 0 )).getTotal_regs();
		}
		
		BodegasMain bodega_main = new BodegasMain();
		BodegaBean bodegaBean = bodega_main.getBodega(idBodega);
		
		ProductosMain productos_main = new ProductosMain();
		
				
%>


<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>

	<script>
		function edit( id, estatus ){		
			var bodega = <%=idBodega%>;
			location.replace( "inventarios-detail.jsp?mode=edit&id="+id+"&estatus="+estatus+"&bodega="+bodega);
		}
		function removereg( id, estatus ){
			var bodega = <%=idBodega%>;
			location.replace( "inventarios-detail.jsp?mode=remove&id="+id+"&estatus="+estatus+"&bodega="+bodega);
		}
		function view( id, estatus ){	
			var bodega = <%=idBodega%>;
			location.replace( "inventarios-detail.jsp?mode=view&id="+id+"&estatus="+estatus+"&bodega="+bodega);
		} 
		function add(){
			var bodega = <%=idBodega%>;
			location.replace( "inventarios-detail.jsp?mode=add&bodega="+bodega);
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
	                  	  	  <h4><i class="fa fa-angle-right"></i> INVENTARIO  DE <%= bodegaBean.getNombre()%></h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  
                                  <th>Producto</th>
                                  <th class="hidden-phone">Estatus</th>
                                  <th>Cantidad</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( InvetarioBean bean : inventario_list ){
                              		 ProductoBean productoBean = productos_main.get(bean.getId_product());
                              %>
                              <tr>
                                  <td><%= productoBean.getDescripcion() %></td>
                                  <td class="hidden-phone"><%= bean.getEstatus() %></td>
                                  <td ><%= bean.getAmount() %></td>
                                  <td>
                                  	                                      
                                      <button class="btn btn-primary btn-xs" onclick="edit('<%= bean.getId_product()  %>', '<%= bean.getEstatus()  %>');"><i class="fa fa-pencil"></i></button>
                        			  
                                      <button class="btn btn-danger btn-xs" onclick="removereg('<%= bean.getId_product()  %>', '<%= bean.getEstatus()  %>');"><i class="fa fa-trash-o "></i></button>
                                      
                                      <button class="btn btn-success btn-xs" onclick="view('<%= bean.getId_product() %>','<%= bean.getEstatus()  %>');"><i class="fa fa-check"></i></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                      
                                                                        
                                                                  
                                                                                                           
                                    
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
					    		<a href="bodegas.jsp?q=<%= request.getParameter("q") %>&from=<%= from - Constants.ITEMS_PER_PAGE  %>">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } else { %>
					  <li class="previous disabled">
					    		<a href="javascript: return null">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } %>
					    <% if( forwardButton ){  %>
					    <li class="next">
					    	<a href="bodegas.jsp?q=<%= request.getParameter("q") %>&from=<%= end  %>">
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

<% 		
} else {
%>
		<p>La bodega NO EXISTE</p>
<%
 } 
%>