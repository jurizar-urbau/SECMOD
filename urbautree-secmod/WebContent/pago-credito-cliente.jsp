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
          			     <h3>Pago de cr&eacute;dito a cliente</h3>
          			     <hr>
          			    	<form class="form-horizontal style-form" id="form" name="form" action="pago-credito-cliente-monto.jsp" method="POST">
		                  	   	  	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Cliente</label> 
		                              	<div class="col-sm-10">
			                          		<input type="text" class="form-control" name="ID_CLIENTE_DISPLAY" id="ID_CLIENTE_DISPLAY"  onclick="chooseClient()" readonly>
			                          		<input type="hidden" name="ID_CLIENTE" id="ID_CLIENTE" value="">	                          	                          
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
      
       <!-- clients modal -->
      	 
					<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
						<form id="modalform" name="modalform" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Seleccione un cliente...</h4>
			                          <label>Buscar: <input type="text" class="form-control" id="search-client" name="q"></label> 
			                      </div>
			                      <div class="modal-body">
				                      
						 <table class="table table-striped table-advance table-hover">
	                  	  	  
	                  	  	  <thead>
                              <tr>
                                  <th></th>
                                  <th>Nit</th>                                  
                                  <th>Nombres</th>
                                  <th>Apellidos</th>                                                                    
                              </tr>
                              </thead>
                              <tbody id="client-container">
                              </tbody>
                          </table>
			                      </div>
			                      <div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" onclick="setClient();">Seleccionar</button>
			                      </div>
			                  </div>
			              </div>
		              </form>
		          </div>

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
<script>

function setClient(){
	var value = $('input[name=clienteid]:checked').val();
	var values = value.split(',');
	selected_client_id = values[0];
	$('#ID_CLIENTE').val( selected_client_id );
	$('#ID_CLIENTE_DISPLAY').val( value );
	$('#clientid').val( selected_client_id );
	hideClient();
}
function hideClient(){
		$('#myModal').modal('hide');
	}
function chooseClient(){
		
		$('#myModal').modal('show');
		$('#search-client').focus();
		
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
