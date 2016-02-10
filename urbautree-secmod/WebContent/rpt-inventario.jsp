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
	
	String bodega = request.getParameter( "bodega" );
	
	BodegasMain bodegasMain = new BodegasMain();
	BodegaBean bodegaBean = bodegasMain.getBodega( Integer.valueOf( bodega ));
	
	ExtendedFieldsBaseMain reporteMain = new ExtendedFieldsBaseMain( "INV" + bodega + " INV, PRODUCTOS PRO", 
			new String[]{"PRO.CODIGO","PRO.DESCRIPCION","PRO.PRECIO","PRO.ID","IMAGE_PATH","INV.AMOUNT"},
				new int[]{ 
				Constants.EXTENDED_TYPE_STRING, 
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING
			} );
	
	ExtendedFieldsFilter filter = new ExtendedFieldsFilter( new String[]{"INV.ID_PRODUCT","ESTATUS"},new int[]{ ExtendedFieldsFilter.EQUALS,ExtendedFieldsFilter.EQUALS},
			new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_STRING}, new String[]{"PRO.ID","A"}
			);
	
	
	ArrayList<ExtendedFieldsBean> list = reporteMain.getAll(filter);
	ProductosMain productosMain = new ProductosMain();	
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
	                  	  	  <h4>
	                  	  	  <i class="fa fa-angle-right"></i>&nbsp;
	                  	  	  <b>INVENTARIO:</b> 
	                  	  	  <%= bodegaBean.getNombre() %></br><i class="fa fa-angle-right"></i>&nbsp;
	                  	  	  <b>FECHA Y HORA:</b> <%= Util.getDateStringDMYHM( date )%></h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  <th>Codigo</th>
                                  <th>Descripcion</th>
                                  <th>Imagen</th>
                                  <th>Cantidad</th>
                                  <th>Unitario</th>
                                  <th>Total</th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	double total_costo =0;
	                          	double total_precio1=0;
                              	for( ExtendedFieldsBean us : list ){
                              		ProductoBean producto = productosMain.get( Integer.valueOf( us.getValue( "PRO.ID" )));
                              		total_precio1 += Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Double.valueOf( us.getValue( "INV.AMOUNT" ) );
                              %>
                              <tr>
								  <td><%= us.getValue( "PRO.CODIGO" ) %></td>
								  <td><%= us.getValue( "PRO.DESCRIPCION" ) %></td>
								  <td>
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  <td><%= us.getValue( "INV.AMOUNT" ) %></td>
								    
								  <td><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ))%></td>
								  <td><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Integer.valueOf( us.getValue( "INV.AMOUNT" ) ) ) %></td>
                              </tr>
                              <% } %>
                              <tr>
								  <td></td>
								  <td></td>
								  <td></td> 
								  <td></td>
								  <td><b><i>TOTAL</i></b></td>
								  <td><b><%= Util.formatCurrency( total_precio1 ) %></b></td>
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
