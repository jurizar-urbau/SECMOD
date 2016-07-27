
<%@page import="com.urbau.misc.RevertionsUtil"%>
<%@page import="com.urbau.beans.BodegaUsuarioBean"%>
<%@page import="com.urbau.feeders.BodegasUsuariosMain"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
      
  

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
      		<%	
			BodegasMain main = new BodegasMain();
			ArrayList<String[]> listOfBodegas = main.getCombo( "BODEGAS", "ID", "NOMBRE");
			
			BodegasUsuariosMain mainBodegas = new BodegasUsuariosMain();
			ArrayList<BodegaUsuarioBean>  listOfBodegasUsuarios = mainBodegas.getFromUser( loggedUser.getId() );
				
			
			
			
%>       
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
          			    <h3>REVERTIR CARGA</h3><br/>
          			    
          			    
          			    
          			  <form class="form-horizontal style-form" id="form" name="form" method="POST">
                      
                      <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Correlativo de carga</label>
                              <div class="col-sm-10">
									<input type="text" class="form-control" name="correlativo" id="correlativo"/>	                          	                          
                              </div>
                      </div>  
                          
                      
                      <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Bodega</label>
                              <div class="col-sm-10">
	                              	<select  class="form-control"  name="bodega" id="bodega">
	                              	<%
	                              		for( BodegaUsuarioBean list : listOfBodegasUsuarios ){
	                              			BodegaBean bod = main.getBodega( list.getIdBodega() );
	                              	%>
	                              		<option value="<%= bod.getId() %>"><%= bod.getNombre() %></option>
	                              	<% 
	                              		}
	                              	%>
	                              	</select>
		                      </div>
		                      
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Codigo de producto</label>
                              <div class="col-sm-10">
									<input type="text" class="form-control" name="codigo_producto" id="codigo_producto"/>	                          	                          
                              </div>
                      </div>  
                       <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Cantidad a revertir</label>
                              <div class="col-sm-10">
									<input type="text" class="form-control" name="cantidad" id="cantidad"/>	                          	                          
                              </div>
                      </div> 
                           <div class="form-actions">
                           	    <button class="btn btn-success" onclick="enviar()">Revertir carga</button> 
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
        <script type="text/javascript">
        	function enviar(){
        		var form =$('#form');
    	     	$.ajax({
    	     		type:'POST',
    	     		dataType: "text",
    	 			url: './bin/RevertLoad',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){
    		        	console.log( msg );
    		        	if( msg.length > 0 ){
	    		        	msgJson = JSON.parse(msg);
	    		        	console.log( msgJson );
	    		        	if( msgJson.found ){
	    		        		alert( msgJson.message );
	    		        		location.reload();
	    		        	} else {
	    		        		alert( msgJson.message );
	    		        		return false;
	    		        	}
    		        	} else {
    		        		alert("Datos incorrectos");
    		        	}
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operaciòn");	
    	 			}
    		            		        
    	       });
				}
        </script>
  </body>
</html>
