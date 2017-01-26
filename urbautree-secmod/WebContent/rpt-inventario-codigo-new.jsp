<%@page import="com.urbau.misc.CorrelativosUtil"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.urbau.feeders.ExtendedFieldsOrderBy"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.beans.ProductoBean"%>
<%@page import="java.util.Date"%>
<%@page import="com.urbau.misc.Util"%>
<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.beans.TwoFieldsBean"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="fragment/validator.jsp"%>
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
	
	ExtendedFieldsOrderBy orderBy = new ExtendedFieldsOrderBy(new String[]{"PRO.CODIGO"}, false );
	
	ArrayList<ExtendedFieldsBean> list = reporteMain.getAll( filter, orderBy );
	ProductosMain productosMain = new ProductosMain();	
	%>
	
<script>
	function regresar(){
		location.replace( "filter-rpt-inventario.jsp" );
	}
</script>
<style>
	@page { size: auto;  margin: 10mm; }

	@media print
	{    
	    .no-print, .no-print *
	    {
	        display: none !important;
	    }
	    
  		a[href]:after {
		    content: none !important;
		  }
	    .row {
			display: table-row;
			width: 100%;
		}
		.col {
			border: 1px solid #999999;
			display: table-cell;
			padding: 3px 10px;
		}
	}
	
	body{
		padding: 25px;
		
	}
		
	
	</style>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<% Calendar cal = Calendar.getInstance();
		int mes = cal.get( Calendar.MONTH ) + 1 ;
		int year = cal.get( Calendar.YEAR );
		CorrelativosUtil correlativosUtil = new CorrelativosUtil();
		int nextCorr = correlativosUtil.getNextAndAdvance( "GENERACION_INVENTARIO_" + bodegaBean.getId() );
	%>
<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><b>&nbsp;por&nbsp;</b><%= loggedUser.getNombre() %></br><%= bodegaBean.getId() + "-" + nextCorr + "-" + mes + "-" + year %></h4>
<h1>VOLCANCITO</h1>
<h2>
	INVENTARIO
</h2>
<table>
	<tr>
		<td><b>BODEGA</b></td><td>:</td><td><%= bodegaBean.getNombre() %></td>
	</tr>
</table>
<hr>	
<table width="100%" style="text-align: left;">
          				  <%
	                  	  	  	Date date = new Date();
	                  	  	  	date.setTime( System.currentTimeMillis() );
	                  	  	  	
	                  	  	  	int globalcounter=1;
	                  	  	  %>
	                  	  	  <thead>
                              <tr>
                                  <th>Codigo</th>
                                  <th>Descripcion</th>
                                  <% if( request.getParameter( "imagen" ) != null ){  %>
                                  <th>Imagen</th>
                                  <% } %>
                                  <th style="text-align:right">Cantidad</th>
                                  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
                                  <th style="text-align:right">Unitario</th>
                                  <th style="text-align:right">Total</th>
                                  <% } %>
                              </tr>
                              </thead>
                              </table>
                              
                              
                              <%
                              	double total_costo =0;
	                          	double total_precio1=0;
                              	for( ExtendedFieldsBean us : list ){
                              		ProductoBean producto = productosMain.get( Integer.valueOf( us.getValue( "PRO.ID" )));
                              		total_precio1 += Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Double.valueOf( us.getValue( "INV.AMOUNT" ) );
                              %>
                              <div class="row">
								  <div class="col"><%= globalcounter++ %>  <%= us.getValue( "PRO.CODIGO" ) %></div>
								  <div class="col"><%= us.getValue( "PRO.DESCRIPCION" ) %></div>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <div class="col">
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  </div>
								  <% } %>
								  <div class="col" style="text-align:right"><%= us.getValue( "INV.AMOUNT" ) %></div>
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								    
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ))%></div>
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Integer.valueOf( us.getValue( "INV.AMOUNT" ) ) ) %></div>
								  <% } %>
                              </div>
                              	<% } %>
                              	 <%
                              	for( ExtendedFieldsBean us : list ){
                              		ProductoBean producto = productosMain.get( Integer.valueOf( us.getValue( "PRO.ID" )));
                              		total_precio1 += Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Double.valueOf( us.getValue( "INV.AMOUNT" ) );
                              %>
                              <div class="row">
								  <div class="col"><%= globalcounter++ %> <%= us.getValue( "PRO.CODIGO" ) %></div>
								  <div class="col"><%= us.getValue( "PRO.DESCRIPCION" ) %></div>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <div class="col">
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  </div>
								  <% } %>
								  <div class="col" style="text-align:right"><%= us.getValue( "INV.AMOUNT" ) %></div>
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								    
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ))%></div>
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Integer.valueOf( us.getValue( "INV.AMOUNT" ) ) ) %></div>
								  <% } %>
                              </div>
                              	<% } %>
                              	<%
                              	for( ExtendedFieldsBean us : list ){
                              		ProductoBean producto = productosMain.get( Integer.valueOf( us.getValue( "PRO.ID" )));
                              		total_precio1 += Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Double.valueOf( us.getValue( "INV.AMOUNT" ) );
                              %>
                              <div class="row">
								  <div class="col"><%= globalcounter++ %> <%= us.getValue( "PRO.CODIGO" ) %></div>
								  <div class="col"><%= us.getValue( "PRO.DESCRIPCION" ) %> <%= us.getValue( "PRO.DESCRIPCION" ) %></div>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <div class="col">
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  </div>
								  <% } %>
								  <div class="col" style="text-align:right"><%= us.getValue( "INV.AMOUNT" ) %></div>
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								    
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ))%></div>
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Integer.valueOf( us.getValue( "INV.AMOUNT" ) ) ) %></div>
								  <% } %>
                              </div>
                              	<% } %>
                              	<%
                              	for( ExtendedFieldsBean us : list ){
                              		ProductoBean producto = productosMain.get( Integer.valueOf( us.getValue( "PRO.ID" )));
                              		total_precio1 += Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Double.valueOf( us.getValue( "INV.AMOUNT" ) );
                              %>
                              <div class="row">
								  <div class="col"><%= globalcounter++ %> <%= us.getValue( "PRO.CODIGO" ) %></div>
								  <div class="col"><%= us.getValue( "PRO.DESCRIPCION" ) %></div>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <div class="col">
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  </div>
								  <% } %>
								  <div class="col" style="text-align:right"><%= us.getValue( "INV.AMOUNT" ) %></div>
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								    
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ))%></div>
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Integer.valueOf( us.getValue( "INV.AMOUNT" ) ) ) %></div>
								  <% } %>
                              </div>
                              	<% } %>
                              	<%
                              	for( ExtendedFieldsBean us : list ){
                              		ProductoBean producto = productosMain.get( Integer.valueOf( us.getValue( "PRO.ID" )));
                              		total_precio1 += Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Double.valueOf( us.getValue( "INV.AMOUNT" ) );
                              %>
                              <div class="row">
								  <div class="col"><%= globalcounter++ %> <%= us.getValue( "PRO.CODIGO" ) %></div>
								  <div class="col"><%= us.getValue( "PRO.DESCRIPCION" ) %></div>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <div class="col">
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  </div>
								  <% } %>
								  <div class="col" style="text-align:right"><%= us.getValue( "INV.AMOUNT" ) %></div>
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								    
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ))%></div>
								  <div class="col" style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Integer.valueOf( us.getValue( "INV.AMOUNT" ) ) ) %></div>
								  <% } %>
                              </div>
                              	<% } %>
                              <div class="row">
								  <div></div>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <div></div>
								  <%} %>
								  <div></div> 
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								  <div></div>
								  <div style="text-align:right"><b><i>TOTAL</i></b></div>
								  <div style="text-align:right"><b><%= Util.formatCurrencyWithNoRound( total_precio1 ) %></b></div>
								   <% } %>
                              </div>
		</body>
</html>