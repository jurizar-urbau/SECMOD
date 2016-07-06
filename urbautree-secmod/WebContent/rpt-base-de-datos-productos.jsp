<%@page import="com.urbau.beans.FamiliaBean"%>
<%@page import="com.urbau.feeders.FamiliasMain"%>
<%@page import="com.urbau.feeders.ProveedoresMain"%>
<%@page import="com.urbau.feeders.ExtendedFieldsOrderBy"%>
<%@page import="com.urbau.feeders.ProductosMain"%>
<%@page import="com.urbau.beans.BodegaBean"%>
<%@page import="com.urbau.feeders.BodegasMain"%>
<%@page import="com.urbau.beans.ProductoBean"%>
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
	ProductosMain productos_main     = new ProductosMain();
	ProveedoresMain proveedores_main = new ProveedoresMain();
	FamiliasMain fm                  = new FamiliasMain();
				
	ArrayList<ProductoBean> list = productos_main.get( "", -1 );
	
	boolean imagen = request.getParameter( "imagen" ) != null ? true : false;

	%>
	
<script>
	function regresar(){
		location.replace( "filter-rpt-base-de-datos-productos.jsp" );
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
	</style>
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>

<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><b>&nbsp;por&nbsp;</b><%= loggedUser.getNombre() %></h4>
<h1>VOLCANCITO</h1>
<h2>
	BASE DE DATOS DE PRODUCTOS
</h2>
<hr>	
<table width="100%" style="text-align: left;">
          				  
	                  	  	  <thead>
                              <tr>
                              		  <th>Codigo</th>
	                                  <th>Descripcion</th>
	                                  <th>Familia</th>
	                                  <th>Proveedor</th>
	                                  <th>Packings</th>
	                                  <th>Alias</th>
	                                  <th>Costo</th>
	                                  <th>Precio 1</th>
	                                  <th>Precio 2</th>
	                                  <th>Precio 3</th>
	                                  <th>Precio 4</th>
	                                  <% if( imagen ){ %>
	                                  <th>Imagen</th>
	                                  <% } %>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              
                              	for( ProductoBean us : list ){
                              		FamiliaBean familia = fm.get( us.getFamilia() );
                              		if ( familia == null ){
                              			familia = fm.getBlankBean();
                              		}
                              %>
                              <tr>
                                  <td><%= us.getCodigo() %></td>
                                  <td><%= us.getDescripcion() %></td>
                                  <td><%= familia.getNombre() %></td>
                                  <td><%= proveedores_main.get(us.getProveedor()).getNombre()  %></td>
                                  <td><%= Util.getPackings( String.valueOf( us.getId() ))  %></td>
                                  <td><%= Util.getAlias( String.valueOf( us.getId() ))  %></td>
                                  <td><%= Util.formatCurrencyWithNoRound( us.getPrecio() ) %></td>
                                  <td><%= Util.formatCurrency( us.compiled_1()) %></td>
                                  <td><%= Util.formatCurrency( us.compiled_2()) %></td>
                                  <td><%= Util.formatCurrency( us.compiled_3()) %></td>
                                  <td><%= Util.formatCurrency( us.compiled_4()) %></td>
                                  <% if( imagen ){ %>
                                  <td><img src="./bin/RenderImage?imagePath=<%= us.getImage_path() %>&w=40&type=smooth" width="40px"></td>
                                  <% } %>
                              </tr>
                              <% } %>
                              </tbody>
                          </table>
		</body>
</html>
