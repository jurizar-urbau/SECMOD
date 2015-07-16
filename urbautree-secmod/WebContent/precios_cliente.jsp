<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.PreciosClienteBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.PreciosClientesMain"%>
<%@page import="com.urbau.beans.PrecioBean"%>
<%@page import="com.urbau.feeders.PreciosMain"%>


<%@page import="com.urbau.feeders.PreciosMain"%>
<%@page import="com.urbau.beans.PrecioBean"%>

<%
	
	System.out.print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>< ");

	String idClienteParameter = request.getParameter("cliente");
	int idCliente  = -1;
	try{
		idCliente = Integer.parseInt(idClienteParameter);	
	}catch(NumberFormatException e){
		System.out.println("Error to parse a string to int for bodega parameter : message : "+ e.getMessage());
	}	
	
	
	if(idCliente >= 0){
	
		System.out.println("idBodega: " + idCliente);
		
		PreciosClientesMain preciosClientes_main = new PreciosClientesMain();
		
		int from = 0;
		if( request.getParameter( "from" ) != null ){
			from = Integer.parseInt( request.getParameter( "from" ) );
		}				
		
		ArrayList<PreciosClienteBean> inventario_list = preciosClientes_main.get( request.getParameter("q"), from);
		int total_regs = -1;
		
		if( inventario_list.size() > 0 ){
			total_regs = ((PreciosClienteBean)inventario_list.get( 0 )).getTotal_regs();
		}
		
		PreciosMain precion_main = new PreciosMain();		
		PrecioBean bodegaBean = precion_main.get(idCliente);
		
		PreciosMain precios_main = new PreciosMain();
		
				
%>


<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>

	<script>
		function edit( id ){		
			var cliente = <%=idCliente%>;
			location.replace( "precios_cliente-detail.jsp?mode=edit&id="+id+"&cliente="+cliente);
		}
		function removereg( id ){
			var cliente = <%=idCliente%>;
			location.replace( "precios_cliente-detail.jsp?mode=remove&id="+id+"&cliente="+cliente);
		}
		function view( id){	
			var cliente = <%=idCliente%>;
			location.replace( "precios_cliente-detail.jsp?mode=view&id="+id+"&cliente="+cliente);
		} 
		function add(){
			var cliente = <%=idCliente%>;
			location.replace( "precios_cliente-detail.jsp?mode=add&cliente="+cliente);
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
	                  	  	  <h4><i class="fa fa-angle-right"></i> PRECIOS DE CLIENTE</h4>
	                  	  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="clientes.jsp">&nbsp;Regresar</a> </h4>
	                  	  	  
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>                                                                                                    
                                  <th>Nombre</th>
                                  <th>Coeficiente</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( PreciosClienteBean bean : inventario_list ){
                              		PrecioBean precioBean = precios_main.get(bean.getIdCliente());
                              %>
                              <tr>
                                  <td><%= precioBean.getNombre() %></td>                                  
                                  <td ><%= precioBean.getCoeficiente() %></td>
                                  <td>
                                  	                                      
                                      <button class="btn btn-primary btn-xs" onclick="edit('<%= bean.getId()  %>');"><i class="fa fa-pencil"></i></button>
                        			  
                                      <button class="btn btn-danger btn-xs" onclick="removereg('<%= bean.getId()  %>');"><i class="fa fa-trash-o "></i></button>
                                      
                                      <button class="btn btn-success btn-xs" onclick="view('<%= bean.getId() %>');"><i class="fa fa-check"></i></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                      
                                                                                                                                                                             
                                                                                                           
                                    
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