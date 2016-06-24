<%@page import="com.urbau.threads.PlanillaGenerator"%>
<%@page import="com.urbau.beans.KeyValue"%>
<%@page import="com.urbau.beans.TwoFieldsBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<%
	
	/* PlanillaGenerator pg = new PlanillaGenerator();
	pg.setPeriod( 15, 12, 2015 );
	pg.setIdPlanilla( 1 );
	 pg.processGeneration();
	 */
	
	ExtendedFieldsBaseMain empleadosMain = new ExtendedFieldsBaseMain( "EMPLEADOS", 
			new String[]{"NOMBRES","APELLIDOS"},
				new int[]{ 
				Constants.EXTENDED_TYPE_STRING, 
				Constants.EXTENDED_TYPE_STRING
			} );
			
	ExtendedFieldsBaseMain planilladetail = new ExtendedFieldsBaseMain( "PLANILLA_DETAIL", 
			new String[]{
				"ID_PLANILLA","ID_EMPLEADO","CLASIFICACION","DEPARTAMENTO","FORMA_DE_PAGO","CUENTA",
				"BANCO","DIAS_LABORADOS","FECHA_INGRESO","SUELDO_BASE","POR_DIA","SUELDO_DEVENGADO",
				"BONIFICACION","INCENTIVO","TOTAL_INGRESOS","IGSS","ANTICIPO_SUELDO","PRESTAMO",
				"TOTAL_DEDUCCIONES","LIQUIDO"},
				new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER, 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE

	} );
	
	
	
			int from = 0;
			if( request.getParameter( "from" ) != null ){
		from = Integer.parseInt( request.getParameter( "from" ) );
			}
			KeyValue[] kv = new KeyValue[1];
			kv[0] =  new KeyValue();
			kv[0].setKey( "ID_PLANILLA" );
			kv[0].setValue( request.getParameter( "pid" ) );
			
			ArrayList<ExtendedFieldsBean> list = planilladetail.getSubdetail( request.getParameter("q"), from, kv);
			int total_regs = -1;
			
			if( list.size() > 0 ){
				total_regs = ((ExtendedFieldsBean)list.get( 0 )).getTotal_regs();
			}
	%>
	<script>
		function edit( id ){
			location.replace( "planilla-detail.jsp?mode=edit&id="+id);
		}
		function removereg( id ){
			location.replace( "planilla-detail.jsp?mode=remove&id="+id);
		}
		function view( id ){
			location.replace( "planilla-detail.jsp?mode=view&id="+id);
		} 
		function add(){
			location.replace( "planilla-detail.jsp?mode=add" );
		}
		function generate(planillaid,periodo,mes,anio){
			if(confirm( "Confirma generar la planilla?" )){
				 $('#generateModal').modal('show');
				 
	    	     	$.ajax({
	    	     		type:'GET',
	    	 			url: './bin/generateplanilla',
	    	 			data: { ID_PLANILLA: planillaid, PERIODO : periodo, MES : mes, ANIO : anio} ,
	    	 			
	    		        success: function(msg){		        	
	    		        	$('#generateModal').modal('hide');
	    		            location.reload();
	    		        },
	    	 			error: function(jqXHR, textStatus, errorThrown){
	    	 				console.log("ERROR srtatus: ", textStatus);
	    	 				console.log("ERROR errorThrown: ", errorThrown);
	    	 				alert("Se prudujo un error al hacer la operacion");	
	    	 			}
	    		            		        
	    	       });
			}
			
		}
		
	</script>
	<style>
	#scroll {
			width:200%;
			margin:100px auto;
			overflow:auto;
			
		}
	</style>
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
      <aside class="no-print">
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
          <br/>
          <div class="col-lg-6"> 
           
          </div>
          <div class="col-lg-6 no-print">
          		<form>
	          		<div class="top-menu">
			              <ul class="nav pull-right top-menu">
			              		<li><input type="text" class="form-control" id="search-query-3" name="q" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
			                    <li><button class="btn btn-primary">Buscar</button></li>
			              </ul>
		            </div>
			    </form>
			  </div>
			  <br/>
			  
          	
          	<div class="row mt">
          		<div class="col-lg-12">
          		<div class="content-panel">
          		<h4 class="mb no-print"><i class="fa fa-angle-left no-print"></i><a href="planilla.jsp">&nbsp;Regresar</a> </h4>
          				  <span class="pull-right no-print">
          				  <button type="button" class="btn btn-success" onclick="generate('<%= request.getParameter("pid") %>','<%= request.getParameter("periodo") %>','<%= request.getParameter("mes") %>','<%= request.getParameter("anio") %>');">Generar</button>&nbsp;&nbsp;&nbsp;
          				  
          				  </span>
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> Planilla <%= request.getParameter("periodo") %>/<%= request.getParameter("mes") %>/<%= request.getParameter("anio") %> </h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                              	  <th>Empleado</th>
                                  <th>Forma pago</th>
                                  <th>D&iacute;as</th>
                                  <th>Sueldo devengado</th>
                                  <th>Bonificacion</th>
                                  <th>Incentivo</th>
                                  <th>Total</th>
                                  <th>IGSS</th>
                                  <th>Anticipo</th>
                                  <th>Prestamo/Cr&eacute;dito</th>
                                  <th>Deducciones</th>
                                  <th>L&iacute;quido</th>
                                  
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              		ExtendedFieldsBean empleado = empleadosMain.get( Integer.valueOf( us.getValue( "ID_EMPLEADO" )));
                              %>
                              <tr>
								  
								  <td title="<%= us.getValue( "CLASIFICACION" ) %>/<%= us.getValue( "DEPARTAMENTO" ) %>">
								  		<%= empleado.getValue( "APELLIDOS" ) %>, <%= empleado.getValue( "NOMBRES" ) %>
								  </td>
								  <td title="<%= us.getValue( "BANCO" ) %>:<%= us.getValue( "CUENTA") %>"><%= us.getValue( "FORMA_DE_PAGO" ) %></td>
								  <td><%= us.getValue( "DIAS_LABORADOS" ) %></td>
								  <td><%= us.getValue( "SUELDO_DEVENGADO" ) %></td>
								  <td><%= us.getValue( "BONIFICACION" ) %></td>
								  <td><%= us.getValue( "INCENTIVO" ) %></td>
								  <td><%= us.getValue( "TOTAL_INGRESOS" ) %></td>
								  <td><%= us.getValue( "IGSS" ) %></td>
								  <td><%= us.getValue( "ANTICIPO_SUELDO" ) %></td>
								  <td><%= us.getValue( "PRESTAMO" ) %></td>
								  <td><%= us.getValue( "TOTAL_DEDUCCIONES" ) %></td>
								  <td><%= us.getValue( "LIQUIDO" ) %></td>
                                  
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
                         
                      </div>
                      <%
			int init = from + 1;
			
			int end  = (from + Constants.ITEMS_PER_PAGE  ) >= total_regs ? total_regs : (from + Constants.ITEMS_PER_PAGE  );
			
			boolean backButton = true;
			boolean forwardButton = true;
			if( from <= 0 ){ 
				backButton = false;
			}
			if( end >= total_regs ){
				forwardButton = false;
			}
		%>
		              <nav class="no-print">
					  <ul class="pager">
					  <% if( backButton ) {%>
					  <li class="previous">
					    		<a href="planilla.jsp?q=<%= request.getParameter("q") %>&from=<%= from - Constants.ITEMS_PER_PAGE  %>">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } else { %>
					  <li class="previous disabled">
					    		<a href="javascript: return null">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } %>
					    <% if( forwardButton ){  %>
					    <li class="next">
					    	<a href="planilla.jsp?q=<%= request.getParameter("q") %>&from=<%= end  %>">
					    		Siguiente <span aria-hidden="true">&rarr;</span></a></li>
					    <% } else { %>
					    <li class="next disabled">
					    	<a href="javascript: return null">
					    		Siguiente <span aria-hidden="true">&rarr;</span></a></li>
					    <% } %>
					    
					  </ul>
					</nav>
          		</div>
          	</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->



<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="generateModal" class="modal fade">
						<form id="modalformnewclient" name="modalformnewclient" >
						  <div class="modal-dialog">
			                  <div class="modal-content">
				                  <div class="modal-header">
			                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			                          <h4 class="modal-title">Generando planilla...</h4>
			                      </div>
			                      <div class="modal-body">
			                      
			                  <div class="progress progress-striped active">
						  <div class="progress-bar"  role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 50%">
						    <span class="sr-only">50% Complete</span>
						  </div>
						</div>
			                  
			               
                                          </div>                                                                                                                                                                          
                         <!-- div class="modal-footer">
			                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
			                          <button class="btn btn-theme" type="button" id="saveclientbutton">Guardar</button>
			                      </div>
                               -->                                                                                             
                      
				                      
			                      
			                      
			                  </div>
			              </div>
		              </form>
		          </div>
		          
      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer no-print">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
	<%@include file="fragment/footerscripts.jsp"%>
	<script>
			$(document).load(function(){
			    $('[data-toggle="tooltip"]').tooltip(); 
			});
			</script>
  </body>
</html>
