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
String id = request.getParameter( "id-cierre" );

ExtendedFieldsBaseMain ordenesMain = new ExtendedFieldsBaseMain( "ORDENES", 
		    new String[]{"ID_CLIENTE"},
			new int[]{ Constants.EXTENDED_TYPE_INTEGER } );


ExtendedFieldsBaseMain cuponesMain = new ExtendedFieldsBaseMain( "CUPONES_DE_DESCUENTO", 
	    new String[]{"MONTO"},
		new int[]{ Constants.EXTENDED_TYPE_DOUBLE } );


ExtendedFieldsBaseMain reporteMain = new ExtendedFieldsBaseMain( "PAGOS_ORDENES", 
		new String[]{"ID_ORDEN","FECHA","TIPO_PAGO","MONTO","NO_AUTORIZACION","NO_CHEQUE","ID_BANCO","ID_USUARIO","ID_CUPON"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DATE, 
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_DOUBLE,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_STRING,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER
		} );

ExtendedFieldsFilter filter = new ExtendedFieldsFilter( 
		new String[]{"ID_CIERRE"},
		new int[]{ ExtendedFieldsFilter.EQUALS},
		new int[]{ Constants.EXTENDED_TYPE_INTEGER}, 
		new String[]{ id }
		);


	ArrayList<ExtendedFieldsBean> list = reporteMain.getAllWithoutID(filter);
	
	ExtendedFieldsBaseMain cieres_caja = new ExtendedFieldsBaseMain( "CAJA_DETALLE", 
			new String[] { 
					"FECHA_APERTURA",
					"FECHA_CIERRE",
					"USUARIO_APERTURA",
					"USUARIO_CIERRE",
					"EFECTIVO_CIERRE",
					"TARJETA_CIERRE",
					"CREDITO_CIERRE",
					"CHEQUE_CIERRE",
					"CORRELATIVO_CIERRE"
		}	
			, new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_DATE,Constants.EXTENDED_TYPE_DOUBLE,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER } 
	);
	ExtendedFieldsBean cierre =  cieres_caja.get( Integer.valueOf( id  ));

	

%>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>
<table width="100%" style="text-align: left;">

	<tr>
		<th># Cierre</th>
		<th><%= cierre.getValue( "CORRELATIVO_CIERRE")  %></th>
	</tr>

	<tr>
		<th>Fecha Apertura</th>
		<th><%= cierre.getValue( "FECHA_APERTURA")  %></th>
	</tr>
	<tr>
		<th>Fecha Cierre</th>
		<th><%= cierre.getValue( "FECHA_CIERRE")  %></th>
	</tr>
	<tr>
		<th>Usuario Apertura</th>
		<th><%= cierre.getReferenced("USUARIO_APERTURA", "USUARIOS", "USUARIO") %></th>
	</tr>
	<tr>
		<th>Usuario Cierre</th>
		<th><%= cierre.getReferenced("USUARIO_CIERRE", "USUARIOS", "USUARIO") %></th>
	</tr>
	<tr>
		<th>Efectivo</th>
		<th><%= cierre.getValue( "EFECTIVO_CIERRE")  %></th>
	</tr>
	<tr>
		<th>Tarjeta</th>
		<th><%= cierre.getValue( "TARJETA_CIERRE")  %></th>
	</tr>
	<tr>
		<th>Cheque</th>
		<th><%= cierre.getValue( "CHEQUE_CIERRE")  %></th>
	</tr>
	<tr>
		<th>Cliente credito</th>
		<th><%= cierre.getValue( "CREDITO_CIERRE")  %></th>
	</tr>
	<tr>
		<td colspan="4">
			<table border="1" width="100%" >
				<thead>
                              <tr>
                              	  
                              	  <th>Id orden</th>
                                  <td>Nit</td>
								  <td>Cliente</td>
                                  <th>Fecha</th>
                                  <th>Usuario</th>
                                  <th>Autorizacion</th>
                                  <th>Cheque</th>
                                  <th>Banco</th>
                                  <th style="text-align:right">Subtotal</th>
                                  <th style="text-align:right">Descuento</th>
                                  <th style="text-align:right">Total</th>
                              </tr>
                </thead>
                <tbody>
                              <%
                              	double total =0;
                              	String lastTitle = "";
	                          	
                              	for( ExtendedFieldsBean us : list ){
                              		String id_orden  = us.getValue( "ID_ORDEN" );
                              		String fecha     = us.getValue( "FECHA" );
                              		String tipo_pago = us.getValue( "TIPO_PAGO" );
                              		String monto     = us.getValue( "MONTO" );
                              		String usuario     = us.getValue( "ID_USUARIO" );
                              		String no_auth   = us.getValue( "NO_AUTORIZACION" );
                              		String no_cheque = us.getValue( "NO_CHEQUE" );
                              		String banco  = us.getReferenced( "ID_BANCO", "BANCOS", "DESCRIPCION" );
                              		int id_cupon = -1;
                              		if( us.getValue( "ID_CUPON") != null ){
                              			try{
                              				id_cupon = Integer.valueOf( us.getValue( "ID_CUPON" ));
                              			} catch( Exception ignored ){
                              				id_cupon = -1;
                              			}
                              		} 
                              		String montoCupon = id_cupon > 0 ? cuponesMain.get( id_cupon ).getValue( "MONTO" ) : "0"; 
                              		
                              		double subtotal = Double.valueOf( monto ) + Double.valueOf( montoCupon );
                              		
                              		ExtendedFieldsBean orden = ordenesMain.get( Integer.valueOf( id_orden ) );
                              		String nit      = orden.getReferenced( "ID_CLIENTE", "CLIENTES", "NIT");
                              		String cliente  = orden.getReferenced( "ID_CLIENTE", "CLIENTES", "CONCAT( NOMBRES,' ',APELLIDOS)");
                              		
                              		
                              		if(  !lastTitle.equals( tipo_pago )) {
                              			lastTitle = tipo_pago;
                              			%>
                              			<tr><th><%= tipo_pago.toUpperCase() %></th></tr>
                              			
                              			<% 
                              		}
                              %>
                              <tr>
                              	  
                              	  <td><%= id_orden %></td>
								  
								  <td><%= nit %></td>
								  <td><%= cliente %></td>
								  
								  <td><%= fecha %></td>
								  
								  <td><%= usuario %></td>
								  <td><%= no_auth %></td>
								  <td><%= no_cheque %></td>
								  <td><%= banco %></td>
								  <td style="text-align:right"><%= Util.formatCurrencyWithNoRound( subtotal ) %></td>
								  <td style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf( montoCupon ))%></td>
								  <td style="text-align:right"><%= Util.formatCurrencyWithNoRound( Double.valueOf(  monto ))%></td>
                              </tr>
                              <%
                              total += Double.valueOf(  monto );
                              } %>
                              <tr><td>&nbsp;</td></tr>
                              <tr>
								  
								   <td></td>
								  <td></td>
								  <td></td>
								  <td></td>
								  <td></td>
								  <td></td>
								  <td></td>
								  <td></td>
								  <td></td>
								  <td style="text-align:right"><B>Total</B></td>
								  <th style="text-align:right"><b><%= Util.formatCurrencyWithNoRound( total )%></b></th>
                              </tr>
                              </tbody>
                
			</table>
		</td>
	</tr>
</table>
</body>
</html>
