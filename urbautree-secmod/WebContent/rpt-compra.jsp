<%@page import="java.util.Date"%>
<%@page import="com.urbau.misc.Util"%>
<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.beans.TwoFieldsBean"%>
<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="fragment/validator.jsp"%>
<%
String id = request.getParameter( "id" );


ExtendedFieldsBaseMain headMain = new ExtendedFieldsBaseMain( "COMPRAS", 
		new String[] { 
				"FECHA",
				"ID_PROVEEDOR",
				"ID_ORDEN_DE_COMPRA",
				"TIPO_DE_PAGO",
				"SUBTOTAL",
				"DESCUENTO",
				"TOTAL",
				"CHEQUE_REF",
				"NUMERO_DE_COMPRA"
	}	
		, new int[]{ 
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
	} 
);
ExtendedFieldsBean head = headMain.get( Integer.parseInt( id ));
head.printValues();
ExtendedFieldsBaseMain detailMain = new ExtendedFieldsBaseMain( "COMPRAS_DETALLE", 
		new String[] { 
				"ID_PRODUCTO","UNIDADES","COSTO","SUBTOTAL"
	}	
		, new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE
	} 
);


ArrayList<ExtendedFieldsBean> list = detailMain.getAll( new ExtendedFieldsFilter( new String[]{"ID_COMPRA"}, new int[]{ ExtendedFieldsFilter.EQUALS}, new int[]{ Constants.EXTENDED_TYPE_INTEGER}, new String[]{ String.valueOf( head.getId())}));



ExtendedFieldsBaseMain cargaMain = new ExtendedFieldsBaseMain( "CARGAS_BODEGA", 
		new String[] { 
				"BODEGA"
	}, new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER
	} 
);

ExtendedFieldsBean cargaBean = cargaMain.get( head.getValueAsInt( "ID_ORDEN_DE_COMPRA" ) );




%>
<script>
	function regresar(){
		<% if( null != request.getParameter("referer") ){ %>
			location.replace( "<%= request.getParameter("referer") %>?id-proveedor=<%= request.getParameter("id-proveedor")%>" );
		<% } else { %>
			location.replace( "proveedores-compras.jsp?id-proveedor=<%= request.getParameter("id-proveedor")%>" );	
		<% } %>
	}
</script>
<style>
	@page { size: auto;  margin: 5mm; }

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
	body{
		padding: 25px;
		
	}
	</style>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>

<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><br>POR: <%= loggedUser.getNombre() %></h4>
<h1>VOLCANCITO</h1>
<h2>
	REPORTE DE COMPRA
</h2>
<table>
	<tr>
		<td><b>ID ORDEN DE COMPRA</b></td><td>:</td><td><%= head.getValue( "ID_ORDEN_DE_COMPRA") %></td>
	</tr>
	<tr>
		<td><b>FECHA</b></td><td>:</td><td><%= head.getValue( "FECHA" ) %></td>
	</tr>
	<tr>
		<td><b>PROVEEDOR</b></td><td>:</td><td><%= head.getReferenced( "ID_PROVEEDOR", "PROVEEDORES", "NOMBRE") %></td>
	</tr>
	<tr>
		<td><b>BODEGA</b></td><td>:</td><td> <%= cargaBean.getValue("BODEGA") + " " + cargaBean.getReferenced( "BODEGA", "BODEGAS", "NOMBRE" ) %></td>
	</tr>
	
	<tr>
		<td><b>TIPO DE PAGO</b></td><td>:</td><td><%= head.getValue( "TIPO_DE_PAGO" ) %></td>
	</tr>
	<tr>
		<td><b>SUBTOTAL</b></td><td>:</td><td><%= head.getValue( "SUBTOTAL" ) %></td>
	</tr>
	<tr>
		<td><b>DESCUENTO</b></td><td>:</td><td><%= head.getValue( "DESCUENTO" ) %></td>
	</tr>
	<tr>
		<td><b>TOTAL</b></td><td>:</td><td><%= head.getValue( "TOTAL" ) %></td>
	</tr>
	<tr>
		<td><b>REFERENCIA CHEQUE</b></td><td>:</td><td><%= head.getValue( "CHEQUE_REF" ) %></td>
	</tr>
	<tr>
		<td><b>NUMERO DE COMPRA</b></td><td>:</td><td><%= head.getValue( "NUMERO_DE_COMPRA" ) %></td>
	</tr>
</table>
<hr>	
<table width="100%" style="text-align: left;">
	                  	  	 <thead> 
                              <tr>
                              	  <th>C&Oacute;DIGO PRODUCTO</th>
                              	  <th>DESCRIPCI&Oacute;N PRODUCTO</th>
                                  <th style="text-align: right;">UNIDADES</th>
                                  <th style="text-align: right;">COSTO</th>
                                  <th style="text-align: right;">SUBTOTAL</th>
                              </tr>
                             </thead> 
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              	
                              %>
                              <tr>
                              	  <td><%= us.getReferenced( "ID_PRODUCTO" , "PRODUCTOS", "CODIGO") %></td>
                              	  <td><%= us.getReferenced( "ID_PRODUCTO" , "PRODUCTOS", "DESCRIPCION") %></td>
								  <td style="text-align: right;"><%= us.getValue( "UNIDADES" ) %></td>
								  <td style="text-align: right;"><%= us.getValue( "COSTO" ) %></td>
								  <td style="text-align: right;"><%= us.getValue( "SUBTOTAL" ) %></td>
								  
								 
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
		</body>
</html>
