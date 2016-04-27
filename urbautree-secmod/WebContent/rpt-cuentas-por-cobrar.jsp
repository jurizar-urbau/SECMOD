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
<script>
	function regresar(){
		location.replace( "home.jsp" );
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
	</style>
<%

	String sql = 
			"SELECT * FROM " +
			"	( " + 
			"		SELECT " + 
			"			CLIENTES_CREDITOS.ID, " +
			"			CLIENTES_CREDITOS.ID_ORDEN, " +
			"			CLIENTES_CREDITOS.ID_CLIENTE, " +
			"			CLIENTES.NOMBRES, " + 
			"			CLIENTES.APELLIDOS, " +
			"			CLIENTES_CREDITOS.FECHA_CREDITO, " +
			"			CLIENTES_CREDITOS.MONTO, " +
			"			IFNULL(SUM(CLIENTES_CREDITOS_PAGOS.MONTO),0) PAGOS, " +
			"			CLIENTES_CREDITOS.MONTO-IFNULL(SUM(CLIENTES_CREDITOS_PAGOS.MONTO),0) SALDO " +
			"		FROM " +
			"			CLIENTES, " + 
			"			CLIENTES_CREDITOS " + 
			"				LEFT JOIN " + 
			"					CLIENTES_CREDITOS_PAGOS ON CLIENTES_CREDITOS.ID = CLIENTES_CREDITOS_PAGOS.ID_CREDITO " + 
			"		WHERE " + 
			"			CLIENTES.ID = CLIENTES_CREDITOS.ID_CLIENTE " + 
			"		GROUP BY " + 
			"			CLIENTES_CREDITOS.ID " +
			"	) REPORTE " + 
			"WHERE " + 
			"	REPORTE.MONTO > REPORTE.PAGOS";
			
	ArrayList<ExtendedFieldsBean> list = Util.getFromQuery( sql );
	

%>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<table width="100%" style="text-align: left;">

	
	<tr>
		<td colspan="4">
			<table border="1" width="100%" >
				<thead>
				 <tr>
                                  <th colspan="9" align="center">CUENTAS POR COBRAR</th>
                                  
                              </tr>
                              <tr>
                                  <th>ID Credito</th>
                                  <th>ID Orden</th>
                                  <th>ID Cliente</th>
                                  <th>Nombres cliente</th>
                                  <th>Apellidos cliente</th>
                                  <th>Fecha de credito</th>
                                  <th>Monto</th>
                                  <th>Total pagos</th>
                                  <th>Saldo</th>
                                  
                              </tr>
                </thead>
                <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              %>
                              <tr>
								  <td><%= us.getValue( "1" ) %></td>
								  <td><%= us.getValue( "2" ) %></td>
								  <td><%= us.getValue( "3" ) %></td>
								  <td><%= us.getValue( "4" ) %></td>
								  <td><%= us.getValue( "5" ) %></td>
								  <td><%= us.getValue( "6" ) %></td>
								  <td align="right">Q. <%= us.getValue( "7" ) %></td>
								  <td align="right">Q. <%= us.getValue( "8" ) %></td>
								  <td align="right">Q. <%= us.getValue( "9" ) %></td>
								  
                              </tr>
                              <% } %>
                              </tbody>
                
			</table>
		</td>
	</tr>
</table>
</body>
</html>
