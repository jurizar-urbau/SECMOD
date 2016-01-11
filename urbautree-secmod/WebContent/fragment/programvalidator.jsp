
<%
	if( !Authorization.isAuthorizedProgram( loggedUser.getRol(),programName)) {
%>
	<script> 
	alert( "No tiene permiso para este programa.");
	location.replace( "<%= Util.getAbsoluteParent(request.getRequestURI () , 0) %>/home.jsp" );
	</script>
	<%
}
%>