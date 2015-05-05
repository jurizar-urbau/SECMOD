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
          	<h3><i class="fa fa-angle-right"></i> SEGURIDAD</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          			<div class="content-panel">
          			<table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> ROLES</h4>
	                  	  	  <hr>
                              <thead>
                              <tr>
                                  <th>Rol</th>
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <tr>
                              <td>Administrador</td>
                              	<td>
                                      <button class="btn btn-primary btn-xs" onclick="mod();"><i class="fa fa-pencil"></i></button>
                                      <button class="btn btn-danger btn-xs" onclick="del();"><i class="fa fa-trash-o "></i></button>
                                      <button class="btn btn-success btn-xs" onclick="view();"><i class="fa fa-check"></i></button>
                                  </td>
                                  
                                  
                              </tr>
                              <tr>
                                  <td>
                                      Cajero
                                  </td>
                                  <td>
                                      <button class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i></button>
                                      <button class="btn btn-danger btn-xs"><i class="fa fa-trash-o "></i></button>
                                      <button class="btn btn-success btn-xs"><i class="fa fa-check"></i></button>
                                  </td>
                                  
                              </tr>
                              </tbody>
                          </table>
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
  </body>
</html>
