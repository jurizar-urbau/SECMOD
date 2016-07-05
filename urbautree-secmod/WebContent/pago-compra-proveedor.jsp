<%@page import="com.urbau.beans.ProveedorBean"%>
<%@page import="com.urbau.feeders.ProveedoresMain"%>
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
	<script>
		function searchClients( q ){
			$( "#client-container" ).html("");
			 $.get( "./bin/searchc?q=" + q, null, function(response){
	             $.each(response, function(i, v) {
	            	 var rootele;
	            	 var htmltoadd =
	            		"<tr>" +
	             	  	"<td><input type='radio' name='clienteid' value='" + v.id + "," + v.nombres + " " + v.apellidos + "'></td>" +
	                 	"<td>"+v.nit+"</td>" +                                  
	                 	"<td>"+v.nombres+"</td>" +
	                 	"<td>"+v.apellidos+"</td>" +         
	                 	"</tr>";
	     			$( "#client-container" ).append( htmltoadd );
	            	
	            	 
	             });
	          });
		}
	</script>
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
          			     <h3>Pago de compra a proveedor</h3>
          			     <hr>
          			    	<form class="form-horizontal style-form" id="form" name="form" action="pago-compra-proveedor-monto.jsp" method="POST">
		                  	   	  	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Proveedor</label> 
		                              	<div class="col-sm-10">
			                          		<input type="text" class="form-control" name="proveedordisplay" id="proveedordisplay"  onclick="chooseProveedor()" readonly>
			                          		<input type="hidden" name="proveedorid" id="proveedorid" value="">	                          	                          
		                              	</div>
		                          	</div>
                          	</form>
                         </div>
                         <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="next">Siguiente</button> 
					     </div>                                                                                                      
                  </div>
          		</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->
      <!-- proveedores modal starts -->
      <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myProveedores" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione un proveedor...</h4>
			                      </div>
			                      <div class="modal-body">
				                      <%
				                      		ProveedoresMain proveedoresMain = new ProveedoresMain();
				                      		ArrayList<ProveedorBean> listProveedores = proveedoresMain.get( null, -1 );
										%>
										 <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	  <thead>
                              <tr>
                              	<th></th>
                              	<th>Id</th>
                                  <th>Nombre</th>                                                                                                      
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              int proveedorCount = 0;
                              	for(ProveedorBean bean: listProveedores ){
                              %>
                              <tr>
                              	  <td>
                              	  	<input type="radio" name="proveedorid" value="<%= bean.getId() %>,<%= bean.getNombre()  %>" <%= proveedorCount == 0 ? "checked" : "" %>>
                              	  </td>
                                  <td>
                                  	<%= bean.getId() %>
								  </td>
								  <td>
								  	<%= bean.getNombre() %>
								 </td>                                  
                                                                            
                                  
                              </tr>
                              <% 
                              proveedorCount++;
                              	} %>
                              
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setProveedor();">Seleccionar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>
      
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
<script>
	function setProveedor(){
		var value = $('input[name=proveedorid]:checked').val();
		var values = value.split(',');
		console.log('proveedor', values[0]);
		selected_proveedor_id = values[0];
		$('#proveedordisplay').val(value);
		$('#proveedorid').val( selected_proveedor_id );
		hideProveedor();
	}
	
	function chooseProveedor(){
		$('#myProveedores').modal('show');
	}
	
	function hideProveedor(){
		$('#myProveedores').modal('hide');
	}
	

		$(window).load(function(){
			
		    $( "#search-client" ).keyup(function() {
		    	var value = $( "#search-client" ).val();
		    	searchClients( value );
			});
		    
		});

		$(function() {
    		    	
    		$("#next").click(function(){
    			var form =$('#form');
    			form.submit();
    	     	return false;
    	 	});
    	
    		
    		
   		}); // end function 
    
           
	</script>
        
  </body>
</html>
