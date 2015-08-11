<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.PreciosPuntoDeVentaBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.PreciosPuntosDeVentasMain"%>
<%@page import="com.urbau.beans.PrecioBean"%>
<%@page import="com.urbau.feeders.PreciosMain"%>


<%
		

	String puntoDeVenta = request.getParameter("puntoDeVenta");
	String qParameter = request.getParameter("q");
	String fromParameter = request.getParameter( "from" );
	
	int idPuntoDeVenta  = -1;
	try{
		idPuntoDeVenta = Integer.parseInt(puntoDeVenta);	
	}catch(NumberFormatException e){
		System.out.println("Error to parse a string to int for bodega parameter : message : "+ e.getMessage());
	}	
	
	
	if(idPuntoDeVenta >= 0){
	
		System.out.println("PuntoDeVenta X Precios - idCliente: " + idPuntoDeVenta);
		
		PreciosPuntosDeVentasMain preciosPuntoDeVenta_main = new PreciosPuntosDeVentasMain();
		
		int from = 0;
		if( fromParameter != null ){
			from = Integer.parseInt( fromParameter );
		}				
		
		ArrayList<PreciosPuntoDeVentaBean> preciosClienteList = preciosPuntoDeVenta_main.get( qParameter, from);
		
		
		int total_regs = -1;
		
		if( preciosClienteList.size() > 0 ){
			total_regs = ((PreciosPuntoDeVentaBean)preciosClienteList.get( 0 )).getTotal_regs();
		}
				
				
%>


<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>

	<script>
		function edit( id,idPrecio ){		
			var cliente = <%=idPuntoDeVenta%>;
			location.replace( "puntodeventa_precios-detail.jsp?mode=edit&id="+id+"&puntoDeVenta="+cliente+"&precio="+idPrecio);
		}
		function removereg( id,idPrecio ){
			var cliente = <%=idPuntoDeVenta%>;
			location.replace( "puntodeventa_precios-detail.jsp?mode=remove&id="+id+"&puntoDeVenta="+cliente+"&precio="+idPrecio);
		}
		function view( id){	
			var cliente = <%=idPuntoDeVenta%>;
			location.replace( "puntodeventa_precios-detail.jsp?mode=view&id="+id+"&puntoDeVenta="+cliente);
		} 
		function add(){
			var cliente = <%=idPuntoDeVenta%>;
			location.replace( "puntodeventa_precios-detail.jsp?mode=add&puntoDeVenta="+cliente);
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
          		
          				
          				  <span class="pull-right">
          				  	<button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;          				  
          				  </span>
          				
          				  
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> PRECIOS POR PUNTO DE VENTAS</h4>
	                  	  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="puntosdeventas.jsp">&nbsp;Regresar</a> </h4>
	                  	  	  
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
                              PreciosMain precios_main = new PreciosMain();
                              	for( PreciosPuntoDeVentaBean bean : preciosClienteList ){
                              		if(idPuntoDeVenta == bean.getIdPuntoDeVenta()){
                              			                              	                              	
                              		PrecioBean precioBean = precios_main.get(bean.getIdPrecio());
                              %>
                              <tr>
                                  <td><%= precioBean.getNombre() %>  </td>                                  
                                  <td ><%= precioBean.getCoeficiente() %></td>
                                  <td>
                                  	                                      
                                      <button class="btn btn-primary btn-xs" onclick="edit('<%= bean.getId() %>','<%= precioBean.getId()  %>');"><i class="fa fa-pencil"></i></button>
                        			  
                                      <button class="btn btn-danger btn-xs" onclick="removereg('<%= bean.getIdPrecio()  %>','<%= precioBean.getId()  %>');"><i class="fa fa-trash-o "></i></button>
                                      
                                      <button class="btn btn-success btn-xs" onclick="view('<%= precioBean.getId() %>');"><i class="fa fa-check"></i></button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                      
                                                                                                                                                                             
                                                                                                           
                                    
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