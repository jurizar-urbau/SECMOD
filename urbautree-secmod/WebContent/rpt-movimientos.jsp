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
		location.replace( "filter-rpt-movimientos.jsp" );
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

	String sql = 
			"SELECT " + 
			"	FAM.NOMBRE FAMILIA, " +
			"	PROD.CODIGO CODIGO, " +
			"	PROD.DESCRIPCION DESCRIPCION, " + 
			"	SUM(DETALLE.CANTIDAD) UNIDADES " +
			"FROM " + 
			"	ORDENES ORDEN, ORDENESDETALLE DETALLE, PRODUCTOS PROD, FAMILIAS FAM " + 
			"WHERE " + 
			"	ORDEN.ID = DETALLE.ID_ORDEN AND " + 
			"	ORDEN.ESTADO = 'P' AND " +
			"	DETALLE.ID_PRODUCTO = PROD.ID AND " +
			"	PROD.FAMILIA = FAM.ID ";

			if( request.getParameter( "ubicacion") != null ){
				sql += " AND ORDEN.ID_PUNTO_VENTA=  " + request.getParameter( "ubicacion" ) + " ";
			}
			if( request.getParameter( "fecha-inicio" ) != null && request.getParameter( "fecha-inicio" ).length() > 0  && request.getParameter( "fecha-fin" ) != null && request.getParameter( "fecha-fin" ).length() > 0 ){
				sql += "AND ORDEN.FECHA BETWEEN '" + request.getParameter( "fecha-inicio" ) + " 00:00' AND '" + request.getParameter( "fecha-fin" ) + " 23:59' " ;
			}
			
			//"AND " +
	//		"   ORDEN.FECHA BETWEEN '2016-02-28' AND '2016-03-11' " +
			sql += "GROUP BY " +
			"	FAM.NOMBRE,PROD.CODIGO,PROD.DESCRIPCION";
			
	ArrayList<ExtendedFieldsBean> list = Util.getFromQuery( sql );
	

%>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><b>&nbsp;por&nbsp;</b><%= loggedUser.getNombre() %></h4>
<h1>VOLCANCITO</h1>
<h2>
	REPORTE DE MOVIMIENTOS
</h2>
<hr>	

<table width="100%" style="text-align: left;">

	
	<tr>
		<td colspan="4">
			<table border="0" width="100%" >
				<thead>
				              <tr>
                                  <th>Codigo</th>
                                  <th>Descripcion</th>
                                  <th align="right">Unidades</th>
                              </tr>
                </thead>
                <tbody>
                              <%
                              	String lastFamily = "";
                                boolean printtotals = false;
                                
                                long unidades = 0;
                                int contador = 0;
                              	for( ExtendedFieldsBean us : list ){
                              		if( !lastFamily.equals( us.getValue( "1" )) ){
                              			
                              			printtotals = true;
		                             
                              			if( contador > 0 ){ %>
		                              	<tr>
										  <td></td>
										  <td align="right"><B>Totales</B></td>
										  <td align="right"><B><%= unidades %></B></td>
		                              	</tr>
		                              <%
		                                 
		                              	  printtotals = false;
			                              unidades = 0;
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
										  <td align="right"><%= us.getValue( "4" ) %></td>
	                              	</tr>
                              <%
                              unidades += Double.valueOf( us.getValue("4") );
                              contador ++;
                             
                               } %>
                               <tr>
										  <td></td>
										  <td align="right"><B>Total</B></td>
										  <td align="right"><B><%= unidades %></B></td>
		                              	</tr>
                              </tbody>
                
			</table>
		</td>
	</tr>
</table>
</body>
</html>
