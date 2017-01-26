<%@page import="com.urbau.beans.ProveedorBean"%>
<%@page import="com.urbau.feeders.ProveedoresMain"%>
<%@page import="java.util.Date"%>
<%@page import="com.urbau.misc.Util"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="fragment/validator.jsp"%>
<%
	ProveedoresMain proveedores_main = new ProveedoresMain();
				
	ArrayList<ProveedorBean> list = proveedores_main.get("",-1);
	
	%>
	
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
	<script>
		function regresar(){
			location.replace( "home.jsp" );
		}
	</script>
		
</head>
<body>
<button onclick="regresar()" class="no-print">Regresar</button>
<button onclick="window.print()" class="no-print">Imprimir</button>

<h4 style="text-align: right;"><b>GENERADO: &nbsp;</b><%= Util.getDateStringDMYHM( new Date() ) %><b>&nbsp;por&nbsp;</b><%= loggedUser.getNombre() %></h4>
<h1>VOLCANCITO</h1>
<h2>
	BASE DE DATOS DE PROVEEDORES
</h2>
<hr>	
<table width="100%" style="text-align: left;">
          				  
	                  	  	  <thead>
                              <tr>
                              		  <th>Nit</th>
	                                  <th>Nombre</th>
	                                  <th>Raz&oacute;n Social</th>
	                                  <th>Contacto</th>
	                                  <th>Tel&eacute;fono</th>
	                                  <th>Correo</th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              
                              	for( ProveedorBean us : list ){
                              %>
                              <tr>
                                  <td><%= us.getNit() %></td>
                                  <td><%= us.getNombre() %></td>
                                  <td><%= us.getRazonSocial() %></td>
                                  <td><%= us.getContacto() %></td>
                                  <td><%= us.getTelefono() %></td>
                                  <td><%= us.getEmail() %></td>
                              </tr>
                              <% } %>
                              </tbody>
                          </table>
		</body>
</html>
