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
		@page { size: auto;  margin: 0mm; }
	</style>
		
	<%@include file="fragment/head.jsp"%>
	<%
	
	String bodega = request.getParameter( "bodega" );
	
	BodegasMain bodegasMain = new BodegasMain();
	BodegaBean bodegaBean = bodegasMain.getBodega( Integer.valueOf( bodega ));
	
	ExtendedFieldsBaseMain reporteMain = new ExtendedFieldsBaseMain( "INV" + bodega + " INV, PRODUCTOS PRO", 
			new String[]{"PRO.CODIGO","PRO.DESCRIPCION","IMAGE_PATH","INV.AMOUNT"},
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
          				  <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i>&nbsp;<%= bodegaBean.getNombre() %>  > Inventario </h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  <th>Codigo</th>
                                  <th>Descripcion</th>
                                  <th>Imagen</th>
                                  <th>Cantidad</th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              		
                              %>
                              <tr>
								  <td><%= us.getValue( "PRO.CODIGO" ) %></td>
								  <td><%= us.getValue( "PRO.DESCRIPCION" ) %></td>
								  <td>
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  <td><%= us.getValue( "INV.AMOUNT" ) %></td>
                              </tr>
                              <% } %>
                              
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
