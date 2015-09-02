<%@page import="com.urbau.feeders.RolesMain"%>
<%@page import="com.urbau.misc.Constants"%>
<%@page import="com.urbau.beans.ClientBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ClientMain"%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	<head>
	<%@include file="fragment/head.jsp"%>
	<%@include file="fragment/angDepends.jsp"%>
	<%@include file="fragment/appDepends.jsp"%>
	<%
		ClientMain vm = new ClientMain();
		RolesMain roles_main = new RolesMain();
		
		int from = 0;
		if( request.getParameter( "from" ) != null ){
			from = Integer.parseInt( request.getParameter( "from" ) );
		}
		ArrayList<ClientBean> list = vm.getItems();
		int total_regs = -1;
		
		if( list.size() > 0 ){
			total_regs = ((ClientBean)list.get( 0 )).getTotal_regs();
		}
	%>
	<script>
	var table = "clients";
		function edit( id ){
			location.replace( table+"-detail.jsp?mode=edit&id="+id);
		}
		function removereg( id ){
			location.replace( table+"-detail.jsp?mode=remove&id="+id);
		}
		function view( id ){
			location.replace( table+"-detail.jsp?mode=view&id="+id);
		}
		function add(){
			location.replace( table+"-detail.jsp?mode=add" );
		}
	</script>
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
          <section class="wrapper site-min-height" ng-app="formsApp">
            		
          				  <div ng-view></div>
                      
                      
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
