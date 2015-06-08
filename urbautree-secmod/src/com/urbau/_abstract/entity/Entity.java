package com.urbau._abstract.entity;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau.beans.UsuarioBean;
import com.urbau.servlet.entity.UserNotAuthenticatedException;

/**
 * Servlet implementation class Entity
 */

@WebServlet("/Entity")
public class Entity extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	public static final String ADD_MODE = "add";
	public static final String DEL_MODE = "remove";
	public static final String EDIT_MODE = "edit";
	public static final String LIST_MODE = "list";
	public static final String VIEW_MODE = "view";
	public static final int SUCCESS_STATUS = 200;
	public static final String SUCCES_MESSAGE = "SUCCES";
	
	public void validateRequest(HttpSession session ) throws UserNotAuthenticatedException{
		UsuarioBean loggedUser = (UsuarioBean) session.getAttribute( "loggedUser" );
		
		if ( loggedUser == null || !loggedUser.isLogged() ){
			throw new UserNotAuthenticatedException( "No hay ningun usuario logeado" );
		}
	}
	public void showMessage( String message, HttpServletResponse response ) {
		try{
			response.getOutputStream().write( message.getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch( Exception e ){
			e.printStackTrace();
		}
	}
}
