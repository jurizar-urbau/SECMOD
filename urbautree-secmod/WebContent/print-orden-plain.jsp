<%@
page import="com.urbau.feeders.OrdenesMain"%><%@
page import="com.urbau.misc.OrderPrintWrapper"%><%@
page import="com.urbau.feeders.UsuariosMain"%><%@
page import="com.urbau.beans.UsuarioBean"%><%@
page import="com.urbau.misc.OrderPrintWrapper"%><%@ 
page contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8"%><%
	OrderPrintWrapper wrapper = new OrderPrintWrapper();	
	OrdenesMain ordenMain = new OrdenesMain();	
%><%= wrapper.getOrderDispatchPrintable(ordenMain.get( Integer.valueOf( request.getParameter("id")))) %>