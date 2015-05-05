<%@page import="com.urbau.misc.Util"%>
<jsp:useBean id="loggedUser" class="com.urbau.beans.UsuarioBean" scope="session"></jsp:useBean>

<%
if ( !loggedUser.isLogged() ){
%>
<script> 
alert( "No hay ningun usuario logaedo.");
location.replace( "<%= Util.getAbsoluteParent(request.getRequestURI () , 0) %>" );
</script>
<% } %>