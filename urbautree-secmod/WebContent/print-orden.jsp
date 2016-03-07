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
		"ORDENES" , 
		new String[]{"FECHA","ID_CLIENTE","ID_BODEGA","MONTO","ID_USUARIO","ESTADO"}, 
		new int[]{ 
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING
		}
);


ExtendedFieldsFilter facturaFilter = new ExtendedFieldsFilter( new String[]{"ID"},new int[]{ ExtendedFieldsFilter.EQUALS}, new int[]{ Constants.EXTENDED_TYPE_INTEGER}, new String[]{ request.getParameter( "id")});
ArrayList<ExtendedFieldsBean> facturasBean = facturasMain.getAll( facturaFilter );
ExtendedFieldsBean facturaBean = null;
if( facturasBean.size() == 1 ){
	facturaBean = facturasBean.get( 0 );
}


ExtendedFieldsBaseMain factura_detail = new ExtendedFieldsBaseMain( "ORDENESDETALLE", 
		new String[]{"ID_ORDEN","ID_PRODUCTO","PRECIO_UNITARIO","CANTIDAD","TOTAL"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DOUBLE
		} );

ArrayList<ExtendedFieldsBean> results = factura_detail.getAll( new ExtendedFieldsFilter(new String[]{"ID_ORDEN"},new int[]{ExtendedFieldsFilter.EQUALS}, new int[]{Constants.EXTENDED_TYPE_STRING},new String[]{request.getParameter( "id" )}));
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
		<th>Orden</th><td><%= facturaBean.getId() %></td>
	</tr>
	<tr>
		<th>Fecha</th><td><%= facturaBean.getValue( "FECHA" ) %></td>
	</tr>
	<tr>
		<th>Cliente</th><td><%= facturaBean.getValue( "ID_CLIENTE" ) %> <%= facturaBean.getReferenced( "ID_CLIENTE", "CLIENTES", "NOMBRES") %></td>
	</tr>
	<tr>
		<th>Bodega</th><td><%= facturaBean.getValue( "ID_BODEGA" ) %> <%= facturaBean.getReferenced( "ID_BODEGA", "BODEGAS", "NOMBRE") %></td>
	</tr>
	<tr>
		<th>Monto</th><td><%= facturaBean.getValue( "MONTO" ) %></td>
	</tr>
	<tr>
		<th>Usuario</th><td><%= facturaBean.getValue( "ID_USUARIO" ) %> <%= facturaBean.getReferenced( "ID_USUARIO", "USUARIOS", "NOMBRE") %></td>
	</tr>
	<tr>
		<th>Estado</th><td><%= "I".equals( facturaBean.getValue( "ESTADO" ) ) ? "Ingresada" : ( "P".equals( facturaBean.getValue( "ESTADO" ) ) ? "Pagada" : "-" )  %></td>
	</tr> 
	<tr>
		<td colspan="4">
			<table border="1" width="100%" >
				<tr>
					<th>Producto</th><th>Unitario</th><th>Cantidad</th><th>Total</th>
				</tr>
				
				<%
					for( ExtendedFieldsBean b : results ){
					%>
					<tr>
						<td><%= b.getValue( "ID_PRODUCTO" ) %> - <%= b.getReferenced( "ID_PRODUCTO", "PRODUCTOS", "DESCRIPCION") %></td>
						<td><%= b.getValue( "PRECIO_UNITARIO" )%></td>
						<td><%= b.getValue( "CANTIDAD" )%></td>
						<td><%= b.getValue( "TOTAL" ) %></td>
					</tr>
				<% } %>
				<tr>
						<td></td>
						<td></td>
						<td></td>
						<td><%= facturaBean.getValue( "MONTO" ) %></td>
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
