<%@page import="com.urbau.beans.ExtendedFieldsBean"%>
<%@page import="com.urbau.misc.ExtendedFieldsFilter"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.feeders.ExtendedFieldsBaseMain"%>
<%@page import="com.urbau.beans.PuntoDeVentaBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.PuntosDeVentasMain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
  	<link rel="shortcut icon" href="ub.ico" />
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Dashboard">
    <meta name="keyword" content="Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
	

    <title>Volcancito - Inicio de sesi&oacute;n</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <!--external css-->
    <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
        
    <!-- Custom styles for this template -->
    <link href="assets/css/style.css" rel="stylesheet">
    <link href="assets/css/style-responsive.css" rel="stylesheet">
    
    

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

      <!-- **********************************************************************************************************************************************************
      MAIN CONTENT
      *********************************************************************************************************************************************************** -->

<script>
	function reloadPage(){
		document.loginform.action = "index.jsp";
		document.loginform.submit();
	}
</script>
	  <div id="login-page">
	  	<div class="container">
	  	
		      <form class="form-login" action="bin/VerifyUser?path=../home.jsp" method="POST" name="loginform" id="loginform">
		        <h2 class="form-login-heading"><img src="assets/img/logoytel.png" width="50%"><br>Inicio de sesi&oacute;n</h2>
		        <%
		        	String puntodeventa = request.getParameter( "punto_de_venta" );
		        	String cajapuntodeventa = request.getParameter( "caja_punto_de_venta" );
		        	
		        	ArrayList<ExtendedFieldsBean> list = new ArrayList<ExtendedFieldsBean>();
		        	
		        	ExtendedFieldsBaseMain cajas_punto = new ExtendedFieldsBaseMain( "CAJA_PUNTO_VENTA", 
		        			new String[] { "ID_PUNTO_VENTA","DESCRIPCION" }	
		        			, new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_STRING } );
		        	
		        	ExtendedFieldsFilter filter = new ExtendedFieldsFilter( 
		        			new String[]{"ID_PUNTO_VENTA"},
		        			new int[]{ ExtendedFieldsFilter.EQUALS}, 
		        			new int[]{ Constants.EXTENDED_TYPE_INTEGER}, 
		        			new String[]{ puntodeventa });
		        	
					if( puntodeventa != null && !"null".equals( puntodeventa )){
						list = cajas_punto.getAll( filter );
					}
					
		        	
		        	
		        	
		        	session.removeAttribute( "loggedUser" );
		        	String[] messages = (String[])session.getAttribute( "messages" );
		        	if( messages != null && messages.length > 0 ){
		        		for( String message: messages ){
		        			%>
		        			<div class="alert alert-danger"><b><%= message %></b></div>
		        			<% 
		        		}
		        	}
		        	session.removeAttribute( "messages" );
		        	PuntosDeVentasMain pdvm = new PuntosDeVentasMain();
		        	ArrayList<PuntoDeVentaBean> pdvList = pdvm.getAll();
		        	
		        	
		        	
		        	
		        %>
		          
		        <div class="login-wrap">
		        
		        	
		        	<select class="form-control" name="punto_de_venta" onchange="reloadPage()">
		        		<option value="null">Seleccione un punto de venta</option>
		        		<%
		        			for( PuntoDeVentaBean pdv : pdvList ){
		        		%>
		        			<option value="<%= pdv.getId() %>"  <%= puntodeventa != null && puntodeventa.equals( String.valueOf( pdv.getId() ) ) ? "SELECTED" : "" %>   ><%= pdv.getNombre() %></option>
		        		<%
		        		}
		        		%>
		        	</select>
		        	<br>
		        	<% if( puntodeventa != null && !"null".equals( puntodeventa ) ) { %>
		        	<select class="form-control" name="caja_punto_de_venta">
		        		<option value="null">Seleccione una caja</option>
		        		<%
		        			for( ExtendedFieldsBean pdv : list ){
		        		%>
		        			<option value="<%= pdv.getId() %>"><%= pdv.getValue("DESCRIPCION") %></option>
		        		<%
		        		}
		        		%>
		        	</select>
		        	<% }  %>
		        	<br>
		            <input type="text" class="form-control" name="user" placeholder="Usuario" autofocus>
		            <br>
		            <input type="password" class="form-control" placeholder="Clave" name="password">
		            
		            
		            <label class="checkbox">
		                <span class="pull-right">
		                    <a data-toggle="modal" href="login.html#myModal"> Olvidó su clave?</a>
		
		                </span>
		            </label>
		            <button class="btn btn-theme btn-block" href="index.html" type="submit"><i class="fa fa-lock"></i> ENTRAR</button>
		         </div>
		
		          <!-- Modal -->
		          <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
		              <div class="modal-dialog">
		                  <div class="modal-content">
		                      <div class="modal-header">
		                          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                          <h4 class="modal-title">Olvid&oacute; su clave ?</h4>
		                      </div>
		                      <div class="modal-body">
		                          <p>Ingrese su direcci&oacute;n de correo electr&oacute;nico para generar una nueva clave.</p>
		                          <input type="text" name="email" placeholder="Correo electr&oacute;nico" autocomplete="off" class="form-control placeholder-no-fix">
		
		                      </div>
		                      <div class="modal-footer">
		                          <button data-dismiss="modal" class="btn btn-default" type="button">Cancelar</button>
		                          <button class="btn btn-theme" type="button">Enviar</button>
		                      </div>
		                  </div>
		              </div>
		          </div>
		          <!-- modal -->
		           
		      </form>	  	
	  	
	  	</div>
	  </div>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!--BACKSTRETCH-->
    <!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
    <script type="text/javascript" src="assets/js/jquery.backstretch.min.js"></script>
    <script>
        $.backstretch("https://upload.wikimedia.org/wikipedia/commons/0/0b/Sparklers_moving_slow_shutter_speed.jpg", {speed: 500});
        //$.backstretch("assets/img/volcancitowall.jpg", {speed: 500});
    </script>


  </body>
</html>
