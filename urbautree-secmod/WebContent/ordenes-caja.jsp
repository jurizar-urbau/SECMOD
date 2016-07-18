<%@page import="com.urbau.misc.EncryptUtils"%>
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
		boolean clientecredito = false;
		BancosMain bancosMain = new BancosMain();
		ArrayList<String[]> bancosList = bancosMain.getCombo( "BANCOS", "ID ", " DESCRIPCION" );
		
		StringBuffer bancosOptions = new StringBuffer();
		for( String[] option : bancosList ){
			bancosOptions.append( "<option value='" ).append( option[ 0 ] ).append( "'>").append( option[1] ).append("</option>");
		}
			
			
		OrdenesExtendedMain oem = new OrdenesExtendedMain();			
		
		int cajaid = loggedUser.getCaja_punto_de_venta();
		boolean opened = Util.isOpenedCaja( cajaid );
		
		
		ArrayList<OrdenExtendedBean> list = new ArrayList<OrdenExtendedBean>(); 
		if( opened ){				
			list = oem.get( request.getParameter("q"), loggedUser.getPunto_de_venta() );
		}
		
	%>
	<style>
		.red{
			color: red;
		}
	</style>
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
            
          	
          	<div class="row mt">
          		<div class="col-lg-12">
          		<div class="content-panel">
          		
          		<% if( opened ){ %>
	          		<form id="toggleValue" name="toggleValue">
	          			<input type="hidden" name="action" value="close">
	          			<input type="hidden" name="id_punto_venta" value="<%= loggedUser.getPunto_de_venta() %>">
	          			<input type="hidden" name="id_caja" value="<%= loggedUser.getCaja_punto_de_venta() %>">
	          		</form>
          				  <span class="pull-right"><button class="btn btn-theme" onclick="cerrar()">Cerrar Caja</button>&nbsp;</span>
          		<% } else { %>
          			<form id="toggleValue" name="toggleValue">
	          			<input type="hidden" name="action" value="open">
	          			<input type="hidden" name="id_punto_venta" value="<%= loggedUser.getPunto_de_venta() %>">
	          			<input type="hidden" name="id_caja" value="<%= loggedUser.getCaja_punto_de_venta() %>">
	          		</form>
          				  <span class="pull-right"><button class="btn btn-success"  onclick="abrir()">Abrir Caja</button>&nbsp;</span>
          		<% } %>
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> CAJA [<%= loggedUser.getNombre_caja_punto_venta() %>]</h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              
                              <tr>
                              	 <th>Orden</th>
                                  <th>Fecha</th>                                  
                                  <th>Nit</th>
                                  <th>Nombres</th>                                                                    
                                  <th>Apellidos</th>
                                  <th>Monto</th>
                              
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for(OrdenExtendedBean bean: list ){
                              		
                              %>
                              <tr onclick="chargeOrder('<%= bean.getId() %>','<%= Util.getDateStringDMYHM( bean.getFecha() ) %>','<%= bean.getCliente_nit() %>','<%= bean.getCliente_nombres()  %>', '<%= bean.getCliente_apellidos() %>',<%= bean.getMonto() %>,<%= bean.isAcepta_credito() %>,<%= bean.getCliente_id() %>)">
                              	  <td><%= bean.getId() %></td>
                                  <td><%= Util.getDateStringDMYHM( bean.getFecha() ) %></td>                                  
                                  <td><%= bean.getCliente_nit() %></td>
                                  <td><%= bean.getCliente_nombres() %></td>                                                                    
                                  <td><%= bean.getCliente_apellidos() %></td>
                                  <td><%= Util.formatCurrency( bean.getMonto() )%></td>                                                                                                                                                                         
                                                                    
                                 
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
						
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">PAGAR</h4>
			                      </div>
			                      <div class="modal-body">
			                       <form id="modalform" name="modalform"  class="form-horizontal style-form">
			                      <H1 id="creditooptionlabel" class="red pull-right"></H1>
			                      	<input type="hidden" name="formid" id="formid" value="">
			                      	  <label>Fecha: <b id="formfecha"></b></label>
			                      	  <label>Nit: <b id="formnit"></b></label><br/>
			                      	  <label>Cliente: <b id="formnombres"></b> <b id="formapellidos"></b></label>
			                      	  
			                      	  <label>Monto: <b id="formmonto"></b></label><br/>
			                      	  <div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Factura</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="factura" name="factura">
				                          	</div>
				                      	</div>
			                      	  	<div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Tipo de pago:</label>
				                          	<div class="col-sm-4">
				                              <select class="form-control" id="tipo_pago" name="tipo_pago">
				                              		<option value="efectivo">Efectivo</option>
				                              		<option value="tarjeta">Tarjeta Credito/Debito</option>
				                              		<option value="credito" id="creditooption" <%= clientecredito ? "":"disabled" %>>Cliente credito</option>
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
				                          		<select class="form-control" id="tipo_tarjeta" name="tipo_tarjeta">
				                              		<option value="debito">D&eacute;bito</option>
				                              		<option value="credito">Cr&eacute;dito</option>
				                              	</select>
				                          		
				                          		
				                          	</div>
				                      	</div>
				                    <div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Autorizaci&oacute;n</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="autorizacion" name="autorizacion">
				                          	</div>
				                      	  	<label class="col-sm-2 col-sm-2 control-label">#Cupon de descuento</label>
				                          	<div class="col-sm-4">
				                          		<!-- <input class="form-control" id="cupon" name="cupon" size="7"> -->
				                          		<select class="form-control" id="cupon" name="cupon" onChange="setDescuento(this)">
				                          		</select>
				                          	</div>
				                      	</div>
				                      	
				                      	
				                      	 <div class="form-group">
				                      	    <label class="col-sm-2 col-sm-2 control-label">Descuento</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="descuento" name="descuento" size="7"  readonly>
				                          	</div>                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Monto</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="subtotal" name="subtotal" size="7" readonly>
				                          	</div>
				                          	
				                      	  	
				                      	</div>
				                      	 <div class="form-group">
				                      	    <label class="col-sm-2 col-sm-2 control-label"></label>
				                          	<div class="col-sm-4">
				                          	</div>                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Total</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="monto" name="monto" size="7">
				                          	</div>
				                          	
				                      	  	
				                      	</div>
				                      	
				                   
				                      </form>
						 
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="savebutton">Pagar</button>
			                          <!-- button class="btn btn-theme" type="button" onclick="printBill();">Imprimir Orden</button -->
			                          
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
	
		var acepta_credito = false;
		var selectedID;
		
		function abrir(){
			if( confirm( "Confirma que desea abrir la caja? " ) ){
				 toggle( "Caja abierta" );
			}
		}
		
		
		function cerrar(){
			if( confirm( "Confirma que desea cerrar la caja? " ) ){
				toggle( "Caja cerrada" );
			}
		}
		function toggle(successmessage){
			if(  true  ){
				var form =$('#toggleValue');
		     	$.ajax({
		     		type:'POST',
		     		dataType: "text",
		 			url: './bin/ClosePayments',
		 			data: form.serialize(),
		 			
			        success: function(msg){
			        	if( msg === "true" ){
			        		alert( successmessage );
			        		location.reload();
			        	} else {
			        		alert( "Ha ocurrido un error.");
			        	}
			            
			        },
		 			error: function(jqXHR, textStatus, errorThrown){
		 				console.log("ERROR srtatus: ", textStatus);
		 				console.log("ERROR errorThrown: ", errorThrown);
		 				alert("Se prudujo un error al hacer la operaciòn");	
		 			}
			            		        
		       });
		     	
		     	
				
			}
		}
		
		function chargeOrder( id, fecha,nit,nombres,apellidos,monto, aceptacredito, idcliente ){
			selectedID = id;
			$('#formid').val( id );
			$('#formfecha').html(fecha);
			$('#formnit').html(nit);
			$('#formnombres').html(nombres);
			$('#formapellidos').html(apellidos);
			$('#formmonto').html(monto.toFixed(2)  );
			$('#subtotal').val( monto.toFixed(2) );
			$('#monto').val( monto.toFixed(2) );
			$('#myModal').modal('show');
			if( aceptacredito ){
				$('#creditooption').removeAttr('disabled');
				$('#creditooptionlabel').html('Cliente Credito');
			} else {
				$('#creditooption').attr('disabled','disabled');
				$('#creditooptionlabel').html('');
			}
			updateCupons( idcliente );
			
		}
		
		function printBill() {
			window.open( "print-orden.jsp?id="+selectedID);
		}
		
		function setDescuento( monto ){
			
			console.log( 'total descuento', $( "#cupon option:selected" ).attr('monto'));
			$( "#descuento" ).val($( "#cupon option:selected" ).attr('monto') );
			$( "#monto" ).val($( "#subtotal" ).val() - $( "#descuento" ).val() );
			
		
		}
		
		
		function updateCupons( id ){
			$.ajax({
	     		type:'GET',
	     		dataType: "text",
	 			url: './bin/CheckCupon',
	 			data: { idcliente: id },
	 			
		        success: function(msg){
		        	var dataJ = JSON.parse(msg);
		        	console.log( "dataJ", dataJ );
		        	console.log("size: " + dataJ.length );
		        	var $select = $('#cupon');
		        	
		        	$select.empty();
		        	$( "#descuento" ).val(0);
		        	$select.append('<option value="0" monto="0">Seleccione un cupon</option>');
		        	for( var n = 0; n < dataJ.length; n++ ){
		        		
		        	    $select.append('<option value="' + dataJ[n].id + '" monto="'+dataJ[n].monto+'">' + dataJ[n].descripcion + '</option>');
	
		        		console.log( "id", dataJ[n].id );
		        		console.log( "monto", dataJ[n].monto );
			        	console.log( "descripcion", dataJ[n].descripcion );
		        	}
		        	//$("#descuento").val( dataJ.monto );
		        },
	 			error: function(jqXHR, textStatus, errorThrown){
	 				console.log("ERROR srtatus: ", textStatus);
	 				console.log("ERROR errorThrown: ", errorThrown);
	 				alert("Se prudujo un error al hacer la operaciòn");	
	 			}
		            		        
	       });
		}
		
		$("#savebutton").click(function(){
			
			var form =$('#modalform');
	     	$.ajax({
	     		type:'POST',
	     		dataType: "text",
	 			url: './bin/SavePayment',
	 			data: form.serialize(),
	 			
		        success: function(msg){
		        	var messages = msg.split("|");
		        	alert( messages[1] );
		        	
		        	if( confirm("Desea imprimir la orden?") ){
		        		var win = window.open( "print-orden-plain.jsp?id="+selectedID);
		        		win.print();
		        	}
		        	if( confirm("Desea imprimir la factura?") ){
		        		window.open( "print-factura.jsp?id="+messages[ 0 ]);
		        	}
		        	location.reload();
		        	
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
       	  //$('#numero_tarjeta').val('');
       	  $('#autorizacion').val('');
       	  
       	  $('#numero_cheque').prop('readonly', true);
       	  $('#banco').prop('disabled', false);
       	  //$('#tipo_tarjeta').prop('readonly', false);
       	  $('#tipo_tarjeta').css('pointer-events','all');
       	  //$('#numero_tarjeta').prop('readonly', false);
       	  $('#autorizacion').prop('readonly', false);
       	  
       	  $('#monto').prop('readonly', true);
       	  $('#banco').focus();
       	  
         }
         
         function setEfectivio(){
       	  $('#numero_cheque').val('');
       	  $('#banco').val('');
       	  $('#tipo_tarjeta').val('');
       	  //$('#numero_tarjeta').val('');
       	  $('#autorizacion').val('');
       	  
       	  $('#numero_cheque').prop('readonly', true);
       	  $('#banco').prop('disabled', 'disabled');
       	  //$('#tipo_tarjeta').prop('readonly', true);
       	  $('#tipo_tarjeta').css('pointer-events','none'); 
       	  //$('#numero_tarjeta').prop('readonly', true);
       	  $('#autorizacion').prop('readonly', true);
       	  
       	  $('#monto').prop('readonly', true);
       	  $('#monto').focus();
       	  
         }
         
         function setCheque(){
	       	  $('#numero_cheque').val('');
	       	  $('#banco').val('');
	       	  $('#tipo_tarjeta').val('');
	       	  //$('#numero_tarjeta').val('');
	       	  $('#autorizacion').val('');
	       	  
	       	  $('#numero_cheque').prop('readonly', false);
	       	  $('#banco').prop('disabled', false);
	       	  //$('#tipo_tarjeta').prop('readonly', true);
	       	  $('#tipo_tarjeta').css('pointer-events','none');
	       	  //$('#numero_tarjeta').prop('readonly', true);
	       	  $('#autorizacion').prop('readonly', true);
	       	  
	       	  $('#monto').prop('readonly', true);
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
