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

ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "TRASLADOS_HEADER", 
		new String[]{"BODEGA_ORIGEN","BODEGA_DESTINO","FECHA","ESTADO","USUARIO","TRANSID"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DATE,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_STRING
			
		} );

ExtendedFieldsBaseMain dm = new ExtendedFieldsBaseMain( "TRASLADOS_DETAIL", 
		new String[]{"PRODUCTO","UNIDADES","PACKING","ID_TRASLADO"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER
			
		} );

ExtendedFieldsBaseMain pm = new ExtendedFieldsBaseMain( "PRODUCTOS", 
		new String[]{"CODIGO","DESCRIPCION"},
			new int[]{ 
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING
			
		} );


ArrayList<ExtendedFieldsBean> results = um.getAll( new ExtendedFieldsFilter(new String[]{"TRANSID"},new int[]{ExtendedFieldsFilter.EQUALS}, new int[]{Constants.EXTENDED_TYPE_STRING},new String[]{request.getParameter( "id" )}));
ExtendedFieldsBean bean = null;
	if( results.size() > 0  ){
		bean = results.get( 0 );
	}
BodegasMain bodegasMain = new BodegasMain();
UsuariosMain usuariosMain = new UsuariosMain();
BodegaBean bodegaOrigen = bodegasMain.getBodega( bean.getValueAsInt( "BODEGA_ORIGEN" ) );
BodegaBean bodegaDestino = bodegasMain.getBodega( bean.getValueAsInt( "BODEGA_DESTINO" ) );
UsuarioBean usuarioBean = usuariosMain.get( bean.getValueAsInt( "USUARIO" )); 
%>
</head>
<body>
<table width="100%" style="text-align: left;">
	<tr>
		<td></td><td></td><td width="70%">&nbsp;</td>
	</tr>
	<tr>
		<th>Bodega Origen</th><td><%= bodegaOrigen.getId() + " " + bodegaOrigen.getNombre() %></td>
	</tr>
	<tr>
		<th>Bodega Destino</th><td><%= bodegaDestino.getId() + " " + bodegaDestino.getNombre() %></td>
	</tr>
	<tr>
		<th>Usuario</th><td><%= usuarioBean.getNombre().toUpperCase() %></td>
	</tr>
	<tr>
		<th>Fecha</th><td><%= bean.getValue( "FECHA" ) %></td>
	</tr>
	<tr>
		<td colspan="4">
			<table border="1" width="100%" >
				<tr>
					<th width="30px">Unidades</th><th>Descripcion</th><th>Packing</th>
				</tr>
				
				<%
					ExtendedFieldsFilter filter = new ExtendedFieldsFilter(new String[]{"ID_TRASLADO"},new int[]{ ExtendedFieldsFilter.EQUALS }, new int[]{ Constants.EXTENDED_TYPE_INTEGER}, new String[]{ request.getParameter( "id" ) } );
					ArrayList<ExtendedFieldsBean> details = dm.getAll( filter );
					for( ExtendedFieldsBean b : details ){
						ExtendedFieldsBean producto = pm.get( b.getValueAsInt( "PRODUCTO" ));
					%>
					<tr>
						<td><%= b.getValue( "UNIDADES" ) %></td><td><%= producto.getValue( "CODIGO" ) + " " + producto.getValue( "DESCRIPCION" )%></td><td><%= b.getValue( "PACKING" ) %></td>
					</tr>
				<% } %>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
