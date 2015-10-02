<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.PresupuestoBean"%>
<%@page import="com.urbau.feeders.PresupuestoMain"%>
<%@page import="com.urbau.misc.Constants"%>    
<%						
	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){

		int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
		PresupuestoMain main = new PresupuestoMain();		
		PresupuestoBean bean = main.get( id );		
		String mode = request.getParameter( "mode" );
		
		int anio = bean.getAnio();
		int mes =bean.getMes();
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				location.replace( "presupuestos.jsp");
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE PRESUPUESTO</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="presupuestos.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" method="POST" id="form" name="form">
                      	                      
                      	<input type="hidden" name="mode" value="<%= mode%>">
                      	<input type="hidden" name="id" value="<%= request.getParameter("id")%>">                      
                                                          		
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Año</label>                          	                          	
                          	<div class="col-sm-10">
								<select class="form-control" name="anio" id="anio">
									<option value=""></option>
									<option value="2010">2010</option>								  									  							  	  												  
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022">2022</option>
									<option value="2023">2023</option>
									<option value="2024">2024</option>
									<option value="2025">2025</option>
									<option value="2026">2026</option>
									<option value="2027">2027</option>
									<option value="2028">2028</option>
									<option value="2029">2029</option>
									<option value="2030">2030</option>
									<option value="2031">2031</option>
									<option value="2032">2032</option>
									<option value="2033">2033</option>
									<option value="2034">2034</option>
									<option value="2035">2035</option>
							 	</select>
						    </div>
                      	</div>
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Mes</label>
                          	<div class="col-sm-10">
								<select class="form-control" name="mes" id="mes">
									<option value=""></option>
									<option value="0">Enero</option>								  									  							  	  												  
									<option value="1">Febrero</option>
									<option value="2">Marzo</option>
									<option value="3">Abril</option>
									<option value="4">Mayo</option>
									<option value="5">Junio</option>
									<option value="6">Julio</option>
									<option value="7">Agosto</option>
									<option value="8">Septiembre</option>
									<option value="9">Octubre</option>
									<option value="10">Noviembre</option>
									<option value="11">Diciembre</option>									
							 	</select>
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
		        rolname: {
		          minlength: 3,
		          maxlength: 50,
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
			$anio = $("#anio");
			$mes = $("#mes");
			
			$savebutton.click(function(){
				
				if($anio.val() && $mes.val()){
					
					var form =$('#form');					
		     		$.ajax({
			     		type:'POST',
			 			url: './bin/Presupuestos',
			 			data: form.serialize(),
			 			dataType: "text",		 			
				        success: function(msg){
				        	console.log("msg:: ", msg);
				        	alert(msg);
				            location.replace( "presupuestos.jsp" );
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
			var anio = <%=anio%>;
			var mes = <%=mes%>;				
			$('#anio').val(anio);
			$('#mes').val(mes);
			
			if(mode === "remove"){
				$anio.attr('disabled','disabled');				
				$mes.attr('disabled','disabled');
				$savebutton.removeClass("btn btn-success");
				$savebutton.addClass("btn btn-danger");
				$savebutton.html("Borrar");
				
			}else if(mode === "view"){
				$anio.attr('disabled','disabled');				
				$mes.attr('disabled','disabled');
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