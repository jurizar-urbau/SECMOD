<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.OrdenExtendedBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.OrdenesExtendedMain"%>
<%@page import="com.urbau.security.Authorization"%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<!--  META HTTP-EQUIV="refresh" CONTENT="15">-->

	<%@include file="fragment/head.jsp"%>
	<%
		OrdenesExtendedMain oem = new OrdenesExtendedMain();			
		
		ArrayList<OrdenExtendedBean> list = oem.get( request.getParameter("q"), loggedUser.getPunto_de_venta() );  //TODO selected store.
		
	%>
	<script>
		function edit( id ){
			location.replace( "clientes-detail.jsp?mode=edit&id="+id);
		}
		function removereg( id ){
			location.replace( "clientes-detail.jsp?mode=remove&id="+id);
		}
		function view( id ){
			location.replace( "clientes-detail.jsp?mode=view&id="+id);
		}
		function add(){
			location.replace( "clientes-detail.jsp?mode=add" );
		}
		function clientePrecios( id ){
			location.replace( "cliente_precios.jsp?cliente="+id );					
		}
		function bodegaCliente( id ){
			location.replace( "bodega_cliente.jsp?cliente="+id );					
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
          				<% //if(Authorization.isAuthorizedOption(loggedUser.getRol(), Constants.NAME_PROVEEDORES, Constants.OPTIONS_ADD)){ %>          				
          				  <span class="pull-right">
          				  	<button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;          				  
          				  </span>
          				<%//}%>  
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> ORDENES - CAJA </h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  <th></th>                                  
                                  <th colspan="3">Cliente</th>
                                  <th></th>
                                  <th></th>
                              </tr>
                              <tr>
                                  <th>Fecha</th>                                  
                                  <th>Nit</th>
                                  <th>Nombres</th>                                                                    
                                  <th>Apellidos</th>
                                  <th>Monto</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for(OrdenExtendedBean bean: list ){
                              %>
                              <tr>
                                  <td><%= Util.getDateStringDMYHM( bean.getFecha() ) %></td>                                  
                                  <td><%= bean.getCliente_nit() %></td>
                                  <td><%= bean.getCliente_nombres() %></td>                                                                    
                                  <td><%= bean.getCliente_apellidos() %></td>
                                  <td><%= Util.formatCurrency( bean.getMonto() )%></td>                                                                                                                                                                         
                                                                    
                                  <td>
                                  	<a href="javascript: chargeOrder('<%= bean.getId() %>','<%= Util.getDateStringDMYHM( bean.getFecha() ) %>','<%= bean.getCliente_nit() %>','<%= bean.getCliente_nombres()  %>', '<%= bean.getCliente_apellidos() %>',<%= bean.getMonto() %>)">Pagar</a>
                                  </td>
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
                         
                      </div>
                      <%
			
		%>
		           
          		</div>
          	</div>
			
		</section><! --/wrapper -->
      </section><!-- /MAIN CONTENT -->
 	<!-- clients modal -->
      	 
					<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">PAGAR</h4>
			                      </div>
			                      <div class="modal-body">
			                      	<input type="hidden" name="formid" id="formid" value="">
			                      	  <label>Fecha: <b id="formfecha"></b></label>
			                      	  <label>Nit: <b id="formnit"></b></label><br/>
			                      	  <label>Cliente: <b id="formnombres"></b> <b id="formapellidos"></b></label><br/>
			                      	  <label>Monto: <b id="formmonto"></b></label><br/>
				                      <label>Tipo de pago: 
				                      	<select name="tipopago"  class="form-control">
				                      		<option value="T">Tarjeta</option>
				                      		<option value="E">Efectivo</option>
				                      		<option value="C">Credito</option>
				                      	</select>
				                      </label><br/>
				                      <label>No. Autorizaci&oacute;n: <input type="text" class="form-control" name="autorizacion"></label>
				                      <label>Efectivo: <input type="text" class="form-control" name="efectivo"></label>
				                      <label>Cr&eacute;dito: <input type="text" class="form-control" name="credito"></label>
				                      <label>Cheque: <input type="text" class="form-control" name="nocheque"></label>
				                      
						 
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="savebutton">Pagar</button>
			                          <button class="btn btn-theme" type="button" onclick="printBill('elcontenido');">Imprimir</button>
			                          
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>
      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
	<%@include file="fragment/footerscripts.jsp"%>
	<script>
		
		function chargeOrder( id, fecha,nit,nombres,apellidos,monto ){
			$('#formid').val( id );
			$('#formfecha').html(fecha);
			$('#formnit').html(nit);
			$('#formnombres').html(nombres);
			$('#formapellidos').html(apellidos);
			$('#formmonto').html(monto);
			$('#myModal').modal('show');
		}
		
		function printBill(content) {
			 top.consoleRef=window.open('','myconsole',
		  'width=350,height=250'
		   +',menubar=0'
		   +',toolbar=1'
		   +',status=0'
		   +',scrollbars=1'
		   +',resizable=1')
		 top.consoleRef.document.writeln(
		  '             1721142-5      JOSE ALEJANDRO URIZAR\n1\t' + content
		 )
		 top.consoleRef.document.close()
		 top.consoleRef.print()
		}
		
		$("#savebutton").click(function(){
			
			var form =$('#saleform');
	     	$.ajax({
	     		type:'POST',
	     		dataType: "text",
	 			url: './bin/SavePayment',
	 			data: form.serialize(),
	 			
		        success: function(msg){		      
		        	alert( msg );
		        	if( !msg.startsWith('error') ){
		        		location.reload();	
		        	}
		            
		        },
	 			error: function(jqXHR, textStatus, errorThrown){
	 				console.log("ERROR srtatus: ", textStatus);
	 				console.log("ERROR errorThrown: ", errorThrown);
	 				alert("Se prudujo un error al hacer la operaciòn");	
	 			}
		            		        
	       });
	     	
	     	return false;
	 	});
	    </script>
  </body>
</html>
