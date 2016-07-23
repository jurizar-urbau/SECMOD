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
<%
String id = request.getParameter( "id" );
ExtendedFieldsBaseMain planillaHead = new ExtendedFieldsBaseMain( "CARGAS_BODEGA_DETALLE", 
	new String[]{"ID_CARGA","ID_PRODUCTO","UNIDADES_PRODUCTO","UNITARIO","PACKING_SELECCIONADO"},
		new int[]{ 
		Constants.EXTENDED_TYPE_INTEGER, 
		Constants.EXTENDED_TYPE_INTEGER,
		Constants.EXTENDED_TYPE_INTEGER,
		Constants.EXTENDED_TYPE_INTEGER,
		Constants.EXTENDED_TYPE_INTEGER
	} );



ExtendedFieldsBaseMain cargaHead = new ExtendedFieldsBaseMain( "CARGAS_BODEGA", 
		new String[]{"BODEGA","FECHA","USUARIO","CORRELATIVO"},
			new int[]{ 
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_DATE,
			Constants.EXTENDED_TYPE_INTEGER,
			Constants.EXTENDED_TYPE_INTEGER
		} );

		ExtendedFieldsBean head = cargaHead.get( Integer.valueOf( id ));


ExtendedFieldsFilter filter = new ExtendedFieldsFilter( new String[]{ "ID_CARGA" }, 
		new int[]{ ExtendedFieldsFilter.EQUALS}, 
		new int[]{Constants.EXTENDED_TYPE_INTEGER}, 
		new String[]{ id });


		int from = 0;
		if( request.getParameter( "from" ) != null ){
	from = Integer.parseInt( request.getParameter( "from" ) );
		}
		ArrayList<ExtendedFieldsBean> list = planillaHead.getAll(filter);
		int total_regs = -1;
		
		if( list.size() > 0 ){
	total_regs = ((ExtendedFieldsBean)list.get( 0 )).getTotal_regs();
		}

%>
<script>
	function regresar(){
		<% if( null != request.getParameter("referer") ){ %>
			location.replace( "<%= request.getParameter("referer") %>" );
		<% } else { %>
			location.replace( "cargas-bodega.jsp" );	
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

<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %></h4>
<h1>VOLCANCITO</h1>
<h2>
	REPORTE DE CARGA A BODEGA
</h2>
<table>
	<tr>
		<td><b>CARGA</b></td><td>:</td><td><%= head.getValue( "CORRELATIVO") %></td>
	</tr>
	<tr>
		<td><b>BODEGA</b></td><td>:</td><td><%= head.getReferenced( "BODEGA", "BODEGAS", "NOMBRE") %></td>
	</tr>
	<tr>
		<td><b>FECHA</b></td><td>:</td><td><%= head.getValue( "FECHA" ) %></td>
	</tr>
	<tr>
		<td><b>USUARIO</b></td><td>:</td><td><%= head.getReferenced( "USUARIO" , "USUARIOS", "NOMBRE") %></td>
	</tr>
</table>
<hr>	
<table width="100%" style="text-align: left;">
	                  	  	 <thead> 
                              <tr>
                              	  <th>C&Oacute;DIGO</th>
                              	  <th>DESCRIPCI&Oacute;N</th>
                                  <th style="text-align: right;">UNIDADES</th>
                                  <th style="text-align: right;">PACKING</th>
                                  <th style="text-align: right;">TOTAL</th>
                              </tr>
                             </thead> 
                              <tbody>
                              <%
                              	for( ExtendedFieldsBean us : list ){
                              	
                              %>
                              <tr>
                              	  <td><%= us.getReferenced( "ID_PRODUCTO" , "PRODUCTOS", "CODIGO") %></td>
                              	  <td><%= us.getReferenced( "ID_PRODUCTO" , "PRODUCTOS", "DESCRIPCION") %></td>
								  <td style="text-align: right;"><%= us.getValue( "UNITARIO" ) %></td>
								  <td style="text-align: right;"><%= us.getValue( "PACKING_SELECCIONADO" ) %></td>
								  <td style="text-align: right;"><%= us.getValue( "UNIDADES_PRODUCTO" ) %></td>
								  
								 
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
		</body>
</html>
