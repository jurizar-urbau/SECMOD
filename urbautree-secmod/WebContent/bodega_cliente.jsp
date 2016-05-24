<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.BodegaClienteBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.BodegasClientesMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>


<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>

<%
		

	String idClienteParameter = request.getParameter("cliente");
	String qParameter = request.getParameter("q");
	String fromParameter = request.getParameter( "from" );
	
	int idCliente  = -1;
	try{
		idCliente = Integer.parseInt(idClienteParameter);	
	}catch(NumberFormatException e){
		System.out.println("Error to parse a string to int for bodega parameter : message : "+ e.getMessage());
	}	
	
	
	if(idCliente >= 0){
	
		System.out.println("ClienteXPrecios - idCliente: " + idCliente);
		
		BodegasClientesMain preciosClientes_main = new BodegasClientesMain();
		
		int from = 0;
		if( fromParameter != null ){
			from = Integer.parseInt( fromParameter );
		}				
		
		ArrayList<BodegaClienteBean> bodegaClienteList = preciosClientes_main.get( qParameter, from);
		
		
		int total_regs = -1;
		
		if( bodegaClienteList.size() > 0 ){
			total_regs = ((BodegaClienteBean)bodegaClienteList.get( 0 )).getTotal_regs();
		}
				
%>


<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>

	<script>
		function edit( id,idBodega ){		
			var cliente = <%=idCliente%>;
			location.replace( "bodega_cliente-detail.jsp?mode=edit&id="+id+"&cliente="+cliente+"&bodega="+idBodega);
		}
		function removereg( id,idBodega ){
			var cliente = <%=idCliente%>;
			location.replace( "bodega_cliente-detail.jsp?mode=remove&id="+id+"&cliente="+cliente+"&bodega="+idBodega);
		}
		function view( id){	
			var cliente = <%=idCliente%>;
			location.replace( "bodega_cliente-detail.jsp?mode=view&id="+id+"&cliente="+cliente);
		} 
		function add(){
			var cliente = <%=idCliente%>;
			location.replace( "bodega_cliente-detail.jsp?mode=add&cliente="+cliente);
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
			              		<li><input type="text" class="form-control" id="search-query-3" name="q" value="<%= ( qParameter != null && !"null".equals( qParameter )) ? qParameter : "" %>" ></li>
			                    <li><button class="btn btn-primary">Buscar</button></li>
			              </ul>
		            </div>
			    </form>
			  </div>
			  <br/>
			  
          	
          	<div class="row mt">
          		<div class="col-lg-12">
          		<div class="content-panel">
          		
          				<% if(Authorization.isAuthorizedOption(loggedUser.getRol(), "BODEGA_CLIENTE", Constants.OPTIONS_ADD)){ %>
          				  <span class="pull-right">
          				  	<button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;          				  
          				  </span>
          				<% } %>
          				  
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> BODEGAS DE CLIENTE</h4>
	                  	  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="clientes.jsp">&nbsp;Regresar</a> </h4>
	                  	  	  
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>                                                                                                    
                                  <th>Nombre</th>                                  
                                  <th>Direccion</th>
                                  <th>Telefono</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              BodegasMain bodegas_main = new BodegasMain();
                              	for( BodegaClienteBean bean : bodegaClienteList ){
                              		if(idCliente == bean.getIdCliente()){
                              			
                              		
                              		
                              		BodegaBean bodegaBean = bodegas_main.getBodega(bean.getIdBodega());
                              %>
                              <tr>
                                  <td><%= bodegaBean.getNombre() %>  </td>                                  
                                  <td ><%= bodegaBean.getDireccion() %></td>
                                  <td ><%= bodegaBean.getTelefono() %></td>
                                  <td>
                                  	  <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), "BODEGA_CLIENTE", Constants.OPTIONS_MODIFY)){ %>                                    
                                      	<button class="btn btn-primary btn-xs" onclick="edit('<%= bean.getId() %>','<%= bodegaBean.getId()  %>');"><i class="fa fa-pencil"></i></button>
                                      <% } %>
                        			  <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), "BODEGA_CLIENTE", Constants.OPTIONS_DELETE)){ %>
                                      <button class="btn btn-danger btn-xs" onclick="removereg('<%= bean.getIdBodega()  %>','<%= bodegaBean.getId()  %>');"><i class="fa fa-trash-o "></i></button>
                                      <% } %>
                                      <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), "BODEGA_CLIENTE", Constants.OPTIONS_VIEW)){ %>
                                      <button class="btn btn-success btn-xs" onclick="view('<%= bodegaBean.getId() %>');"><i class="fa fa-check"></i></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                      
 									  <% } %>                                                                                                                                                                            
                                                                                                           
                                    
                                  </td>
                              </tr>
                              <% }} %>
                              
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