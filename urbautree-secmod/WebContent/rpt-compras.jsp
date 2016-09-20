<%@page import="java.util.Date"%>
<%@page import="com.urbau.misc.Util"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.feeders.UsuariosMain"%>
<%@page import="com.urbau.beans.UsuarioBean"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="fragment/validator.jsp"%>
<script>
	function regresar(){
		location.replace( "filter-rpt-compras.jsp" );
	}
</script>
<style>
	@page { size: auto;  margin: 0mm; }

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
	uppercase {
	    text-transform: uppercase;
	}
	body{
		padding: 25px;
		
	}
	</style>
<%
	String sql = "SELECT " + 
					"PRO.NOMBRE, " +
					"COMP.FECHA, " + 
					"COMP.ID_ORDEN_DE_COMPRA, " +
					"COMP.SUBTOTAL, " + 
					"COMP.DESCUENTO, " + 
					"COMP.TOTAL " +  
				"FROM COMPRAS COMP, PROVEEDORES PRO WHERE COMP.ID_PROVEEDOR = PRO.ID ";

			if( request.getParameter( "proveedor") != null && !"*".equals( request.getParameter( "proveedor")) ){
				sql += " AND ID_PROVEEDOR =" + request.getParameter( "proveedor" ) + " ";
			}
			if( request.getParameter( "fecha-inicio" ) != null && request.getParameter( "fecha-inicio" ).length() > 0  && request.getParameter( "fecha-fin" ) != null && request.getParameter( "fecha-fin" ).length() > 0 ){
				sql += "AND COMP.FECHA BETWEEN '" + request.getParameter( "fecha-inicio" ) + " 00:00' AND '" + request.getParameter( "fecha-fin" ) + " 23:59' " ;
			}
			if( "P".equals( request.getParameter( "agrupado" ))){
				sql += " ORDER BY PRO.NOMBRE";
			} else {
				sql += " ORDER BY COMP.ID_ORDEN_DE_COMPRA";				
			}
			
	ArrayList<ExtendedFieldsBean> list = Util.getFromQuery( sql );
	

%>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><b>&nbsp;por&nbsp;</b><%= loggedUser.getNombre() %></h4>
<h1>VOLCANCITO</h1>
<h2>
	REPORTE DE COMPRAS
</h2>
<hr>	

<table width="100%" style="text-align: left;">

	
	<tr>
		<td colspan="4">
			<table border="0" width="100%" >
				<thead>
				              <tr>
                                  
                                  <th>Fecha</th>
                                  <th>Orden de compra</th>
                                  <th align="right">Subtotal</th>
                                  <th align="right">Descuento</th>
                                  <th align="right">Total</th>                                  
                              </tr>
                </thead>
                <tbody>
                              <%
                              	String lastFamily = "";
                                boolean printtotals = false;
                                
                                double subtotal = 0;
                                double descuento = 0;
                                double total = 0;
                                
                                double grandsubtotal = 0;
                                double granddescuento = 0;
                                double grandtotal = 0;
                                
                                
                                int contador = 0;
                              	for( ExtendedFieldsBean us : list ){
                              		if( !lastFamily.equals( us.getValue( "1" )) ){
                              			
                              			printtotals = true;
		                             
                              			if( contador > 0 ){ %>
		                              	<tr>
										  <td></td>
										  <td align="right"><B>Totales</B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( subtotal ) %></B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( descuento ) %></B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( total ) %></B></td>
		                              	</tr>
		                              <%
		                                 
		                              	  printtotals = false;
			                              subtotal = 0;
			                              descuento = 0;
			                              total = 0;
			                              
		                              } 
		                               lastFamily = us.getValue( "1" );
		                               %>
		                              	<tr>
		                              	<td colspan="6"><b><div style="text-transform: uppercase;"><%= lastFamily %></div></b><hr></td>
		                              	
		                              	</tr>
		                              <%			
		                              		}
		                              %>
                              		<tr>
										  <td><%= us.getValue( "2" ) %></td>
										  <td><%= us.getValue( "3" ) %></td>
										  <td align="right"><%= Util.formatCurrencyWithNoRound( Double.valueOf ( us.getValue( "4" ))) %></td>
										  <td align="right"><%= Util.formatCurrencyWithNoRound( Double.valueOf ( us.getValue( "5" ))) %></td>
										  <td align="right"><%= Util.formatCurrencyWithNoRound( Double.valueOf ( us.getValue( "6" ))) %></td>
	                              	</tr>
                              <%
                              subtotal  += Double.valueOf( us.getValue("4") );
                              descuento += Double.valueOf( us.getValue("5") );
                              total     += Double.valueOf( us.getValue("6") );
                              
                              
                              grandsubtotal  += Double.valueOf( us.getValue("4") );
                              granddescuento += Double.valueOf( us.getValue("5") );
                              grandtotal     += Double.valueOf( us.getValue("6") );
                              
                              contador ++;
                             
                               } %>
                               <tr>
										  <td></td>
										  
										  <td align="right"><B>Totales</B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( subtotal ) %></B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( descuento ) %></B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( total ) %></B></td>
		                              	</tr>
		                              	<tr>
										  <td></td>
										  
										  <td align="right"><B>Gran Total</B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( grandsubtotal ) %></B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( granddescuento ) %></B></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( grandtotal ) %></B></td>
		                              	</tr>
                              </tbody>
                
			</table>
		</td>
	</tr>
</table>
</body>
</html>
