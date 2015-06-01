<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.TypeCallBean	"%>
<%@page import="com.urbau.feeders.TypeCallMain"%>
<%@page import="com.urbau.feeders.RolesMain"%>
      
<%
		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			TypeCallMain rm = new TypeCallMain();
			RolesMain roles_main = new RolesMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			TypeCallBean bean = rm.getItem(id);
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
          <section class="wrapper site-min-height" ng-app="fesApp"  ng-controller="formCtrl" >
          	<h3><i class="fa fa-angle-right"></i>  {{beanService.titleCrud}} </h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			<div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="typecalls.jsp">&nbsp;Regresar</a> </h4>
                      <form class="form-horizontal style-form" id="form" name="form" novalidate>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Tipo</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control"  ng-model="beanService.bean.type"  >
                              </div>
                          </div>
                          
                           <div class="form-actions">
                           	    <input  class="btn"  type="button" ng-click="reset()" value="Reset" />
 								<input type="submit" class="btn btn-success"  ng-click="update(beanService.bean)" value="Guardar" />
					        </div>  
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
	
<script>
	fesApp.service('beanService', function () {
        	var mode =    '<%= request.getParameter("mode")%>';
        	if(mode=='add') {
        		title = "Agregar Tipo de Llamada";
        		
        	}else if(mode=="edit"){
        		title =" Editar tipo de llamada";
        	}else if(mode=="remove"){
        		title =" Eliminar tipo de llamada";
        	}
        	this.config = {
                bean: {
                	id:   '<%= request.getParameter("id")%>',
        			mode: '<%= request.getParameter("mode")%>',
        			type: '<%=bean.getType()%>'
                },
                url: './bin/typecalls',
    			redirectUrl : "typecalls.jsp",
    			titleCrud: title
            };

            return this.config;
        })

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