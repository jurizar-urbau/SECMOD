<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.feeders.ProgramsMain"%>
<%@page import="com.urbau.feeders.OptionsMain"%>
<%@page import="com.urbau.beans.RolBean"%>
<%@page import="com.urbau.beans.ProgramBean"%>
<%@page import="com.urbau.beans.OptionBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.security.Authorization"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<%@include file="fragment/head.jsp"%>
		<%			
			RolesMain roles_main = new RolesMain();
 			ProgramsMain programs_main = new ProgramsMain();
			OptionsMain options_main = new OptionsMain();			
			boolean isAuthorizedToDelete = Authorization.isAuthorizedOption(loggedUser.getRol(), Constants.NAME_OPTIONS_BY_PROGRAM, Constants.OPTIONS_DELETE);					
		%>										
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
          	<h3><i class="fa fa-angle-right"></i>SEGURIDAD</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			<div class="content-panel">
          				
          			    <table class="table table-striped table-advance table-hover" id="optionsprogramtable">
	                  	  	  <h4><i class="fa fa-angle-right"></i> OPCIONES POR PROGRAMA</h4>
	                  	  	  <hr>
	                  	  	  							  	                                                                    
							  <div class="form-group">
							  	<label class="col-sm-2 col-sm-2 control-label">Rol</label>
							    								      
							    <div class="col-sm-10">
									<select class="form-control" name="rolSelect" id="rolSelect">
									<option value=""></option>
									  <%
									  	ArrayList<RolBean> roles_list = roles_main.get(null, 0);
									  	for( RolBean rol : roles_list ){
									  %>
								  		<option value="<%= rol.getId()%>"><%= rol.getDescription() %></option>
								  	  <% } %>									  
								  	  
													  
								 	</select>
							    </div>
							  </div><br><br>
								  
                                                  	                  	  	  
                              <thead>
	                              <tr>
	                              	  <th>Programa</th>
	                                  <th>Opci&oacute;n</th>
	                                  <th></th>
	                              </tr>
                              </thead>
                              <tbody id="optionsprogramtbody">
                              	
                              	<tr>
                              	                              
	                        		<form class="form-horizontal style-form" id="form" name="form">
	                        		
	                        			<input type="hidden" name="mode" id="mode"value="">										
										<input type="hidden" name="idRol" id="idRol" value="">
										
										<td>
											<div class="form-group">																		    								    
											    <div class="col-sm-10">
													<select class="form-control" name="idProgram" id="idProgram">
														<option value=""> </option>
													  <%
													  	ArrayList<ProgramBean> programs_list = programs_main.getForCombo();
													  	for( ProgramBean program : programs_list ){
													  %>
												  		<option value="<%= program.getId()%>"><%= program.getDescription() %></option>
												  	  <% } %>									  												  	  																	
												 	</select>
											    </div>
											</div>
										</td>
										
										<td>
											<div class="form-group">																		    								    
											    <div class="col-sm-10">
													<select class="form-control" name="idOption" id="idOption">
														<option value=""> </option>
													  <%
													  	ArrayList<OptionBean> options_list = options_main.get(null, 0);
													  	for( OptionBean option: options_list ){
													  %>
												  		<option value="<%= option.getId()%>"><%= option.getDescription() %></option>
												  	  <% } %>									  												  	  																	
												 	</select>
											    </div>
											</div>
										</td>
										
										<td>
										<% if(Authorization.isAuthorizedOption(loggedUser.getRol(), Constants.NAME_OPTIONS_BY_PROGRAM, Constants.OPTIONS_ADD)){ %>
		                            		<div class="form-actions">
												<button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 											
											</div>                                    	
										<%}%>	
                                		</td>	
										
	                        		</form>
                        		</tr>
                        		      
	                                                        
                              </tbody>
                                                            
						  		                              
                          </table>
                          
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
        
        $(function() {
            	
    		$tbody = $('#optionsprogramtbody');
    		
    		// hide tbody when not exits rol selected
    		$tbody.hide();  					  
    		     		 
    		// populate programs and options by the rol selected by the user
    		$rolSelect = $("#rolSelect");    		
    		$rolSelect.click(function(){
    			    		
    			var rol = $rolSelect.val();    			
    			document.getElementById("idRol").value = rol;
    			document.getElementById("mode").value = "add";
    			    			
    			if(rol){    				
    				$tbody.show();										    				
    				getOptionsByProgramsList(rol);
    			}else{
    				$tbody.hide();
    			}    			
    	     	
    	     	return false;
    		});
    		
    		
    		
    		$('#form').submit(function(e){
    			e.preventDefault();
    		});
    		    	
    		
    		$("#savebutton").click(function(){
    			    					
    			var form =$('#form');    			    			    			
    			var idRol = $("#idRol").val();
    			var mode = $("#mode").val();    			
    			var idProgram = $("#idProgram").val();
    			var idOption = $("#idOption").val();
    			    			    	
    			if(idProgram && idOption){
    				$.ajax({
        	     		type:'POST',
        	 			url: './bin/OptionsByPrograms',
        	 			data: form.serialize(),
        	 			dataType: "text",
        		        success: function(msg){		        	
        		        	alert(msg);
        		            location.replace( "optionsprogram.jsp?rol="+idRol+"&mode="+mode );
        		        },
        	 			error: function(jqXHR, textStatus, errorThrown){
        	 				console.log("ERROR srtatus: ", textStatus);
        	 				console.log("ERROR errorThrown: ", errorThrown);
        	 				alert("Se prudujo un error al hacer la operacion");	
        	 			}
        		            		        
        	       });	
    			}
    			
    	     	return false;
    	 	});
    		    		
    		    	    	
    		    		
    		var rolParameter = getUrlParameter('rol');    		    		
    		    				
    		if(rolParameter){    	
    			document.getElementById("idRol").value = rolParameter;    			
    			document.getElementById("mode").value = "add";	
    			    			    			    			    			    	
				if(rolParameter){    			
    				$tbody.show();
    				$("#rolSelect option[value='"+rolParameter+"']").attr('selected','selected');
    				getOptionsByProgramsList(rolParameter);    				
    			}else{
    				$tbody.hide();
    			}    			    	
    		}    		
    		    		    		    		    		    		
   		}); // end function 
    		 
    		 		
            
	    function getOptionsByProgramsList(idRol){
	    	if(null != idRol){
	    	
	    		$.ajax({
					url: './bin/OptionsByProgramsList',
		     		type:'POST',    	 			
		 		    data: { idRol: idRol},        	 			
			        success: function(data, textStatus, jqXHR){		        	
			        	 		        
			        	$('#optionsprogramtbody > tr:gt(0)').remove();
			        	
			        	var trHTML="";
			        	
			        	if(data instanceof Array){
			        		
			        		var isAuthorizedToDelete = <%=isAuthorizedToDelete%>;
			        		
			        		for(var i=0; i<data.length; i++){
			        			
			        			trHTML += '<tr>';
			        			trHTML += '<td>'+data[i].programDescription+'</td><td>'+data[i].optionDescription+'</td>';
			        			trHTML += '<td>';
			        			
			        			if(isAuthorizedToDelete){
			        					trHTML += '<div class="form-actions"><button type="submit" class="btn btn-danger" onClick="removeItem('+data[i].id+')"  idRol="'+data[i].idRol+'" >&nbsp;Borrar&nbsp;</button></div>';	
			        			}
			        			
			        			trHTML += '</td></tr>';
			        			                                 	                    		                    	
			        		}
			        	}
			            
			        	$('#optionsprogramtable').append(trHTML);
			        },
		 			error: function(jqXHR, textStatus, errorThrown){
		 				console.log("ERROR srtatus: ", textStatus);
		 				console.log("ERROR errorThrown: ", errorThrown);
		 				alert("Se prudujo un error al hacer la operacion");	
		 			}
			            		        
		       });
	    	}	    		    	
	    }// end getOptionsByProgramsList 
	    
	    
	    function removeItem(id){	    	
			var idRol = $(".btn-danger").attr("idRol");
								
			if(id){    			
				$.ajax({
    	     		type:'POST',
    	 			url: './bin/OptionsByPrograms',    	 			
    	 			data: { id: id, "mode": "remove"},
    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "optionsprogram.jsp?rol="+idRol);
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operacion");	
    	 			}
    		            		        
    	       });	
			}
				    
	     	return false;

	    }// end removeItem 
           
	    
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

