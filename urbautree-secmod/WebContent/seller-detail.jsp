<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.beans.SellerBean	"%>
<%@page import="com.urbau.feeders.SellerMain"%>
<%@page import="com.urbau.feeders.RolesMain"%>
      
<%
		String field = "Vendedor";

		if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" )) || "addModal".equals( request.getParameter( "mode" ))  ){
			SellerMain rm = new SellerMain();
			RolesMain roles_main = new RolesMain();
			
			int id = "add".equals( request.getParameter( "mode" ) ) || "addModal".equals( request.getParameter( "mode" ) ) ? -1 : Integer.valueOf( request.getParameter( "id" ) );
			SellerBean bean = rm.getSeller(id);
			String cmd = "Nuevo "+field;
			String mode = request.getParameter( "mode" );
			String keyReadOnly = "readonly=\"readonly\"";
			String optionalReadOnly = "";
			String mandatoryReadOnly = "";
			String jsFunction = "save();";
			String validateUser = "";
			if( "edit".equals( mode ) ){
				cmd = "Editar "+field + id;
				mandatoryReadOnly = keyReadOnly;
				jsFunction = "edit();";
			} else if( "view".equals( mode )){
				cmd = "Ver "+field + id;
				mandatoryReadOnly = keyReadOnly;
				optionalReadOnly = keyReadOnly;
			} else if( "remove".equals(mode) ){
				cmd = "Eliminar "+field + id;
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
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&appId=159695794072494&version=v2.3";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>

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
          
          	<h3><i class="fa fa-angle-right"></i> DETALLE VENDEDOR</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			
          			    <div class="form-panel">
          			   
                  	  <h4 class="mb"><i class="fa fa-angle-left"></i><a href="sellers.jsp">&nbsp;Regresar</a> </h4>
                      <form class="form-horizontal style-form" method="POST" id="form" name="form" action="">
                      <input type="hidden" name="mode" value="<%= request.getParameter("mode")%>">
                      <input type="hidden" name="id" value="<%= request.getParameter("id")%>">
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Nombre</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control" name="name" id="name" value="<%= bean.getName() %>">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Apelido</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control" name="surname" id="surname" value="<%= bean.getSurname() %>">
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-sm-2 col-sm-2 control-label">Usuario</label>
                              <div class="col-sm-10">
                                  <input type="text" class="form-control" name="user" id="user" value="<%= bean.getUser()%>">
                              </div>
                          </div>
                        
                           <div class="form-actions">
                           	    <button type="submit" class="btn btn-success" id="savebutton">Guardar</button> 
					            <button class="btn" onclick="location.replace('sellers.jsp')">Cancelar</button>
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
            $(document).ready(function(){
             $('#form').validate(
             {
              rules: {
                loginid: {
                  minlength: 2,
                  maxlength: 10,
                  required: true
                },
                email: {
                  required: true,
                  email: true
                },
                nombresapellidos: {
                  minlength: 3,
                  maxlength: 50,
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
		//twitter bootstrap script
		 $("#savebutton").click(function(){
		         $.ajax({
		     type: "POST",
		 url: "./bin/sellers",
		 data: $('#form').serialize(),
		         success: function(msg){
		                  alert(msg);
		                  location.replace( "sellers.jsp" );
		         },
		 error: function(){
		 alert("failure");
		 
		 }
		       });
		 });
		});
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