<%@page import="org.apache.commons.lang3.StringUtils"%>
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
		location.replace( "filter-rpt-salidas.jsp" );
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

	String bodega = request.getParameter( "bodega" );
	String tipo   = request.getParameter( "tipo" );
	boolean valorizado = "V".equals( tipo );
	String sql =
	"SELECT " +
		"HEAD.BODEGA,HEAD.FECHA, HEAD.USUARIO, HEAD.CORRELATIVO, HEAD.OBSERVACIONES, " +
		"DETAIL.ID_PRODUCTO,DETAIL.UNIDADES_PRODUCTO*DETAIL.PACKING_SELECCIONADO, " +
		"PRO.CODIGO,PRO.DESCRIPCION,PRO.PRECIO*DETAIL.UNIDADES_PRODUCTO*DETAIL.PACKING_SELECCIONADO,PRO.PRECIO " +
		"FROM SALIDAS_BODEGA HEAD, SALIDAS_BODEGA_DETALLE DETAIL, PRODUCTOS PRO " +
		"WHERE " + 
		"HEAD.ID = DETAIL.ID_SALIDA AND DETAIL.ID_PRODUCTO = PRO.ID ";
		if( request.getParameter( "fecha-inicio" ) != null && request.getParameter( "fecha-inicio" ).length() > 0  && request.getParameter( "fecha-fin" ) != null && request.getParameter( "fecha-fin" ).length() > 0 ){
			sql += "AND HEAD.FECHA BETWEEN '" + request.getParameter( "fecha-inicio" ) + " 00:00' AND '" + request.getParameter( "fecha-fin" ) + " 23:59' " ;
		}
		if( !StringUtils.isEmpty( bodega ) ){
			sql += " AND HEAD.BODEGA=" + bodega ;
		}
		
		sql += " ORDER BY PRO.CODIGO";
	
	
	
	

	
	
	ArrayList<ExtendedFieldsBean> list = Util.getFromQuery( sql );
	BodegasMain bodegasMain = new BodegasMain();
	BodegaBean bodegaBean = null;
	
	if( !StringUtils.isEmpty( bodega )) {
		bodegaBean = bodegasMain.getBodega( Integer.valueOf( bodega ));
	}

%>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><b>&nbsp;por&nbsp;</b><%= loggedUser.getNombre() %></h4>
<h1>VOLCANCITO</h1>
<h2>
	REPORTE DE SALIDAS
	
	<% if( !StringUtils.isEmpty( bodega )) { %>
          			    DE BODEGA <%= bodegaBean.getNombre() %>
          			    <% } %>
          			    
</h2>
<hr>	

<table width="100%" style="text-align: left;">

	
	<tr>
		<td colspan="4">
			<table border="0" width="100%" >
				<thead>
				              <tr>
                                  
                                  
                                  <th>Bodega</th>
                                  <th>Fecha</th>
                                  <th>Usuario</th>
                                  <th>Correlativo</th>
                                  <th align="right">Unidades</th>
                                  <% if( valorizado ){ %>
                                  <th align="right">Costo</th>
                                  <th align="right">Total</th>
                                  <% } %>
                              </tr>
                </thead>
                <tbody>
                              <%
                              	String lastFamily = "";
                              	String lastFamilyName = "";
                                boolean printtotals = false;
                                
                                double total = 0;
                              	int subtotal = 0;
                                int contador = 0;
                                double grandTotal = 0;
                                int grandTotalUnidades = 0;
                                
                              	for( ExtendedFieldsBean us : list ){
                              		if( !lastFamily.equals( us.getValue( "8" )) ){
                              			printtotals = true;
		                        		if( contador > 0 ){ %>
		                              	<tr>
										  <td></td>
										  <td></td>
										  <td></td>
										  <td align="right"><B>Total</B></td>
										  <td align="right"><B><%= subtotal %></B></td>
										   <% if( valorizado ){ %>
										  <td></td>
										  <td align="right"><B><%=Util.formatCurrencyWithNoRound( Double.valueOf( total )) %></B></td>
										  <% } %>
		                              	</tr>
		                              <%
		                                 
		                              	  printtotals = false;
			                              subtotal = 0;
			                              total = 0;
		                              } 
		                               lastFamily     = us.getValue( "8" );
		                               lastFamilyName = us.getValue( "9" );
		                               %>
		                              	<tr>
		                              	<td colspan="8"><b><div style="text-transform: uppercase;"><%= lastFamily %> - <%= lastFamilyName %></div></b><hr></td>
		                              	
		                              	</tr>
		                              <%			
		                              		}
		                              %>
                              		<tr>
                              		 	  <td><%= us.getReferenced( "1", "BODEGAS", "NOMBRE" ) %></td>
										  <td><%= us.getValue( "2" ) %></td>
										  <td><%= us.getReferenced("3", "USUARIOS", "NOMBRE") %></td>
										  <td  align="right"><%= us.getValue( "4" ) %></td>
										  <td  align="right"><%= us.getValue( "7" ) %></td>
										   <% if( valorizado ){ %>
										  <td  align="right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "11" ))) %></td>
										  <td  align="right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( us.getValue( "10" ) ))%></td>
										  <% } %>
										  
	                              	</tr>
                              <%
                              subtotal  += Integer.valueOf( us.getValue("7") );
                              total  += Double.valueOf( us.getValue("10") );
                              contador ++;
                              
                              grandTotal += Double.valueOf( us.getValue("10") );
                              grandTotalUnidades += Integer.valueOf( us.getValue("7") );
                             
                               } %>
                               <tr>
										  <td></td><td></td>
										  <td></td>
										  <td align="right"><B>Total</B></td>
										  <td align="right"><B><%= subtotal  %></B></td>
										   <% if( valorizado ){ %>
										  <td></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( Double.valueOf( total )) %></B></td>
										  <% } %>
		                              	</tr>
		                              	 <tr>
										  <td></td><td></td>
										  <td></td>
										  <td align="right"><B>Gran Total</B></td>
										  <td align="right"><B><%= grandTotalUnidades  %></B></td>
										   <% if( valorizado ){ %>
										  <td></td>
										  <td align="right"><B><%= Util.formatCurrencyWithNoRound( Double.valueOf( grandTotal )) %></B></td>
										  <% } %>
		                              	</tr>
                              </tbody>
                
			</table>
		</td>
	</tr>
</table>
</body>
</html>
