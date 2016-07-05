<%@page import="com.urbau.feeders.BancosMain"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.misc.EncryptUtils"%>
<%@page import="java.util.ArrayList"%>
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
	
	%>
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
          	<div class="row mt">
          		<div class="col-lg-12">
          			    <div class="form-panel">
          			     <h3>Pago de cr&eacute;dito a cliente</h3>
          			     <hr>
          			    	<form class="form-horizontal style-form" id="form" name="form" >
		                  	   	  	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Cliente</label> 
		                              	<div class="col-sm-10">
			                          		<input type="text" class="form-control" name="ID_CLIENTE_DISPLAY" id="ID_CLIENTE_DISPLAY"  value="<%= request.getParameter("ID_CLIENTE_DISPLAY")  %>" readonly>
			                          		<input type="hidden" name="ID_CLIENTE" id="ID_CLIENTE" value="<%= request.getParameter( "ID_CLIENTE" )  %>">	                          	                          
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Saldo</label> 
		                              	<div class="col-sm-10">
			                          		<input type="text" class="form-control" name="SALDO" id="SALDO"  value="<%= Util.getTotalClientCredits( request.getParameter( "ID_CLIENTE" )  ) - Util.getTotalClientPayments( request.getParameter( "ID_CLIENTE" )  )  %>" readonly>
		                              	</div>
		                          	</div>
		                          	<!-- div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Monto a abonar</label> 
		                              	<div class="col-sm-10">
			                          		<input type="text" class="form-control" name="MONTO" id="MONTO"  value="0">
		                              	</div>
		                          	</div-->
		                          		<!--  div class="form-group">                      	
				                          	<label class="col-sm-2 col-sm-2 control-label">Factura</label>
				                          	<div class="col-sm-4">
				                          		<input class="form-control" id="factura" name="factura">
				                          	</div>
				                      	</div-->
			                      	  
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
                         <div class="form-actions">
                         		<button type="submit" class="btn btn-error" id="back">Anterior</button>
                           	    <button type="submit" class="btn btn-success" id="next">Siguiente</button> 
					     </div>                                                                                                      
                  </div>
          		</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->
      
      
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
	<script>
		$(function() {
    		$("#next").click(function(){
    			var form =$('#form');
	     		$.ajax({
		     		type:'POST',
		 			url: './bin/PayClientCredit',
		 			data: form.serialize(),
		 			dataType: "text",		 			
			        success: function(msg){				        	
			        	alert(msg);
			        	location.replace( "pago-credito-cliente.jsp");
			        },
		 			error: function(jqXHR, textStatus, errorThrown){
		 				console.log("ERROR srtatus: ", textStatus);
		 				console.log("ERROR errorThrown: ", errorThrown);
		 				alert("Se prudujo un error al hacer la operaciòn");	
		 			}
	       		});
    	     	return false;
    	 	});
    		$("#back").click(function(){
    			location.replace( "pago-credito-cliente.jsp");
    	     	return false;
    	 	});
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
