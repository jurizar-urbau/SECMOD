<%@page import="com.urbau.feeders.BodegasUsuariosMain"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.feeders.BancosMain"%>
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
		
		ExtendedFieldsBaseMain traslados_head = new ExtendedFieldsBaseMain( "TRASLADOS_HEADER", 
				new String[]{"BODEGA_ORIGEN","BODEGA_DESTINO","FECHA","ESTADO","USUARIO","TRANSID","ID"},
				new int[]{ Constants.EXTENDED_TYPE_INTEGER, Constants.EXTENDED_TYPE_INTEGER, Constants.EXTENDED_TYPE_DATE, Constants.EXTENDED_TYPE_STRING,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_STRING} );
			
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter(new String[]{"ESTADO"}, new int[]{ ExtendedFieldsFilter.EQUALS},new int[]{Constants.EXTENDED_TYPE_STRING}, new String[]{"C"});
		
		ArrayList<ExtendedFieldsBean> transitList = traslados_head.getAll(filter);

		
		
		ExtendedFieldsBaseMain traslados_detail = new ExtendedFieldsBaseMain( "TRASLADOS_DETAIL", 
				new String[]{"ID_TRASLADO","PRODUCTO","UNIDADES","PACKING"},
				new int[]{ 
					Constants.EXTENDED_TYPE_INTEGER, 
					Constants.EXTENDED_TYPE_INTEGER, 
					Constants.EXTENDED_TYPE_INTEGER, 
					Constants.EXTENDED_TYPE_STRING
				} );
		
	%>
	
	</head>
   
   <body>
   
  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      
      <header class="header black-bg no-print">
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
          <div class="col-lg-6 no-print">
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
	                  	  	  <h4><i class="fa fa-angle-right"></i> TRASLADOS EN TRANSITO </h4>
	                  	  	  <hr>
	                  	  	  <%  
	                  	  		BodegasUsuariosMain bm = new BodegasUsuariosMain();
	                  	  	  	ArrayList<BodegaBean> listS = bm.getForUser( loggedUser.getId() );
	                  	  	  	
	                  	  	  %>
	                  	  	  <form method="POST">
	                  	  	  <select name="bodega">
	                  	  	  	<option value="">Seleccione una bodega</option>
	                  	  	  <% for( BodegaBean b : listS ){ %>
	                  	  	  	<option value="<%= b.getId()%>"><%= b.getNombre() %></option>
	                  	  	  	<% } %>
	                  	  	  </select>
	                  	  	  <input type="submit" value="Ver">
	                  	  	  </form>
	                  	  	  <thead>
                              
                              <tr>
	                              <th>Fecha</th>
	                              <th>Bodega origen</th>
	                              <th>Bodega destino</th>
                                  <th>Usuario</th>
                                  <th>Transacci&oacute;n</th>                                                                    
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for(ExtendedFieldsBean bean: transitList ){
                              		if ( bean.getValue( "BODEGA_DESTINO" ).equals( request.getParameter("bodega") ) ){
                              %>
                              <tr onclick="chargeOrder('<%= bean.getValue( "ID" ) %>')">
                              	  <td><%= bean.getValue( "FECHA")  %></td>
                                  <td><%= bean.getReferenced( "BODEGA_ORIGEN", "BODEGAS", "NOMBRE")  %></td>
                                  <td><%= bean.getReferenced( "BODEGA_DESTINO", "BODEGAS", "NOMBRE")   %></td>
                                  <td><%= bean.getReferenced( "USUARIO", "USUARIOS", "NOMBRE")   %></td>
                                  <td><%= bean.getValue( "TRANSID")  %></td>                                  
                                                                                                                                                                                                           
                                                                    
                                 
                              </tr>
                              <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal<%= bean.getValue( "ID" ) %>" class="modal fade">
									
										<input type="hidden" name="trasladoid" value="<%= bean.getValue( "ID" ) %>">
									  	<div class="modal-dialog">
						                  <div class="modal-content">
							                  <div class="modal-header">
						                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						                          <h4 class="modal-title">RECIBIR</h4>
						                      </div>
						                      <div class="modal-body">
						                      <%
						                      ExtendedFieldsFilter filterDetail =
						                      new ExtendedFieldsFilter(
						                    		  new String[]{"ID_TRASLADO"}, 
						                    		  new int[]{ ExtendedFieldsFilter.EQUALS},
						                    		  new int[]{Constants.EXTENDED_TYPE_INTEGER}, 
						                    		  new String[]{ String.valueOf( bean.getValue( "ID" ))});
						                      ArrayList<ExtendedFieldsBean> detalles = traslados_detail.getAll( filterDetail );
						                      for( ExtendedFieldsBean detailBean : detalles ){
						                      %>
						                      	Unidades: <%= Integer.valueOf( detailBean.getValue( "UNIDADES" ) ) * Integer.valueOf( detailBean.getValue( "PACKING" ) )  %> - <%= detailBean.getReferenced( "PRODUCTO", "PRODUCTOS", "DESCRIPCION" ) %><br> 
						                      <% } %>
						                      	
						                      </div>
						                      <div class="modal-footer">
						                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
						                          <button class="btn btn-theme" type="button" onclick="recibir('<%= bean.getValue( "ID" ) %>')">Recibir</button>
						                          
						                      </div>
						                  </div>
						              </div>
					              
					          </div>
                              <% }
                              		}
                              %>
                              
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
							<input type="hidden" name="id" id="id">
							<input type="hidden" name="action" id="action">
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">RECIBIR</h4>
			                      </div>
			                      <div class="modal-body">
			                       
			                      
			                      	the body
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="savebutton">Recibir</button>
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
		
		function chargeOrder( id ){
			$('#myModal' + id ).modal('show');
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
		
		function recibir( id ){
			$('#id').val(id);
			$('#action').val('A');
			var form =$('#modalform');
	     	$.ajax({
	     		type:'POST',
	     		dataType: "text",
	 			url: './bin/TransitoBodega',
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
		}
		
		$("#savebutton").click(function(){
			
			var form =$('#modalform');
	     	$.ajax({
	     		type:'POST',
	     		dataType: "text",
	 			url: './bin/TransitoBodega',
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
		
			
         function setTarjeta(){
       	  $('#numero_cheque').val('');
       	  //$('#banco').val('');
       	  $('#tipo_tarjeta').val('');
       	  $('#numero_tarjeta').val('');
       	  $('#autorizacion').val('');
       	  
       	  $('#numero_cheque').prop('readonly', true);
       	  $('#banco').prop('disabled', false);
       	  $('#tipo_tarjeta').prop('readonly', false);
       	  $('#numero_tarjeta').prop('readonly', false);
       	  $('#autorizacion').prop('readonly', false);
       	  
       	  $('#monto').prop('readonly', false);
       	  $('#banco').focus();
       	  
         }
         
         function setEfectivio(){
       	  $('#numero_cheque').val('');
       	  $('#banco').val('');
       	  $('#tipo_tarjeta').val('');
       	  $('#numero_tarjeta').val('');
       	  $('#autorizacion').val('');
       	  
       	  $('#numero_cheque').prop('readonly', true);
       	  $('#banco').prop('disabled', 'disabled');
       	  $('#tipo_tarjeta').prop('readonly', true);
       	  $('#numero_tarjeta').prop('readonly', true);
       	  $('#autorizacion').prop('readonly', true);
       	  
       	  $('#monto').prop('readonly', false);
       	  $('#monto').focus();
       	  
         }
         
         function setCheque(){
	       	  $('#numero_cheque').val('');
	       	  $('#banco').val('');
	       	  $('#tipo_tarjeta').val('');
	       	  $('#numero_tarjeta').val('');
	       	  $('#autorizacion').val('');
	       	  
	       	  $('#numero_cheque').prop('readonly', false);
	       	  $('#banco').prop('disabled', false);
	       	  $('#tipo_tarjeta').prop('readonly', true);
	       	  $('#numero_tarjeta').prop('readonly', true);
	       	  $('#autorizacion').prop('readonly', true);
	       	  
	       	  $('#monto').prop('readonly', false);
	       	  $('#numero_cheque').focus();
	       	  
         }
         
         $(function() {
 	    	
     		
     		$("#tipo_pago").change(function() {
     			var opt = $("#tipo_pago").val();
     			if( opt === "efectivo" ){
     				setEfectivio();
     			} else if( opt === "tarjeta" ){
     				setTarjeta();
     			} else if( opt === "cheque" ){
     				setCheque();
     		    } else if( opt === "credito" ){
     		    	setEfectivio();
     			}  
     		});
     		setEfectivio();
         });
		
	    </script>
  </body>
</html>
