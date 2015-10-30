<%@page import="com.urbau.beans.ClasificacionRubroBean"%>
<%@page import="com.urbau.feeders.ClasificacionRubrosMain"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.TipoRubroBean"%>
<%@page import="com.urbau.feeders.TiposRubrosMain"%>    
<%						
	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){

		int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
		TiposRubrosMain main = new TiposRubrosMain();		
		TipoRubroBean bean = main.get( id );		
		String mode = request.getParameter( "mode" );		
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				location.replace( "tiposrubros.jsp");
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE RUBRO</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="tiposrubros.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" method="POST" id="form" name="form">
                      	                      
                      	<input type="hidden" name="mode" value="<%= mode%>">
                      	<input type="hidden" name="id" value="<%= request.getParameter("id")%>">                      
                                                          		
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Nombre</label>
                          	<div class="col-sm-10">
                          	            
								<input type="text" class="form-control" name="descripcion" id="descripcion" value="<%= bean.getDescripcion() %>">	                          	                                                                    
                              
                          	</div>
                          	
                          	<label class="col-sm-2 col-sm-2 control-label">Tipo</label>
                          	<div class="col-sm-10">
                          	    <select class="form-control" name="tipo">
                          	    	<option value="F" <%=  "F".equals( bean.getTipo() ) ? "SELECTED":"" %>>Fijo</option>
                          	    	<option value="V" <%=  "V".equals( bean.getTipo() ) ? "SELECTED":"" %>>Variable</option>
                          	    </select>       
                          	</div>
                          	
                          	<label class="col-sm-2 col-sm-2 control-label">Clasificacion</label>
                          	<div class="col-sm-10">
                          	     <%
                          	     	ClasificacionRubrosMain crm = new ClasificacionRubrosMain();
                          	     	ArrayList<ClasificacionRubroBean> list = crm.getForCombo();
                          	     %>       
                          	     <select class="form-control"  name="clasificacion" id="clasificacion">
                          	     	<%
                          	     		for( ClasificacionRubroBean b: list) {
                          	     	%>
                          	     		<option value="<%= b.getId()  %>" <%= ( bean.getTipo_clasificacion() == b.getId() ) ? "SELECTED":"" %>><%= b.getDescription() %></option>
                          	     	<% } %>
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
		        descripcion: {
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
			$descripcion = $("#descripcion");
			
			$savebutton.click(function(){
				
				if($descripcion.val()){
					
					var form =$('#form');					
		     		$.ajax({
			     		type:'POST',
			 			url: './bin/TiposRubros',
			 			data: form.serialize(),
			 			dataType: "text",		 			
				        success: function(msg){
				        	console.log("msg:: ", msg);
				        	alert(msg);
				            location.replace( "tiposrubros.jsp" );
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
				$descripcion.attr('disabled','disabled');				
				$savebutton.removeClass("btn btn-success");
				$savebutton.addClass("btn btn-danger");
				$savebutton.html("Borrar");
				
			}else if(mode === "view"){
				$descripcion.attr('disabled','disabled');				
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