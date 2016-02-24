<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.feeders.UsuariosMain"%>
<%@page import="com.urbau.beans.UsuarioBean"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
@page { size: auto;  margin: 0mm; }
</style>
<%
ExtendedFieldsBaseMain facturasMain = new ExtendedFieldsBaseMain( 
		"FACTURAS" , 
		new String[]{"ORDEN","FACTURA","SUBTOTAL","TOTAL","USUARIO","NIT","NOMBRE","DIRECCION"}, 
		new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING,
				
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING
		}
);
ExtendedFieldsBean facturaBean = facturasMain.get( Integer.parseInt( request.getParameter("id") ) );
 
%>
</head>
<body>
<table width="100%" style="text-align: left;">
	<tr>
		<td></td><td></td><td width="70%">&nbsp;</td>
	</tr>
	<tr>
		<th>Factura</th><td><%= facturaBean.getValue( "FACTURA" ) %> </td>
	</tr>

	<tr>
		<th>Subtotal</th><td><%= facturaBean.getValue( "SUBTOTAL" )%></td>
	</tr>
	<tr>
		<th>Total</th><td><%= facturaBean.getValue( "TOTAL" )%></td>
	</tr>
	<tr>
		<th>Nit</th><td><%= facturaBean.getValue( "NIT" )%></td>
	</tr>
	<tr>
		<th>Nombre</th><td><%= facturaBean.getValue( "NOMBRE" )%></td>
	</tr>
	<tr>
		<th>Direccion</th><td><%= facturaBean.getValue( "DIRECCION" )%></td>
	</tr>
	
	<tr>
		<td colspan="4">
			<table border="1" width="100%" >
				<tr>
					<th width="30px">Unidades</th><th>Descripcion</th><th>Unitario</th><th>Total</th>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
