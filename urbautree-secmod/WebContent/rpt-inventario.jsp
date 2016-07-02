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
	@page { size: auto;  margin: 5mm; }

	@media print
	{    
	    .no-print, .no-print *
	    {
	        display: none !important;
	    }
	    
  		a[href]:after {
		    content: none !important;
		  }
	    
	}
	</style>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>

<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><b>&nbsp;por&nbsp;</b><%= loggedUser.getNombre() %></h4>
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
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <td>
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "IMAGE_PATH" ) %>&w=50&type=smooth" width="30px">
								  </td>
								  <% } %>
								  <td style="text-align:right"><%= us.getValue( "INV.AMOUNT" ) %></td>
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								    
								  <td style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ))%></td>
								  <td style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "PRO.PRECIO" ) ) * Integer.valueOf( us.getValue( "INV.AMOUNT" ) ) ) %></td>
								  <% } %>
                              </tr>
                              <% } %>
                              <tr>
								  <td></td>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <td></td>
								  <%} %>
								  <td></td> 
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								  <td></td>
								  <td style="text-align:right"><b><i>TOTAL</i></b></td>
								  <td style="text-align:right"><b><%= Util.formatCurrencyWithNoRound( total_precio1 ) %></b></td>
								   <% } %>
                              </tr>
                              </tbody>
                          </table>


		</body>
</html>
