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
<style>
@page { size: auto;  margin: 0mm; }
</style>
<%

ExtendedFieldsBaseMain facturasMain = new ExtendedFieldsBaseMain( 
		"FACTURAS" , 
		new String[]{"ORDEN","FACTURA","FECHA","SUBTOTAL","TOTAL","USUARIO","NIT","NOMBRE","DIRECCION"}, 
		new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING
		}
);


ExtendedFieldsFilter facturaFilter = new ExtendedFieldsFilter( new String[]{"ID"},new int[]{ ExtendedFieldsFilter.EQUALS}, new int[]{ Constants.EXTENDED_TYPE_INTEGER}, new String[]{ request.getParameter( "id")});
ArrayList<ExtendedFieldsBean> facturasBean = facturasMain.getAll( facturaFilter );
ExtendedFieldsBean facturaBean = null;
if( facturasBean.size() == 1 ){
	facturaBean = facturasBean.get( 0 );
}


ExtendedFieldsBaseMain factura_detail = new ExtendedFieldsBaseMain( "FACTURAS_DETALLE", 
		new String[]{"ID_FACTURA","CANTIDAD","DESCRIPCION","SUBTOTAL","TOTAL"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_DOUBLE
		} );

ArrayList<ExtendedFieldsBean> results = factura_detail.getAll( new ExtendedFieldsFilter(new String[]{"ID_FACTURA"},new int[]{ExtendedFieldsFilter.EQUALS}, new int[]{Constants.EXTENDED_TYPE_STRING},new String[]{request.getParameter( "id" )}));
ExtendedFieldsBean bean = null;
	if( results.size() > 0  ){
		bean = results.get( 0 );
	}
%>
</head>
<body>
<%
	if( facturaBean != null ){
%>
<table width="100%" style="text-align: left;">
	<tr>
		<td></td><td></td><td width="70%">&nbsp;</td>
	</tr>
	<tr>
		<th>Orden</th><td><%= facturaBean.getValue( "ORDEN" ) %></td>
	</tr>
	<tr>
		<th>Factura</th><td><%= facturaBean.getValue( "FACTURA" ) %></td>
	</tr>
	<tr>
		<th>Fecha</th><td><%= facturaBean.getValue( "FECHA" ) %></td>
	</tr>
	<tr>
		<th>NIT</th><td><%= facturaBean.getValue( "NIT" ) %></td>
	</tr>
	<tr>
		<th>Nombre</th><td><%= facturaBean.getValue( "NOMBRE" ) %></td>
	</tr>
	<tr>
		<th>Direccion</th><td><%= facturaBean.getValue( "DIRECCION" ) %></td>
	</tr> 
	<tr>
		<td colspan="4">
			<table border="1" width="100%" >
				<tr>
					<th width="30px">Cantidad</th><th>Descripcion</th><th>Subtotal</th><th>Total</th>
				</tr>
				
				<%
					for( ExtendedFieldsBean b : results ){
					%>
					<tr>
						<td><%= b.getValue( "CANTIDAD" ) %></td>
						<td><%= b.getValue( "DESCRIPCION" )%></td>
						<td><%= b.getValue( "SUBTOTAL" )%></td>
						<td><%= b.getValue( "TOTAL" ) %></td>
					</tr>
				<% } %>
				<tr>
						<td></td>
						<td></td>
						<td></td>
						<td><%= facturaBean.getValue( "TOTAL" ) %></td>
					</tr>
			</table>
		</td>
	</tr>
</table>
<% } %>
</body>
<script>
	print();
</script>
</html>
