<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.beans.TwoFieldsBean"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<style>
		@page  
		{ 
		    size: auto;   /* auto is the initial value */ 
		
		    /* this affects the margin in the printer settings */ 
		    margin: 25mm 25mm 25mm 25mm;  
		} 
	</style>
		
	<%@include file="fragment/head.jsp"%>
	<%
	
	
	ExtendedFieldsBaseMain reporteMain = new ExtendedFieldsBaseMain( "PAGOS_ORDENES", 
			new String[]{"SUM(MONTO)","TIPO_PAGO"},
				new int[]{ 
				Constants.EXTENDED_TYPE_DOUBLE, 
				Constants.EXTENDED_TYPE_STRING
			} );
	
	ExtendedFieldsFilter filter = new ExtendedFieldsFilter( new String[]{"ID_CAJA_PUNTO_VENTA","DATE_FORMAT(NOW(), '%Y-%m-%d')"},new int[]{ ExtendedFieldsFilter.EQUALS,ExtendedFieldsFilter.EQUALS},
			new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER}, new String[]{"3","'2016-02-28' GROUP BY TIPO_PAGO"}
			);
	
	
	ArrayList<ExtendedFieldsBean> list = reporteMain.getAllWithoutID(filter);
		
	%>
	
	</head>
   
   <body>
   
  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      
      <header class="header black-bg no-print">
      		<%@include file="fragment/header.jsp"%>        
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside class="no-print">
          <div id="sidebar"  class="nav-collapse no-print">
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
          		<div class="content-panel">
           					<span class="pull-right no-print">
          				  		<button type="button" class="btn btn-success" onclick="print();">Imprimir</button>&nbsp;&nbsp;&nbsp;
          				  	</span>
          		
          				  <table class="table table-striped table-advance table-hover">
          				  <%
	                  	  	  	Date date = new Date();
	                  	  	  	date.setTime( System.currentTimeMillis() );
	                  	  	  %>
	                  	  	  <thead>
                              <tr>
                                  <th>Descripcion</th>
                                  <th>Monto</th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	double total =0;
	                          	
                              	for( ExtendedFieldsBean us : list ){
                              	 total += Double.valueOf( us.getValue( "SUM(MONTO)" ));	
                              %>
                              <tr>
								  <td><%= us.getValue( "TIPO_PAGO" ) %></td>
								  <td><%= Util.formatCurrencyWithNoRound( Double.valueOf(  us.getValue( "SUM(MONTO)" ) ))%></td>
                              </tr>
                              <% } %>
                              <tr>
								  <td></td>
								  <td><b><%= Util.formatCurrency( total ) %></b></td>
                              </tr>
                              </tbody>
                          </table>
                         
                      </div>
                      
          		</div>
          	</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      
  </section>
	<%@include file="fragment/footerscripts.jsp"%>
  </body>
</html>
