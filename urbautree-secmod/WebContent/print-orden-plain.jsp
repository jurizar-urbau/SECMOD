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
<%@ page contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%>
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



   1
   2                                                <%= Util.getFixedString( String.valueOf ( facturaBean.getId() ) , 7, "0", Util.SIDE_LEFT) %>     21    03     2016
   3
   4                                                
   5                                              jurizar                 ibautista
   6
   7    <%=  Util.getFixedString( facturaBean.getReferenced( "ID_CLIENTE", "CLIENTES", "NOMBRES"), 40, " " , Util.SIDE_RIGHT)  %>                          100
   8 
   9      <%=  Util.getFixedString( facturaBean.getReferenced( "ID_CLIENTE", "CLIENTES", "DIRECCION"), 56, " ", Util.SIDE_RIGHT)  %>     <%=  Util.getFixedString( facturaBean.getReferenced( "ID_CLIENTE", "CLIENTES", "TELEFONO"), 12, " ", Util.SIDE_RIGHT)  %>
   10
<%
					for( ExtendedFieldsBean b : results ){
%>   <%= Util.getFixedString( b.getValue( "CANTIDAD" ), 3, "0", Util.SIDE_LEFT) %>  0    <%= Util.getFixedString( b.getReferenced( "ID_PRODUCTO", "PRODUCTOS", "CODIGO"), 8, " ", Util.SIDE_RIGHT ) %> <%= Util.getFixedString( b.getReferenced( "ID_PRODUCTO", "PRODUCTOS", "DESCRIPCION"), 37, " ", Util.SIDE_RIGHT ) %> <%= Util.getFixedString( b.getValue( "PRECIO_UNITARIO" ), 10, " ", Util.SIDE_LEFT) %> <%= Util.getFixedString( b.getValue( "TOTAL" ), 10, " ", Util.SIDE_LEFT) %>
<%
}
%>
   14
   12 U 0    PB003    AMETRALLADORA DE 3 METROS                   5.00     60.00
   18
   19 U 0    PB004    AMETRALLADORA DE 3 METROS PLUS              5.00     60.00
   20
   21
   22
   23
   24
   25
   26
   27
   28
   29
   30
   31
   32  
   33
   34
   35
   36
   37
   38
   39                                                                        
   40
   41
   42
   43
   44
   45
   46
   47
   48
   49
   50
   51
   52
   53
   54
   55
   56                                                                       <%= Util.getFixedString( "Q. " + facturaBean.getValue("MONTO"), 13, " ", Util.SIDE_LEFT) %>