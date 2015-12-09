<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.misc.EncryptUtils"%>
<%@page import="java.util.ArrayList"%>
      
<%

ExtendedFieldsBaseMain planillaHead = new ExtendedFieldsBaseMain( "PLANILLA_HEAD", 
		new String[]{"DIA","MES","ANIO","FECHA"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER
		} );

	
      	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
      		
      	int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
      	ExtendedFieldsBean bean = planillaHead.get( id );
      	String mode = request.getParameter( "mode" );
      
      %>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
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
          
          	<h3><i class="fa fa-angle-right"></i> Detalle de planilla</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   		<h4 class="mb"><i class="fa fa-angle-left"></i><a href=adelantos.jsp">&nbsp;Regresar</a> </h4>
          			   		<form class="form-horizontal style-form" id="form" name="form">
		                  	   	<input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>"></input>
		                      	<input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>"></input>
		                      	<%= Util.getHiddenFormFrom( planillaHead ) %>
		                      	
		                      	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">D&iacute;a</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="DIA" id="DIA">
		                              				<option value="1" <%=   "1".equals( String.valueOf(  bean.getValue( "DIA" )) ) ? "SELECTED" : ""%>>1</option>
		                              				<option value="15" <%= "15".equals( String.valueOf(  bean.getValue( "DIA" )) ) ? "SELECTED" : ""%>>15</option>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="DIA" id="DIA" disabled>
		                              				<option value="1" <%=   "1".equals( String.valueOf(  bean.getValue( "DIA" )) ) ? "SELECTED" : ""%>>1</option>
		                              				<option value="15" <%= "15".equals( String.valueOf(  bean.getValue( "DIA" )) ) ? "SELECTED" : ""%>>15</option>
		                              		</select>	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                      	
		                      	
		                      		<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Mes</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="MES" id="MES" value="<%= bean.getValue( "MES" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="MES" id="MES" disabled value="<%= bean.getValue( "MES" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">A&nacute;o</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="ANIO" id="ANIO" value="<%= bean.getValue( "ANIO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="ANIO" id="ANIO" disabled value="<%= bean.getValue( "ANIO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<input type="hidden" name="FECHA" ID="FECHA" VALUE="now()">
		                          	
                          	</form>
                         </div>
                         <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('planilla.jsp')">Cancelar</button>
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
             $('#form').validate(
             {
              rules: {
                nombre: {
                  minlength: 2,
                  maxlength: 30,
                  required: true
                }
              },
              highlight: function(element) {
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
              },
              success: function(element) {
                element
                .closest('.form-group').removeClass('has-error').addClass('has-success');
              }
             });
            }); // end document.ready
            
            
            
           
        </script>
       
		<script>        	
        
        $(function() {
    		    	
    		$('#form').submit(function(e){
    			e.preventDefault();
    		});
    		
    		
    		$("#savebutton").click(function(){
    			    					
    			var form =$('#form');
    	     	$.ajax({
    	     		type:'POST',
    	 			url: './bin/ExtendedFields',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "planilla.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operacion");	
    	 			}
    		            		        
    	       });
    	     	
    	     	return false;
    	 	});
    				 
    		
    		var mode = getUrlParameter('mode');    		
    		if(mode === "remove"){
    			$("#rolSelect").attr('disabled','disabled');
    			$("#activo").attr('disabled','disabled');
    			
    			$("#savebutton").removeClass("btn btn-success");
    			$("#savebutton").addClass("btn btn-danger");
    			$("#savebutton").html("Borrar");						
    		}else if(mode === "view"){
    			$("#rolSelect").attr('disabled','disabled');
    			$("#activo").attr('disabled','disabled');
    			$("#savebutton").hide();    			    	    	
    			
    		}else if(mode === "add"){    			
    			$("#nombresapellidos").attr('value', ' ');
    			$("#clave").attr('value', '');    			
    		}
    		
    		// select option by id 
    		var idRol = $("#idRol").val();    		    		    	
    		if(idRol){
    			$("#rolSelect option[value="+idRol+"]").attr('selected','selected');    			
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