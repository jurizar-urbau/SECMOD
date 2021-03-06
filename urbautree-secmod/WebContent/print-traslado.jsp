<%@page import="java.util.Date"%>
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
<%
boolean envio = !"transito".equals( request.getParameter( "from" ) );

%>
<script>
	function regresar(){
		<%
		if( envio ){
		%>
		location.replace( "traslado-bodega.jsp" );
		<%
		} else {
		%>
		location.replace( "traslado-transito.jsp" );
		<% 
		}
		%>
	}
</script>
<style>
	@page { size: auto;  margin: 10mm; }

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
	.avoidBreak { 
	    page-break-inside:avoid;
	}
	</style>
<%

ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "TRASLADOS_HEADER", 
		new String[]{"BODEGA_ORIGEN","BODEGA_DESTINO","FECHA","ESTADO","USUARIO","TRANSID","DESTINATARIO","CORRELATIVO"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER, 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DATE,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER
			
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


ArrayList<ExtendedFieldsBean> results = um.getAll( 
		new ExtendedFieldsFilter(
				new String[]{"TRANSID"},
				new int[]{ExtendedFieldsFilter.EQUALS}, 
				new int[]{Constants.EXTENDED_TYPE_STRING},
				new String[]{ request.getParameter( "id" )})
		);
ExtendedFieldsBean bean = null;
	if( results.size() > 0  ){
		bean = results.get( 0 );
	}
BodegasMain bodegasMain = new BodegasMain();
UsuariosMain usuariosMain = new UsuariosMain();
BodegaBean bodegaOrigen = bodegasMain.getBodega( bean.getValueAsInt( "BODEGA_ORIGEN" ) );
BodegaBean bodegaDestino = bodegasMain.getBodega( bean.getValueAsInt( "BODEGA_DESTINO" ) );
UsuarioBean usuarioBean = usuariosMain.get( bean.getValueAsInt( "USUARIO" ));
UsuarioBean usuarioDestinatarioBean =  null;

if( !envio ){
	usuarioDestinatarioBean = usuariosMain.get( bean.getValueAsInt( "DESTINATARIO" ));
}


	

%>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><br/>Por: <%= loggedUser.getNombre() %></h4>
<table width="100%" style="text-align: left;">
<%
	if( envio ){
%>
	<tr>
		<td colspan="2"><h1>Traslado - Envio</h1></td><td></td><td width="70%">&nbsp;</td>
	</tr>
	<%
	} else {
		%>
	<tr>
		<td colspan="2" ><h1>Traslado - Recibo</h1></td><td></td><td width="70%">&nbsp;</td>
	</tr>		
		<%
	}
	%>

	<tr>
		<th>Correlativo</th><td><%= bean.getValue( "CORRELATIVO" ) %></td>
	</tr>
	<tr>
		<th>Bodega Origen</th><td><%= bodegaOrigen.getId() + " " + bodegaOrigen.getNombre() %></td>
	</tr>
	<tr>
		<th>Bodega Destino</th><td><%= bodegaDestino.getId() + " " + bodegaDestino.getNombre() %></td>
	</tr>
	<tr>
		<th>Remitente</th><td><%= usuarioBean.getNombre().toUpperCase() %></td>
	</tr>
	<%
		if( !envio ){
	%>
	<tr>
		<th>Destinatario</th><td><%= usuarioDestinatarioBean.getNombre().toUpperCase() %></td>
	</tr>
	<% } %>
	<tr>
		<th>Fecha</th><td><%= bean.getValue( "FECHA" ) %></td>
	</tr>
	
	<tr>
		<td colspan="4"><hr/>
			<table border="0" width="100%" >
				<div class="avoidBreak">
				<tr>
					<th>C&oacute;digo</th><th>Descripcion</th><th>Unidades</th><th>Packing</th><th>Total</th>
				</tr>
				</div>
				
				<%
					ExtendedFieldsFilter filter = new ExtendedFieldsFilter(
							new String[]{"ID_TRASLADO"},
							new int[]{ ExtendedFieldsFilter.EQUALS }, 
							new int[]{ Constants.EXTENDED_TYPE_STRING},
							new String[]{ String.valueOf( bean.getId() ) } );
					ArrayList<ExtendedFieldsBean> details = dm.getAll( filter );
					for( ExtendedFieldsBean b : details ){
						ExtendedFieldsBean producto = pm.get( b.getValueAsInt( "PRODUCTO" ));
					%>
					<div class="avoidBreak">
					<tr>
						<td><%= producto.getValue( "CODIGO" ) %></td>
						<td><%= producto.getValue( "DESCRIPCION" )%></td>
						<td><%= b.getValue( "UNIDADES" ) %></td>
						<td><%= b.getValue( "PACKING" ) %></td>
						<td><%= b.getValueAsInt("UNIDADES") * b.getValueAsInt( "PACKING" ) %></td>
					</tr>
					</div>
				<% } %>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
