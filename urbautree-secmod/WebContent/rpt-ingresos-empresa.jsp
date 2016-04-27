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
<%
boolean envio = !"transito".equals( request.getParameter( "from" ) );

%>
<script>
	function regresar(){
		location.replace( "caja-punto-de-venta-cierres.jsp?id-caja=<%= request.getParameter( "id-caja" )%>&id-punto=<%= request.getParameter( "id-punto" ) %>" );
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

// SELECT DATE_FORMAT(FECHA,'%m') FECHA,SUM(MONTO) FROM ORDENES WHERE ESTADO='P' GROUP BY 1



	String sql = "SELECT DATE_FORMAT(FECHA,'%m') FECHA,SUM(MONTO) FROM ORDENES WHERE ESTADO='P' GROUP BY 1";
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
                                  <th colspan="2" align="center">VENTAS</th>
                                  
                              </tr>
                              <tr>
                                  <th>MES</th>
                                  <th>A&Ntilde;O</th>
                              </tr>
                </thead>
                <tbody>
                              <%
                              	double total =0;
                              String lastTitle = "";
	                          	
                              	for( ExtendedFieldsBean us : list ){
                              		
                              		
                              		
                              		String fecha  = us.getValue( "1" );
                              		String monto     = us.getValue( "2" );
                              		
                              %>
                              <tr>
								  <td><%= fecha %></td>
								  <td><%= monto %></td>
								  
                              </tr>
                              <% } %>
                              </tbody>
                
			</table>
		</td>
	</tr>
</table>
</body>
</html>
