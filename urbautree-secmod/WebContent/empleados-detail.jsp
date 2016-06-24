<%@page import="com.urbau.beans.KeyValueBean"%>
<%@page import="com.urbau.feeders.TwoFieldsBaseMain"%>
<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.misc.EncryptUtils"%>
<%@page import="java.util.ArrayList"%>
      
<%
	TwoFieldsBaseMain puestosMain = new TwoFieldsBaseMain("PUESTOS");
	TwoFieldsBaseMain tipoPagoMain = new TwoFieldsBaseMain("TIPOS_DE_PAGO");
	TwoFieldsBaseMain bancosMain = new TwoFieldsBaseMain("BANCOS");
	TwoFieldsBaseMain municipiosMain = new TwoFieldsBaseMain("MUNICIPIOS");
	
	ArrayList<KeyValueBean> puestosList = puestosMain.getForCombo();
	ArrayList<KeyValueBean> tiposPagoList = tipoPagoMain.getForCombo();
	ArrayList<KeyValueBean> bancosList = bancosMain.getForCombo();
	ArrayList<KeyValueBean> municipiosList = municipiosMain.getForCombo();
	
      	if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
      		/* TwoFieldsBaseMain tw = new TwoFieldsBaseMain( "PAISES" );
      		ArrayList<KeyValueBean> paisesList = tw.getForCombo(); */
      		
      		ExtendedFieldsBaseMain rm = new ExtendedFieldsBaseMain( "EMPLEADOS", 
      				new String[]{"NOMBRES","APELLIDOS","DIRECCION","TELEFONO","NUMERO_CEDULA","NIT","ESTADO_CIVIL","SEXO","FECHA_DE_NACIMIENTO","HIJOS","MUNICIPIO",
      				"PUESTO","TIPO_DE_PAGO","NUMERO_CUENTA","SUELDO_BASE","BONIFICACION","INCENTIVO",
      				"FECHA_DE_INGRESO",
      				"FECHA_DE_EGRESO","PORCENTAJE_AHORRO","CANTIDAD_DE_AHORRO","AHORRO","PAGA_IGSS","AFILIACION_IGSS","ESTADO","BANCO",
      				"DESCUENTO_FIJO","ES_TEMPORAL","ES_IMPRIMIBLE"
      		},
      				new int[]{ 
      				Constants.EXTENDED_TYPE_STRING, 
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_DATE,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_DOUBLE,
      				Constants.EXTENDED_TYPE_DOUBLE,
      				Constants.EXTENDED_TYPE_DOUBLE,
      				Constants.EXTENDED_TYPE_DATE,
      				Constants.EXTENDED_TYPE_DATE,
      				Constants.EXTENDED_TYPE_DOUBLE,
      				Constants.EXTENDED_TYPE_DOUBLE,
      				Constants.EXTENDED_TYPE_DOUBLE,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_STRING,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_DOUBLE,
      				Constants.EXTENDED_TYPE_INTEGER,
      				Constants.EXTENDED_TYPE_INTEGER
      				} );
      		
      	
      	int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
      	ExtendedFieldsBean bean = rm.get( id );
      	String mode = request.getParameter( "mode" );
      
      %>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	</head>
   
   <body>
  <section id="container" >
      <!-- **********************************************************************************************************************************************************
      TOP BAR CONTENT & NOTIFICATIONS
      *********************************************************************************************************************************************************** -->
      <!--header start-->
      
      <header class="header black-bg">
      		<%@include file="fragment/header.jsp"%>        
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <%@include file="fragment/sidebar.jsp"%>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->
      <!--main content start-->
      
      <section id="main-content">
          <section class="wrapper site-min-height">
          
          	<h3><i class="fa fa-angle-right"></i> Detalle de empleado</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   		<h4 class="mb"><i class="fa fa-angle-left"></i><a href="empleados.jsp">&nbsp;Regresar</a> </h4>
          			   		<form class="form-horizontal style-form" id="form" name="form">
		                  	   	<input type="hidden" name="mode" id="mode"value="<%= request.getParameter("mode")%>"></input>
		                      	<input type="hidden" name="id" id="id" value="<%= request.getParameter("id")%>"></input>
		                      	<input type="hidden" name="tablename" id="tablename" value="<%= EncryptUtils.base64encode( "EMPLEADOS" ) %>"></input>
		                      	
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "NOMBRES" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "APELLIDOS" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "DIRECCION" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "TELEFONO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "NUMERO_CEDULA" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "NIT" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ESTADO_CIVIL" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "SEXO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "FECHA_DE_NACIMIENTO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "HIJOS" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "MUNICIPIO" ) %>"></input>
		                      	
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "PUESTO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "TIPO_DE_PAGO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "NUMERO_CUENTA" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "SUELDO_BASE" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "BONIFICACION" ) %>"></input>
		                        <input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "INCENTIVO" ) %>"></input>
		                      	
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "FECHA_DE_INGRESO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "FECHA_DE_EGRESO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "PORCENTAJE_AHORRO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "CANTIDAD_DE_AHORRO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "AHORRO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "PAGA_IGSS" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "AFILIACION_IGSS" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ESTADO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "BANCO" ) %>"></input>
		                      	
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "DESCUENTO_FIJO" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ES_TEMPORAL" ) %>"></input>
		                      	<input type="hidden" name="field_names" value="<%= EncryptUtils.base64encode( "ES_IMPRIMIBLE" ) %>"></input>
		                      	
		                      	
		                      	
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DATE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DATE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DATE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_STRING )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_DOUBLE )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	<input type="hidden" name="data_types" value="<%= EncryptUtils.base64encode( String.valueOf( Constants.EXTENDED_TYPE_INTEGER )) %>"></input>
		                      	
								
		                      	<div class="content-panel">
		                      	<hr/>
		                      	<h4><button href="#tab1" class="btn btn-default" data-toggle="collapse">General</button></h4>
		                      	<div id="tab1" class="collapse form-panel">
		                      		<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Nombres</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="NOMBRES" id="NOMBRES" value="<%= bean.getValue( "NOMBRES" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="NOMBRES" id="NOMBRES" disabled value="<%= bean.getValue( "NOMBRES" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Apellidos</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="APELLIDOS" id="APELLIDOS" value="<%= bean.getValue( "APELLIDOS" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="APELLIDOS" id="APELLIDOS" disabled value="<%= bean.getValue( "APELLIDOS" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Direcci&oacute;n</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="DIRECCION" id="DIRECCION" value="<%= bean.getValue( "DIRECCION" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="DIRECCION" id="DIRECCION" disabled value="<%= bean.getValue( "DIRECCION" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Tel&eacute;fono</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="TELEFONO" id="TELEFONO" value="<%= bean.getValue( "TELEFONO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="TELEFONO" id="TELEFONO" disabled value="<%= bean.getValue( "TELEFONO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">N&uacute;mero de c&eacute;dula</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="NUMERO_CEDULA" id="NUMERO_CEDULA" value="<%= bean.getValue( "NUMERO_CEDULA" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="NUMERO_CEDULA" id="NUMERO_CEDULA" disabled value="<%= bean.getValue( "NUMERO_CEDULA" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">NIT</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="NIT" id="NIT" value="<%= bean.getValue( "NIT" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="NIT" id="NIT" disabled value="<%= bean.getValue( "NIT" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Estado civil</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	   
		                              		<select class="form-control" name="ESTADO_CIVIL" id="ESTADO_CIVIL">
		                              			<option value="C">Casado</option>
		                              			<option value="S">Soltero</option>
		                              		</select>                       		
			                          			                          	                          
			                          	<%}else{%>
			                          		<select class="form-control" name="ESTADO_CIVIL" id="ESTADO_CIVIL" disabled>
		                              			<option value="C">Casado</option>
		                              			<option value="S">Soltero</option>
		                              		</select>                       		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Sexo</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	   
		                              		<select class="form-control" name="SEXO" id="SEXO">
		                              			<option value="M">Masculino</option>
		                              			<option value="F">Femenino</option>
		                              		</select>                       		
			                          			                          	                          
			                          	<%}else{%>
			                          		<select class="form-control" name="SEXO" id="SEXO" disabled>
		                              			<option value="M">Masculino</option>
		                              			<option value="F">Femenino</option>
		                              		</select>                       		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Fecha nacimiento</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="date" class="form-control" name="FECHA_DE_NACIMIENTO" id="FECHA_DE_NACIMIENTO" value="<%= bean.getValue( "FECHA_DE_NACIMIENTO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="date" class="form-control" name="FECHA_DE_NACIMIENTO" id="FECHA_DE_NACIMIENTO" disabled value="<%= bean.getValue( "FECHA_DE_NACIMIENTO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Hijos</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="HIJOS" id="HIJOS" value="<%= bean.getValue( "HIJOS" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="HIJOS" id="HIJOS" disabled value="<%= bean.getValue( "HIJOS" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Municipio</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="MUNICIPIO" id="MUNICIPIO">
		                              			<%
		                              				for( KeyValueBean keyValue : municipiosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "MUNICIPIO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="MUNICIPIO" id="MUNICIPIO" disabled>
		                              			<%
		                              				for( KeyValueBean keyValue : municipiosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "MUNICIPIO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Estado</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	   
		                              		<select class="form-control" name="ESTADO" id="ESTADO">
		                              			<option value="0" <%= "0".equals(  bean.getValue( "ESTADO" )) ? "SELECTED": ""  %> >INACTIVO</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "ESTADO" )) ? "SELECTED": ""  %>>ACTIVO</option>
		                              		</select>                       		
			                          			                          	                          
			                          	<%}else{%>
			                          		<select class="form-control" name="PAGA_IGSS" id="PAGA_IGSS" disabled>
		                              			<option value="0" <%= "0".equals(  bean.getValue( "PAGA_IGSS" )) ? "SELECTED": ""  %> >No</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "PAGA_IGSS" )) ? "SELECTED": ""  %>>Si</option>
		                              		</select>                       		
			                          	<%}%>   
		                              	</div>
		                          	</div>
	                          	</div>
	                          	</div>
	                          	
	                          	
	                          	<div class="content-panel">
		                      	<hr/>
		                      	<h4><button href="#tab2" class="btn btn-default" data-toggle="collapse">Detalles</button></h4>
		                      	
		                      	<div id="tab2" class="collapse form-panel">
	                          	
	                          		<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Puesto</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="PUESTO" id="PUESTO">
		                              			<%
		                              				for( KeyValueBean keyValue : puestosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "PUESTO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="PUESTO" id="PUESTO" disabled>
		                              			<%
		                              				for( KeyValueBean keyValue : puestosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "PUESTO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Tipo de Pago</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="TIPO_DE_PAGO" id="TIPO_DE_PAGO">
		                              			<%
		                              				for( KeyValueBean keyValue : tiposPagoList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "TIPO_DE_PAGO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="TIPO_DE_PAGO" id="TIPO_DE_PAGO" disabled>
		                              			<%
		                              				for( KeyValueBean keyValue : tiposPagoList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "TIPO_DE_PAGO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Banco</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	
		                              		<select class="form-control" name="BANCO" id="BANCO">
		                              			<%
		                              				for( KeyValueBean keyValue : bancosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "BANCO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>                          		
			                          	<%}else{%>
			                          		<select class="form-control" name="BANCO" id="BANCO" disabled>
		                              			<%
		                              				for( KeyValueBean keyValue : bancosList ){
		                              			%> 
		                              				<option value="<%= keyValue.getId() %>" <%= bean.getValue( "BANCO" ).equals( String.valueOf( keyValue.getId()) ) ? "SELECTED" : ""%>><%= keyValue.getDescripcion() %></option>
		                              			<% } %>
		                              		</select>	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Numero de Cuenta</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="NUMERO_CUENTA" id="NUMERO_CUENTA" value="<%= bean.getValue( "NUMERO_CUENTA" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="NUMERO_CUENTA" id="NUMERO_CUENTA" disabled value="<%= bean.getValue( "NUMERO_CUENTA" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Sueldo Base</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="SUELDO_BASE" id="SUELDO_BASE" value="<%= bean.getValue( "SUELDO_BASE" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="SUELDO_BASE" id="SUELDO_BASE" disabled value="<%= bean.getValue( "SUELDO_BASE" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Bonificaci&oacute;n</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="BONIFICACION" id="BONIFICACION" value="<%= bean.getValue( "BONIFICACION" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="BONIFICACION" id="BONIFICACION" disabled value="<%= bean.getValue( "BONIFICACION" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Incentivo</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>
		                              		<input type="number" step="0.01" min="0"  class="form-control" name="INCENTIVO" id="INCENTIVO" value="<%= bean.getValue( "INCENTIVO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="number" step="0.01" min="0"  class="form-control" name="INCENTIVO" id="INCENTIVO" disabled value="<%= bean.getValue( "INCENTIVO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Fecha de Ingreso</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="date" class="form-control" name="FECHA_DE_INGRESO" id="FECHA_DE_INGRESO" value="<%= bean.getValue( "FECHA_DE_INGRESO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="date" class="form-control" name="FECHA_DE_INGRESO" id="FECHA_DE_INGRESO" disabled value="<%= bean.getValue( "FECHA_DE_INGRESO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Fecha de Egreso</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="date" class="form-control" name="FECHA_DE_EGRESO" id="FECHA_DE_EGRESO" value="<%= "add".equals( mode ) ? "null" : bean.getValue( "FECHA_DE_EGRESO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="date" class="form-control" name="FECHA_DE_EGRESO" id="FECHA_DE_EGRESO" disabled value="<%= bean.getValue( "FECHA_DE_EGRESO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Porcentaje Ahorro</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="PORCENTAJE_AHORRO" id="PORCENTAJE_AHORRO" value="<%= bean.getValue( "PORCENTAJE_AHORRO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="PORCENTAJE_AHORRO" id="PORCENTAJE_AHORRO" disabled value="<%= bean.getValue( "PORCENTAJE_AHORRO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Cantidad de Ahorro</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="CANTIDAD_DE_AHORRO" id="CANTIDAD_DE_AHORRO" value="<%= bean.getValue( "CANTIDAD_DE_AHORRO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="CANTIDAD_DE_AHORRO" id="CANTIDAD_DE_AHORRO" disabled value="<%= bean.getValue( "CANTIDAD_DE_AHORRO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Ahorro</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="AHORRO" id="AHORRO" value="<%= bean.getValue( "AHORRO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="AHORRO" id="AHORRO" disabled value="<%= bean.getValue( "AHORRO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Paga Igss?</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	   
		                              		<select class="form-control" name="PAGA_IGSS" id="PAGA_IGSS">
		                              			<option value="0" <%= "0".equals(  bean.getValue( "PAGA_IGSS" )) ? "SELECTED": ""  %> >No</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "PAGA_IGSS" )) ? "SELECTED": ""  %>>Si</option>
		                              		</select>                       		
			                          			                          	                          
			                          	<%}else{%>
			                          		<select class="form-control" name="PAGA_IGSS" id="PAGA_IGSS" disabled>
		                              			<option value="0" <%= "0".equals(  bean.getValue( "PAGA_IGSS" )) ? "SELECTED": ""  %> >No</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "PAGA_IGSS" )) ? "SELECTED": ""  %>>Si</option>
		                              		</select>                       		
			                          	<%}%>   
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Afiliaci&oacute;n Igss</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="AFILIACION_IGSS" id="AFILIACION_IGSS" value="<%= bean.getValue( "AFILIACION_IGSS" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="AFILIACION_IGSS" id="AFILIACION_IGSS" disabled value="<%= bean.getValue( "AFILIACION_IGSS" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Descuento Fijo</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	                          		
			                          		<input type="text" class="form-control" name="DESCUENTO_FIJO" id="DESCUENTO_FIJO" value="<%= bean.getValue( "DESCUENTO_FIJO" ) %>">	                          	                          
			                          	<%}else{%>
			                          		<input type="text" class="form-control" name="DESCUENTO_FIJO" id="DESCUENTO_FIJO" disabled value="<%= bean.getValue( "DESCUENTO_FIJO" )  %>">	                          		
			                          	<%}%>   	                                  
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Es temporal?</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	   
		                              		<select class="form-control" name="ES_TEMPORAL" id="ES_TEMPORAL">
		                              			<option value="0" <%= "0".equals(  bean.getValue( "ES_TEMPORAL" )) ? "SELECTED": ""  %> >No</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "ES_TEMPORAL" )) ? "SELECTED": ""  %>>Si</option>
		                              		</select>                       		
			                          			                          	                          
			                          	<%}else{%>
			                          		<select class="form-control" name="ES_TEMPORAL" id="ES_TEMPORAL" disabled>
		                              			<option value="0" <%= "0".equals(  bean.getValue( "ES_TEMPORAL" )) ? "SELECTED": ""  %> >No</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "ES_TEMPORAL" )) ? "SELECTED": ""  %>>Si</option>
		                              		</select>                       		
			                          	<%}%>   
		                              	</div>
		                          	</div>
		                          	<div class="form-group">
		                            	<label class="col-sm-2 col-sm-2 control-label">Es imprimible?</label> 
		                              	<div class="col-sm-10">
		                              	<%if( "edit".equals( mode ) || "add".equals( mode ) ){%>	   
		                              		<select class="form-control" name="ES_IMPRIMIBLE" id="ES_IMPRIMIBLE">
		                              			<option value="0" <%= "0".equals(  bean.getValue( "ES_IMPRIMIBLE" )) ? "SELECTED": ""  %> >No</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "ES_IMPRIMIBLE" )) ? "SELECTED": ""  %>>Si</option>
		                              		</select>                       		
			                          			                          	                          
			                          	<%}else{%>
			                          		<select class="form-control" name="ES_IMPRIMIBLE" id="ES_IMPRIMIBLE" disabled>
		                              			<option value="0" <%= "0".equals(  bean.getValue( "ES_IMPRIMIBLE" )) ? "SELECTED": ""  %> >No</option>
		                              			<option value="1" <%= "1".equals(  bean.getValue( "ES_IMPRIMIBLE" )) ? "SELECTED": ""  %>>Si</option>
		                              		</select>                       		
			                          	<%}%>   
		                              	</div>
		                          	</div>
	                          	</div>
	                          	</div>
                          	</form>
                         </div>
                         <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('empleados.jsp')">Cancelar</button>
					     </div>                                                                                                      
                  </div>
          		</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
<script>
            $(document).ready(function(){
             $('#form').validate(
             {
              rules: {
                nombre: {
                  minlength: 2,
                  maxlength: 30,
                  required: true
                }
              },
              highlight: function(element) {
                $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
              },
              success: function(element) {
                element
                .closest('.form-group').removeClass('has-error').addClass('has-success');
              }
             });
            }); // end document.ready
            
            
            
           
        </script>
       
		<script>        	
        
        $(function() {
    		    	
    		$('#form').submit(function(e){
    			e.preventDefault();
    		});
    		
    		
    		$("#savebutton").click(function(){
    			    					
    			var form =$('#form');
    	     	$.ajax({
    	     		type:'POST',
    	 			url: './bin/ExtendedFields',
    	 			data: form.serialize(),
    	 			
    		        success: function(msg){		        	
    		        	alert(msg);
    		            location.replace( "empleados.jsp" );
    		        },
    	 			error: function(jqXHR, textStatus, errorThrown){
    	 				console.log("ERROR srtatus: ", textStatus);
    	 				console.log("ERROR errorThrown: ", errorThrown);
    	 				alert("Se prudujo un error al hacer la operacion");	
    	 			}
    		            		        
    	       });
    	     	
    	     	return false;
    	 	});
    				 
    		
    		var mode = getUrlParameter('mode');    		
    		if(mode === "remove"){
    			$("#rolSelect").attr('disabled','disabled');
    			$("#activo").attr('disabled','disabled');
    			
    			$("#savebutton").removeClass("btn btn-success");
    			$("#savebutton").addClass("btn btn-danger");
    			$("#savebutton").html("Borrar");						
    		}else if(mode === "view"){
    			$("#rolSelect").attr('disabled','disabled');
    			$("#activo").attr('disabled','disabled');
    			$("#savebutton").hide();    			    	    	
    			
    		}else if(mode === "add"){    			
    			$("#nombresapellidos").attr('value', ' ');
    			$("#clave").attr('value', '');    			
    		}
    		
    		// select option by id 
    		var idRol = $("#idRol").val();    		    		    	
    		if(idRol){
    			$("#rolSelect option[value="+idRol+"]").attr('selected','selected');    			
    		}
    		
    		
    		
    		
   		}); // end function 
    		 
    		 
		function getUrlParameter(sParam){
   			
		    var sPageURL = window.location.search.substring(1);
		    var sURLVariables = sPageURL.split('&');
		    
		    for (var i = 0; i < sURLVariables.length; i++) {
		    	
		        var sParameterName = sURLVariables[i].split('=');
		        if (sParameterName[0] == sParam) {
		             return sParameterName[1];
		        }
		    }
	    } // end getUrlParameter 
        
            
           
	</script>
        
  </body>
</html>
<% 		
} else {
%>
		<p>No se especifico un id.</p>
<%
 } 
%>