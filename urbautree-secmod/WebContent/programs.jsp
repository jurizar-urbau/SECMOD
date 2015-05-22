<%@page import="java.util.ArrayList"%>
<%@page import="com.urbau.feeders.ProgramsMain"%>
<%@page import="com.urbau.beans.ProgramBean"%>

<%	
	System.out.println(">>>>>>>>>>>>>>>>>>>>PROGRAMS JSP >>>>>>>>>>>>>>>>>>>>>>>>>><<<<");	
				
	
	ProgramsMain programsMain = new ProgramsMain();
	
	int from = 0;
	if( request.getParameter( "from" ) != null ){
		from = Integer.parseInt( request.getParameter( "from" ) );
	}
	ArrayList<ProgramBean> list = programsMain.getProgram( request.getParameter("q"), from );
	int total_regs = -1;
	
	if( list.size() > 0 ){
		total_regs = ((ProgramBean)list.get( 0 )).getTotal_regs();
	}
	
	
%>
<%@page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
	
	<head>
		<%@include file="fragment/head.jsp"%>
		<script>
			function edit( id ){
				location.replace( "programs-detail.jsp?mode=edit&id="+id);
			}
			function removereg( id ){
				
				location.replace( "programs-detail.jsp?mode=remove&id="+id);
			}
			function view( id ){
				location.replace( "programs-detail.jsp?mode=view&id="+id);
			}
			function add(){
				location.replace( "programs-detail.jsp?mode=add" );
			}
		</script>
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
          	<h3><i class="fa fa-angle-right"></i>SEGURIDAD</h3>
          	<div class="row mt">
          		<div class="col-lg-12">
          		<div class="content-panel">
          		
          			<span class="pull-right">          				
     					<button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;          				 
     				</span>      				  	
      				  	
	          		<table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> PROGRAMAS</h4>
	                  	  	  <hr>
                              <thead>
                              <tr>
                                  <th>NOMBRE</th>
                                  <th>PROGRAMA</th>
                              </tr>
                              </thead>
                              <tbody>
                              
	                              <%
	                              	for( ProgramBean program : list ){
	                              %>
                                  
                                  <tr>
                              		<td><%= program.getDescription() %></td>
                              		<td><%= program.getProgram_name() %></td>
                              		<td>          
                                      <button class="btn btn-primary btn-xs" onclick="edit('<%= program.getId()  %>');"><i class="fa fa-pencil"></i></button>
                                   		<button class="btn btn-danger btn-xs" onclick="removereg('<%= program.getId()  %>');"><i class="fa fa-trash-o "></i></button>
                                   		<button class="btn btn-success btn-xs" onclick="view('<%= program.getId()  %>');"><i class="fa fa-check"></i></button>
                                  	</td>                                                                  
                              	  </tr>
                                  	
                                <% } %>                                                                                           
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
