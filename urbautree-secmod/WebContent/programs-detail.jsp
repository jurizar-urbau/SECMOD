<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.ProgramBean"%>
<%@page import="com.urbau.feeders.ProgramsMain"%>
<%
if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){

	int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
	ProgramsMain programsMain = new ProgramsMain();		
	ProgramBean bean = programsMain.get(id);		
	String mode = request.getParameter( "mode" );	
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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE PROGRAMA</h3>
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
                          		<input type="text" class="form-control" name="programdesc" id="programdesc" value="<%= bean.getDescription() %>">                          	                 	                                         
                          	</div>
                      	</div>
                      	
                      	<div class="form-group">                      	
                          	<label class="col-sm-2 col-sm-2 control-label">Programa</label>
                          	<div class="col-sm-10">
                          	
                          		<select class="form-control" name="programname" id="programname">                          																 
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
              		programdesc: {
                  		minlength: 3,
                  		maxlength: 50,
                  		required: true
                	},
                	programname: {                  		
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
        }); // end document.ready 
            
	</script>
	<script>        	
        
        $(function() {
    		    	
    		$('#form').submit(function(e){
    			e.preventDefault();
    		});
    		    		
    		$savebutton  = $("#savebutton");
    		$programdesc = $("#programdesc");
    		$programname =$("#programname");
    		
    		var programName = "<%=bean.getProgram_name() %>";    		
    		
    		$.ajax({
				url: './bin/FeedersList',
	     		type:'POST',    	 			
	 		    data: { packageName: 'com.urbau.feeders'},        	 			
		        success: function(data, textStatus, jqXHR){		        			        	 		        		        			        	
		        	
		        	if(data instanceof Array){
		        		for(var i=0; i < data.length; i++){
		        			
		        			if(data[i].name){
		        				if(programName === data[i].name){
		        					$programname.append($("<option />").val(data[i].name).text(data[i].name).attr('selected',true));	
		        				}else{
		        					$programname.append($("<option />").val(data[i].name).text(data[i].name));
		        				}
			        				
		        			}
		        					        	                                    	                    		                    	
		        		}
		        	}
		            		        	
		        },
	 			error: function(jqXHR, textStatus, errorThrown){
	 				console.log("ERROR srtatus: ", textStatus);
	 				console.log("ERROR errorThrown: ", errorThrown);
	 				alert("Se prudujo un error al hacer la operacion");	
	 			}
		            		        
	       });
    		
    		    		    		    		   
    		
    		
    		$savebutton.click(function(){
    			        			    		
    			if($programdesc.val() && $programname.val()){
    				
    				var form =$('#form');
    				
    				$.ajax({
        	     		type:'POST',
        	 			url: './bin/Programs',
        	 			data: form.serialize(),
        	 			dataType: "text",
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
    			}
    	     	    	     	
    	     	return false;
    	 	});
    				 
    		
    		var mode = getUrlParameter('mode');  
    		    		    		
    		if(mode === "remove"){    			    	    		
    			$programdesc.attr('disabled','disabled');
    			$programname.attr('disabled','disabled');
    			
    			$savebutton.removeClass("btn btn-success");
    			$savebutton.addClass("btn btn-danger");
    			$savebutton.html("Borrar");			
    			
    		}else if(mode === "view"){    			    	    			
    			$programdesc.attr('disabled','disabled');
    			$programname.attr('disabled','disabled');
    			
    			$savebutton.hide();
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