<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.ClientBean	"%>
<%@page import="com.urbau.feeders.ClientMain"%>
<%@page import="com.urbau.feeders.RolesMain"%>
      
<%
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			ClientMain rm = new ClientMain();
			RolesMain roles_main = new RolesMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			ClientBean bean = rm.getItem(id);
			String cmd = "Nuevo Tipo de Llamada";
			String mode = request.getParameter( "mode" );
			String keyReadOnly = "readonly=\"readonly\"";
			String optionalReadOnly = "";
			String mandatoryReadOnly = "";
			String jsFunction = "save();";
			String validateUser = "";
			if( "edit".equals( mode ) ){
				cmd = "Editar Tipo de Llamda " + id;
				mandatoryReadOnly = keyReadOnly;
				jsFunction = "edit();";
			} else if( "view".equals( mode )){
				cmd = "Ver Tipo de Llamada " + id;
				mandatoryReadOnly = keyReadOnly;
				optionalReadOnly = keyReadOnly;
			} else if( "remove".equals(mode) ){
				cmd = "Eliminar Tipo de LLamada " + id;
				optionalReadOnly = keyReadOnly;
				mandatoryReadOnly = keyReadOnly;
				jsFunction = "deleteReg();";
			} else {
				validateUser = "onchange=\"validateUser(this.value)\"";
			}
			
					
%>  

<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<%@include file="fragment/nodeHeads.jsp"%>
	<!--  <script src="js/fesapp.js"> </script> --> 
	<script src="scripts/formApp.js"></script>
    <script src="scripts/MainController.js"></script>
	</head>
   <body>
   <%@include file="fragment/fbsection.jsp" %>
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
          <section class="wrapper site-min-height" >
          	<h3><i class="fa fa-angle-right"></i>  {{beanService.titleCrud}} </h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			<div class="form-panel" ng-app="formsApp" ng-controller="clientFormController as vm">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="typecalls.jsp">&nbsp;Regresar</a> </h4>
<%--                       <%@include file="fragment/forms/client-form.jsp" %> --%>
<%--                       <%@include file="fragment/forms/test.jsp" %>
 --%>
 					 <form  ng-submit="vm.onSubmit()" novalidate>
			            <formly-form model="vm.client" fields="vm.clientFields" form="vm.clientForm">
			                <button type="submit" class="btn btn-primary"ng-disabled="vm.clientForm.$invalid"  >Submit</button>
			            </formly-form>
			        </form>
                   </div>

                     
          		</div>
          	</div>
			
		</section><! --/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="fragment/footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
  
	<%@include file="fragment/footerscripts.jsp"%>
<%-- 	
<script>
formsApp.service('beanService', function () {
			var type = "Cliente"
        	var mode =    '<%= request.getParameter("mode")%>';
        	if(mode=='add') {
        		title = "Agregar "+type;
        		
        	}else if(mode=="edit"){
        		title =" Editar "+type;
        	}else if(mode=="remove"){
        		title =" Eliminar " +type;
        	}
        	this.config = {
                bean: {
                	id:   '<%= request.getParameter("id")%>',
        			mode: '<%= request.getParameter("mode")%>',
        			rzsocial: '<%=bean.getRzsocial()%>',
        			client: '<%=bean.getClient()%>',
        			tel:  '<%=bean.getTel()%>',
        			fax: '<%=bean.getFax()%>',
        			telalt: '<%=bean.getTelalt()%>',
        			faxalt: '<%=bean.getFaxalt()%>',
        			numFiscal: '<%=bean.getNumfiscal()%>',
        			addrFiscal: '<%=bean.getAddrfiscal()%>',
        			email: '<%=bean.getEmail()%>',
        			rating: '<%=bean.getRating()%>',
        			addrShip: '<%=bean.getAddrship()%>',
        			country: '<%=bean.getCountry()%>',
        			tipocliente: '<%=bean.getTipo_cliente()%>',
        			seller: '<%=bean.getSeller()%>',
                },
                url: './bin/clients',
    			redirectUrl : "clients.jsp",
    			titleCrud: title
            };

            return this.config;
        })

    </script>
	     --%>
  </body>
</html>
<% 		
} else {
%>
		<p>No se especifico un id.</p>
<%
 } 
%>