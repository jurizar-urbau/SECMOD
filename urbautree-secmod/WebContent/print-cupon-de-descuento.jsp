<%@page import="com.urbau.misc.Util"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.UsuariosMain"%>
<%@page import="com.urbau.beans.UsuarioBean"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
//SELECT MONTO,DESCRIPCION,ID_USUARIO,FECHA_CREACION,ESTADO,ID_CLIENTE,ID_MOTIVO FROM CUPONES_DE_DESCUENTO WHERE ID=2

String idString = request.getParameter( "id" );
int id = Integer.valueOf( idString );

ExtendedFieldsBaseMain cuponesMain = new ExtendedFieldsBaseMain( "CUPONES_DE_DESCUENTO", 
	    new String[]{"MONTO","DESCRIPCION","ID_USUARIO","FECHA_CREACION","ESTADO","ID_CLIENTE","ID_MOTIVO"},
		new int[]{ 
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER } );

ExtendedFieldsBean cupon = cuponesMain.get( id );

%>
<script>
	function regresar(){
		location.replace( "descuentos.jsp" );
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
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<br/>
<br/><br/>
<table width="60%" style="text-align: left;"  border="1" ALIGN="CENTER">
<tr>
	<td colspan="2" style="text-align:center">
		<h1>CUPON DE DESCUENTO</h1>
	</td>
</tr>
	<tr>
		<th width="10%">No.</th>
		<th><%= cupon.getId()  %></th>
	</tr>
	<tr>
		<th>Cliente</th>
		<th><%= cupon.getReferenced("ID_CLIENTE", "CLIENTES", "NOMBRES") + " " +  cupon.getReferenced("ID_CLIENTE", "CLIENTES", "APELLIDOS") %></th>
	</tr>
	<tr>
		<th>Fecha</th>
		<th><%= cupon.getValue( "FECHA_CREACION")  %></th>
	</tr>
	<tr>
		<th>Descripci&oacute;n</th>
		<th><%= cupon.getValue( "DESCRIPCION")  %></th>
	</tr>
	<tr>
		<th>Usuario de creaci&oacute;n</th>
		<th><%= cupon.getReferenced("ID_USUARIO", "USUARIOS", "USUARIO") %></th>
	</tr>
	<tr>
		<th>Motivo</th>
		<th><%= cupon.getReferenced("ID_MOTIVO", "MOTIVOS_DE_DESCUENTO", "DESCRIPCION") %></th>
	</tr>
	
	<tr>
		<th>Estado</th>
		<th><%= "C".equals( cupon.getValue( "ESTADO") ) ? "CREADO" : ( "U".equals( cupon.getValue( "ESTADO") ) ? "USADO" : "-" )  %></th>
	</tr>
	 <tr>
		<th>Monto</th>
		<th><%= cupon.getValue( "MONTO")  %></th>
	</tr>
</table>
</body>
</html>
