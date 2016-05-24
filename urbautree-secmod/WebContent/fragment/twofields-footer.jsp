<%@page import="com.urbau.misc.Constants"%>
<%
	
	TwoFieldsBaseMain um = new TwoFieldsBaseMain( TABLE_NAME );
			
			int from = 0;
			if( request.getParameter( "from" ) != null ){
		from = Integer.parseInt( request.getParameter( "from" ) );
			}
			ArrayList<TwoFieldsBean> list = um.get( request.getParameter("q"), from );
			int total_regs = -1;
			
			if( list.size() > 0 ){
		total_regs = ((TwoFieldsBean)list.get( 0 )).getTotal_regs();
			}
	%>
	<script>
		function edit( id ){
			location.replace( "<%= PAGE_BASE_NAME %>-detail.jsp?mode=edit&id="+id);
		}
		function removereg( id ){
			location.replace( "<%= PAGE_BASE_NAME %>-detail.jsp?mode=remove&id="+id);
		}
		function view( id ){
			location.replace( "<%= PAGE_BASE_NAME %>-detail.jsp?mode=view&id="+id);
		} 
		function add(){
			location.replace( "<%= PAGE_BASE_NAME %>-detail.jsp?mode=add" );
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
      		<%@include file="header.jsp"%>        
        </header>
      <!--header end-->
      
      <!-- **********************************************************************************************************************************************************
      MAIN SIDEBAR MENU
      *********************************************************************************************************************************************************** -->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
              <%@include file="sidebar.jsp"%>
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
          <br/>
          <div class="col-lg-6"> 
           
          </div>
          <div class="col-lg-6">
          		<form>
	          		<div class="top-menu">
			              <ul class="nav pull-right top-menu">
			              		<li><input type="text" class="form-control" id="search-query-3" name="q" value="<%= ( request.getParameter( "q" ) != null && !"null".equals( request.getParameter( "q" ) )) ? request.getParameter( "q" ) : "" %>" ></li>
			                    <li><button class="btn btn-primary">Buscar</button></li>
			              </ul>
		            </div>
			    </form>
			  </div>
			  <br/>
			  
          	
          	<div class="row mt">
          		<div class="col-lg-12">
          		<div class="content-panel">
          				  <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), TABLE_NAME, Constants.OPTIONS_ADD)){ %>
	          				  <span class="pull-right">
	          				  	<button type="button" class="btn btn-success" onclick="add();">+</button>&nbsp;&nbsp;&nbsp;
	          				  </span>
	          			  <% } %>
          				  
                          <table class="table table-striped table-advance table-hover">
	                  	  	  <h4><i class="fa fa-angle-right"></i> <%= PAGE_TITLE %></h4>
	                  	  	  <hr>
	                  	  	  <thead>
                              <tr>
                                  
                                  <th>Descripci&oacute;n</th>                                  
                                  <th></th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	for( TwoFieldsBean us : list ){
                              %>
                              <tr>
                                  <td><%= us.getDescripcion() %></td>                                                                   
                                  <td>
                                      <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), TABLE_NAME, Constants.OPTIONS_MODIFY)){ %>
                                      	<button class="btn btn-primary btn-xs" onclick="edit('<%= us.getId()  %>');"><i class="fa fa-pencil"></i></button>
                                      <% } %>
                                      <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), TABLE_NAME, Constants.OPTIONS_DELETE)){ %>
                                      	<button class="btn btn-danger btn-xs" onclick="removereg('<%= us.getId()  %>');"><i class="fa fa-trash-o "></i></button>
                                      <% } %>
                                      <% if(Authorization.isAuthorizedOption(loggedUser.getRol(), TABLE_NAME, Constants.OPTIONS_VIEW)){ %>
                                      	<button class="btn btn-success btn-xs" onclick="view('<%= us.getId()  %>');"><i class="fa fa-check"></i></button>
                                      <% } %>
                                  </td>
                              </tr>
                              <% } %>
                              
                              </tbody>
                          </table>
                         
                      </div>
                      <%
			int init = from + 1;
			
			int end  = (from + Constants.ITEMS_PER_PAGE  ) >= total_regs ? total_regs : (from + Constants.ITEMS_PER_PAGE  );
			
			boolean backButton = true;
			boolean forwardButton = true;
			if( from <= 0 ){ 
				backButton = false;
			}
			if( end >= total_regs ){
				forwardButton = false;
			}
		%>
		              <nav>
					  <ul class="pager">
					  <% if( backButton ) {%>
					  <li class="previous">
					    		<a href="<%= PAGE_BASE_NAME %>.jsp?q=<%= request.getParameter("q") %>&from=<%= from - Constants.ITEMS_PER_PAGE  %>">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } else { %>
					  <li class="previous disabled">
					    		<a href="javascript: return null">
					    			<span aria-hidden="true">&larr;</span> Anterior</a></li>
					  <% } %>
					    <% if( forwardButton ){  %>
					    <li class="next">
					    	<a href="<%= PAGE_BASE_NAME %>.jsp?q=<%= request.getParameter("q") %>&from=<%= end  %>">
					    		Siguiente <span aria-hidden="true">&rarr;</span></a></li>
					    <% } else { %>
					    <li class="next disabled">
					    	<a href="javascript: return null">
					    		Siguiente <span aria-hidden="true">&rarr;</span></a></li>
					    <% } %>
					    
					  </ul>
					</nav>
          		</div>
          	</div>
			
		</section><!--/wrapper -->
      </section><!-- /MAIN CONTENT -->

      <!--main content end-->
      <!--footer start-->
      <footer class="site-footer">
          <%@include file="footer.jsp"%>
      </footer>
      <!--footer end-->
  </section>
	<%@include file="footerscripts.jsp"%>
  </body>
</html>