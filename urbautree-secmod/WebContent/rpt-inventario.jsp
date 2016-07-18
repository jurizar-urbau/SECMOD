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
	
	String sql =    "SELECT " + 
					"FAM.NOMBRE, PRO.CODIGO,PRO.DESCRIPCION,PRO.PRECIO,PRO.ID,IMAGE_PATH,INV.AMOUNT,PRO.ID " + 
					"FROM " + 
					"	INV" + bodega + " INV, PRODUCTOS PRO, FAMILIAS FAM " + 
					"WHERE " + 
					"	PRO.FAMILIA = FAM.ID AND " + 
					"	INV.ID_PRODUCT = PRO.ID AND " + 
					"	ESTATUS = 'a' " + 
					"ORDER BY " +  
					"	FAM.NOMBRE, PRO.CODIGO";
	
	
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
	ArrayList<ExtendedFieldsBean> list = Util.getFromQuery( sql );
	//ArrayList<ExtendedFieldsBean> list = reporteMain.getAll( filter, orderBy );
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
	                          	String lastFamily = "";
                              	for( ExtendedFieldsBean us : list ){
                              		ProductoBean producto = productosMain.get( Integer.valueOf( us.getValue( "8" )));
                              		total_precio1 += Double.valueOf( us.getValue( "4" ) ) * Double.valueOf( us.getValue( "7" ) );
                              
                              	if( !lastFamily.equals( us.getValue( "1" )) ){
	%>
											<tr>
		                              	<td colspan="6">
		                              	&nbsp;
		                              	</td>
		                              	
		                              	</tr>
			                           <tr>
		                              	<td colspan="6"><b><div style="text-transform: uppercase;"><%= us.getValue(  "1" ) %></div></b><hr></td>
		                              	
		                              	</tr>
		                              <%
		                              } 
		                               lastFamily = us.getValue( "1" );
		                               %>
                              <tr>
								  <td><%= us.getValue( "2" ) %></td>
								  <td><%= us.getValue( "3" ) %></td>
								  <% if( request.getParameter( "imagen" ) != null ){  %>
								  <td>
								  <img src="./bin/RenderImage?imagePath=<%= us.getValue( "6" ) %>&w=50&type=smooth" width="30px">
								  </td>
								  <% } %>
								  <td style="text-align:right"><%= us.getValue( "7" ) %></td>
								  <% if( "V".equals( request.getParameter( "tipo" )  )){  %>
								    
								  <td style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "4" ) ))%></td>
								  <td style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "4" ) ) * Integer.valueOf( us.getValue( "7" ) ) ) %></td>
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
