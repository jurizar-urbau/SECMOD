<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.BancoMovimientoBean"%>
<%@page import="com.urbau.feeders.BancosMovimientosMain"%>
<%@page import="com.urbau.feeders.TiposDeMovimientosMain"%>
<%@page import="com.urbau.beans.TipoMovimientoBean"%>    
<%				
	
	String bancoParamenter = request.getParameter("banco");
	int idBanco  = -1;
	try{
		idBanco = Integer.parseInt(bancoParamenter);	
	}catch(NumberFormatException e){
		System.out.print("Error to parse a string to int for banco parameter : message : "+ e.getMessage());
	}
	
	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" )) && idBanco >= 0 ){

		int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
				
		System.out.println("ID: "+id);
		TiposDeMovimientosMain tiposMovimientosMain = new TiposDeMovimientosMain();
		BancosMovimientosMain main = new BancosMovimientosMain();		
		BancoMovimientoBean bean = main.get( id );		
			
		String mode = request.getParameter( "mode" );					
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				var banco = <%=idBanco%>;
				location.replace( "banco-tiposmovimientos.jsp?banco="+banco);
			}			
		</script>
	</head>
   
   <body>
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=159695794072494&version=v2.3";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE MOVIMIENTOS</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
        			<div class="form-panel">          			  
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="banco-tiposmovimientos.jsp?banco=<%=idBanco %>">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" method="POST" id="form" name="form">                                            	                    
                      	<input type="hidden" name="mode" value="<%= mode%>">
						<input type="hidden" name="id" value="<%= id%>">
                      	<input type="hidden" name="banco" value="<%= idBanco%>">                      	                      	                                                                  
                              
						<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Fecha</label>
                          	<div class="col-sm-10">                          	            
								<input type="date" class="form-control" name="fecha" id="fecha" value="<%= bean.getFecha()%>">	                          	                                                                                                  
                          	</div>
                      	</div>
                      	                                                          		                      		
                      	<div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tipo Movimiento</label>
                              <div class="col-sm-10">
                              
                              		<select class="form-control" name="tipomovimiento" id="tipomovimiento">
	                                  <%
	                                  	ArrayList<TipoMovimientoBean> tiposMovList = tiposMovimientosMain.get(null, 0);
	                                  	for( TipoMovimientoBean tipoMovBean : tiposMovList ){
	                                  %>
	                                  	<option value="<%= tipoMovBean.getId()%>"><%= tipoMovBean.getDescription() %></option>
	                                  <% } %>									  									  
									</select>                              	                                
                              </div>
                        </div>
                        <div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Descripcion</label>
                          	<div class="col-sm-10">                          	            
								<input type="text" class="form-control" name="descripcion" id="descripcion" value="<%=bean.getDescripcion()%>">	                          	                                                                                                  
                          	</div>
                      	</div>
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Monto</label>
                          	<div class="col-sm-10">                          	            
								<input type="number" class="form-control" name="monto" id="monto" value="<%=bean.getMonto()%>">	                          	                                                                                                  
                          	</div>
                      	</div>
                          
                                                	
                       <div class="form-actions">
       	    				<button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
			            	<button class="btn" onclick="back()">Cancelar</button>
			        	</div>                           
                      </form>                      
                  </div>
                     
          		</div>
          	</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
	<script>
	    $(document).ready(function(){
	    	
	     	$('#form').validate({
		      rules: {                        		  
		        precio: {			    
			          required: true
			    }
		      },
		      highlight: function(element) {
		    	  $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
		      },
		      success: function(element) {
		    	  $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
		      }
	     	});
	    });                                  
	</script>
	<script>
	
		$(function() {
		//twitter bootstrap script
					
			$('#form').submit(function(e){
				e.preventDefault();
			});
			
			$savebutton  = $("#savebutton");						
			$fecha = $("#fecha");
			$tipomovimiento = $("#tipomovimiento");
			$descripcion = $("#descripcion");
			$monto = $("#monto");
									
			$savebutton.click(function(){					
				if($tipomovimiento.val() && $fecha.val()){		
					
					var form =$('#form');					
		     		$.ajax({
			     		type:'POST',
			 			url: './bin/TiposDeMovimientosBanco',
			 			data: form.serialize(),
			 			dataType: "text",		 			
				        success: function(msg){				        	
				        	alert(msg);
				        	var banco = getUrlParameter('banco');
				            location.replace( "banco-tiposmovimientos.jsp?banco="+banco );
				        },
			 			error: function(jqXHR, textStatus, errorThrown){
			 				console.log("ERROR srtatus: ", textStatus);
			 				console.log("ERROR errorThrown: ", errorThrown);
			 				alert("Se prudujo un error al hacer la operaciòn");	
			 			}
		       		});
						
				}						
	     		return false;
	 		});
				 
		
			var mode = getUrlParameter('mode');		
			if(mode === "remove"){
				$fecha.attr('disabled','disabled');		
				$tipomovimiento.attr('disabled','disabled');
				$descripcion.attr('disabled','disabled');
				$monto.attr('disabled','disabled');
				
				$savebutton.removeClass("btn btn-success");				
				$savebutton.addClass("btn btn-danger");
				$savebutton.html("Borrar");
				
			}else if(mode === "view"){				
				$fecha.attr('disabled','disabled');		
				$tipomovimiento.attr('disabled','disabled');
				$descripcion.attr('disabled','disabled');
				$monto.attr('disabled','disabled');
								
				$savebutton.hide();
			}			
										
    		
		});
		 
		 
		function getUrlParameter(sParam){
			
		    var sPageURL = window.location.search.substring(1);
		    var sURLVariables = sPageURL.split('&');
		    
		    for (var i = 0; i < sURLVariables.length; i++) {
				var sParameterName = sURLVariables[i].split('=');
		        if (sParameterName[0] == sParam) {
					return sParameterName[1];
		        }
		    }
		} 
		 
	</script>
        
  </body>
</html>
<% 		
} else {
%>
		<p>No se especifico un id.</p>
<%
 } 
%>