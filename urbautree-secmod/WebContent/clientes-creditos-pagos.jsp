<%@page import="com.urbau.feeders.BancosMain"%>
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
	
	BancosMain bancosMain = new BancosMain();
	ArrayList<String[]> bancosList = bancosMain.getCombo( "BANCOS", "ID ", " DESCRIPCION" );
	
	StringBuffer bancosOptions = new StringBuffer();
	for( String[] option : bancosList ){
		bancosOptions.append( "<option value='" ).append( option[ 0 ] ).append( "'>").append( option[1] ).append("</option>");
	}
	ExtendedFieldsBaseMain creditos_cliente = new ExtendedFieldsBaseMain( "CLIENTES_CREDITOS_PAGOS", 
			new String[] { "ID_CREDITO","FECHA","MONTO","TIPO_PAGO","NO_AUTORIZACION","NO_CHEQUE","ID_BANCO","TIPO_TARJETA","NO_TARJETA" }	
			, new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DATE,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING
			} );
	
	
			ExtendedFieldsFilter filter = new ExtendedFieldsFilter( new String[]{"ID_CREDITO"},new int[]{ ExtendedFieldsFilter.EQUALS}, new int[]{ Constants.EXTENDED_TYPE_INTEGER}, new String[]{ request.getParameter( "id" ) });
			ArrayList<ExtendedFieldsBean> list = creditos_cliente.getAll( filter );
	%>
	<script>
		function pagos( id ){
			location.replace( "clientes-creditos-pagos.jsp?id="+id);
		}
		function add(){
			$('#myModal').modal('show');
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
          
			  
          	
          	<div class="row mt">
          		<div class="col-lg-12">
          		<div class="content-panel">
          				  <span class="pull-right">
          				  <button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;
          				  
          				  </span>
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-left"><a href="clientes-creditos.jsp?id-cliente=<%= request.getParameter( "id" ) %>">Regresar...</a></i> Pagos de credito </h4>
	                  	  	  <hr>
	                  	  	  <thead>
	                  	  	  
                              <tr>
                                  <th>Fecha</th>
                                  <th>Monto</th>
                                  <th>Tipo pago</th>
                                  <th>No. Autorizaci&oacute;n</th>
                                  <th>No. Cheque</th>
                                  <th>Banco</th>
                                  <th>Tipo tarjeta</th>
                                  <th>No. Tarjeta</th>
                                  
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              %>
                              <tr>
                              
								  <td><%= us.getValue( "FECHA" ) %></td>
                                  <td><%= us.getValue( "MONTO" ) %></td>
                                  <td><%= us.getValue( "TIPO_PAGO" ) %></td>
                                  <td><%= us.getValue( "NO_AUTORIZACION" ) %></td>
                                  <td><%= us.getValue( "NO_CHEQUE" ) %></td>
                                  <td><%= us.getValue( "BANCO" ) %></td>
                                  <td><%= us.getValue( "TIPO_TARJETA" ) %></td>
                                  <td><%= us.getValue( "NO_TARJETA" ) %></td>
                                 
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
                         
                      </div>
            	</div>
          	</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

			<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
						
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">ABONO</h4>
			                      </div>
			                      <div class="modal-body">
			                       <form id="modalform" name="modalform"  class="form-horizontal style-form">
			                      
			                      	<input type="hidden" name="formid" id="formid" value="<%= request.getParameter( "id" ) %>">
			                      	  <label>Saldo: <b id="formmonto"></b></label><br/>
			                      	  	<div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Tipo de pago:</label>
				                          	<div class="col-sm-4">
				                              <select class="form-control" id="tipo_pago" name="tipo_pago">
				                              		<option value="efectivo">Efectivo</option>
				                              		<option value="tarjeta">Tarjeta Credito/Debito</option>
				                              		<option value="cheque">Cheque</option>
				                              	</select>
				                          	</div>
				                          	<label class="col-sm-2 col-sm-2 control-label">No. Cheque:</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="numero_cheque" name="numero_cheque">
				                          	</div>
				                      	</div>
				                      <div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Banco</label>
				                          	<div class="col-sm-4">
				                          		<select class="form-control" id="banco" name="banco"><%=bancosOptions %></select>
				                          	</div>
				                      	                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Tipo de tarjeta</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="tipo_tarjeta" name="tipo_tarjeta">
				                          	</div>
				                      	</div>
				                    <div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">No. Tarjeta</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="numero_tarjeta" name="numero_tarjeta">
				                          	</div>
				                      	  	<label class="col-sm-2 col-sm-2 control-label">Autorizaci&oacute;n</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="autorizacion" name="autorizacion">
				                          	</div>
				                      	</div>
				                      	<div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Monto</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="monto" name="monto" size="7">
				                          	</div>
				                      	</div>
				                   
				                      </form>
						 
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="savebutton">Pagar</button>
			                          <button class="btn btn-theme" type="button" onclick="printBill('elcontenido');">Imprimir</button>
			                          
			                      </div>
			                  </div>
			              </div>
		              
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
         
         $("#savebutton").click(function(){
		
				var form =$('#modalform');
		     	$.ajax({
		     		type:'POST',
		     		dataType: "text",
		 			url: './bin/SaveCreditOrderPayment',
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
