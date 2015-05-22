<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.ProgramBean"%>
<%@page import="com.urbau.feeders.ProgramsMain"%>
      
<%
	
System.out.println(">>>>>PROGRAMS DETAIL STARTED >>>>>>");
	
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){			
			ProgramsMain programsMain = new ProgramsMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
System.out.println("id>> " + id);		
			
ProgramBean bean = programsMain.getProgram(id);
							
			String mode = request.getParameter( "mode" );
System.out.println("mode>> " + mode);			
			
					
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function back(){
				location.replace( "programs.jsp");
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE OPCION</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="programs.jsp">&nbsp;Regresar</a> </h4>
                  	  
                      <form class="form-horizontal style-form" id="form" name="form">
                      	                      
                      	<input type="hidden" name="mode" value="<%= request.getParameter("mode")%>">
                      	<input type="hidden" name="id" value="<%= request.getParameter("id")%>">                      
                                                          		
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Nombre</label>
                          	<div class="col-sm-10">
                 	            <%
	                          	if( "edit".equals( mode ) || "add".equals( mode ) ){
	                          	%>
	                          		<input type="text" class="form-control" name="programdesc" id="programdesc" value="<%= bean.getDescription() %>">	                          	                          	                          		
	                          	<%
	                          	}else{
	                          	%>
	                          		<input type="text" class="form-control" name="programdesc" id="programdesc" disabled value="<%= bean.getDescription() %>">	                          		
	                          	<%
	                          	}                          	
	                          	%>                              
                          	</div>
                      	</div>
                      	
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Programa</label>
                          	<div class="col-sm-10">
                 	            <%
	                          	if( "edit".equals( mode ) || "add".equals( mode ) ){
	                          	%>	                          		                          	                         
	                          		<input type="text" class="form-control" name="programname" id="programname" value="<%= bean.getProgram_name() %>">
	                          	<%
	                          	}else{
	                          	%>	                          		
	                          		<input type="text" class="form-control" name="programname" id="programname" disabled value="<%= bean.getProgram_name() %>">
	                          	<%
	                          	}                          	
	                          	%>                              
                          	</div>
                      	</div>
                          
                       <div class="form-actions">
       	    				<button type="submit" class="btn btn-success" id="savebuttonprograms">Guardar</button> 
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
              		programdesc: {
                  		minlength: 3,
                  		maxlength: 50,
                  		required: true
                	},
                	programname: {
                  		minlength: 3,
                  		maxlength: 50,
                  		required: true
                	}
             	},
             	
              	highlight: function(element) {
                	$(element).closest('.form-group').removeClass('has-success').addClass('has-error');
              	},
              	success: function(element) {
                element.closest('.form-group').removeClass('has-error').addClass('has-success');
              }
             });
        }); // end document.ready 
            
	</script>
	<script>        	
        
        $(function() {
    		    	
    		$('#form').submit(function(e){
    			e.preventDefault();
    		});
    		
    		
    		$("#savebuttonprograms").click(function(){
    			    					
    			var form =$('#form');
    	     	$.ajax({
    	     		type:'POST',
    	 			url: './bin/Programs',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "programs.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operaciòn");	
    	 			}
    		            		        
    	       });
    	     	
    	     	return false;
    	 	});
    				 
    		
    		var mode = getUrlParameter('mode');    		
    		if(mode === "remove"){
    			$("#savebuttonprograms").removeClass("btn btn-success");
    			$("#savebuttonprograms").addClass("btn btn-danger");
    			$("#savebuttonprograms").html("Borrar");						
    		}else if(mode === "view"){
    			$("#savebuttonprograms").hide();
    		}
    		
    		
   		}); // end function 
    		 
    		 
		function getUrlParameter(sParam){
   			
		    var sPageURL = window.location.search.substring(1);
		    var sURLVariables = sPageURL.split('&');
		    
		    for (var i = 0; i < sURLVariables.length; i++) {
		    	
		        var sParameterName = sURLVariables[i].split('=');
		        if (sParameterName[0] == sParam) {
		             return sParameterName[1];
		        }
		    }
	    } // end getUrlParameter 
        
            
           
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