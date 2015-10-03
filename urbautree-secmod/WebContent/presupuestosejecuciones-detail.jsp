<%@page import="java.util.ArrayList"%>

<%@page import="com.urbau.feeders.PresupuestosEjecucionesMain"%>
<%@page import="com.urbau.beans.PresupuestoEjecucionBean"%>        
<%@page import="com.urbau.beans.TipoRubroBean"%>
<%@page import="com.urbau.feeders.TiposRubrosMain"%>
<%				
	String mode = request.getParameter( "mode" );
	String presupuestoParameter = request.getParameter("presupuesto");
	String anioParameter = request.getParameter("anio");
	String mesParameter = request.getParameter("mes");
	
	int idPresupuesto  = -1;
	int anio = -1;
	int mes = -1;
		
	try{
		idPresupuesto = Integer.parseInt(presupuestoParameter);
		anio = Integer.parseInt(anioParameter);
		mes = Integer.parseInt(mesParameter);
		
	}catch(NumberFormatException e){
		System.out.println("Error to parse a string to int for presupuesto parameter : message : "+ e.getMessage());
	}
	
	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" )) && idPresupuesto >= 0 ){
		
		int id = "add".equals( mode ) || "addModal".equals( mode ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
					
		TiposRubrosMain tiposRubrosMain = new TiposRubrosMain();								
	
		PresupuestosEjecucionesMain peMain = new PresupuestosEjecucionesMain();
		PresupuestoEjecucionBean peBean = peMain.get(id);
		int tipo_rubro = peBean.getTipoRublo();
		
		
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				var presupuesto = <%=idPresupuesto%>;
				location.replace( "presupuestosejecuciones.jsp?presupuesto="+presupuesto);
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
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="presupuestosejecuciones.jsp?presupuesto=<%=idPresupuesto %>">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horiz
                      
                      
                      ontal style-form" method="POST" id="form" name="form">                                            	                    
                      	<input type="hidden" name="mode" value="<%= mode%>">
						<input type="hidden" name="id" value="<%= id%>">
						<input type="hidden" name="anio" value="<%= anio%>">
						<input type="hidden" name="mes" value="<%= mes%>">
                      	<input type="hidden" name="presupuesto" value="<%= idPresupuesto%>">                      	                      	                                                                  
                              					                      	                                                          		                    
                      	<div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Rubro</label>
                              <div class="col-sm-10">
                              
                              		<select class="form-control" name="rubro" id="rubro">
	                                  <%
	                                  	ArrayList<TipoRubroBean> tiposRubrosList = tiposRubrosMain.get(null, 0);
	                                  	for( TipoRubroBean rubroBean : tiposRubrosList ){
	                                  %>
	                                  	<option value="<%= rubroBean.getId()%>"><%= rubroBean.getDescripcion() %></option>
	                                  <% } %>									  									  
									</select>                              	                                
                              </div>
                        </div>                        
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Monto</label>
                          	<div class="col-sm-10">                          	            
								<input type="number" class="form-control" name="monto" id="monto" value="<%=peBean.getMonto() %>">	                          	                                                                                                  
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
			
			$rubro = $("#rubro");			
			$monto = $("#monto");
									
			$savebutton.click(function(){					
				if($rubro.val() && $monto.val()){		
					
					var form =$('#form');					
		     		$.ajax({
			     		type:'POST',
			 			url: './bin/PresupuestosEjecuciones',
			 			data: form.serialize(),
			 			dataType: "text",		 			
				        success: function(msg){				        	
				        	alert(msg);
				        	var presupuesto = getUrlParameter('presupuesto');
				            location.replace( "presupuestosejecuciones.jsp?presupuesto="+presupuesto );
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
										
				$rubro.attr('disabled','disabled');
				$monto.attr('disabled','disabled');
				
				$savebutton.removeClass("btn btn-success");				
				$savebutton.addClass("btn btn-danger");
				$savebutton.html("Borrar");
				
			}else if(mode === "view"){
				
				$rubro.attr('disabled','disabled');
				$monto.attr('disabled','disabled');								
				$savebutton.hide();
			}else if(mode === "edit"){
				
				$("#rubro option[value="+<%=tipo_rubro%>+"]").attr('selected','selected');
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