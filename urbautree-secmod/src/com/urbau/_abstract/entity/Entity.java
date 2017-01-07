package com.urbau._abstract.entity;

import java.util.Date;

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
	private static final int SECONDS = 5;

	public void validateRequestForTransaction( HttpSession session ) throws UserNotAuthenticatedException {
		validateRequest( session );
		if ( !isValidTimeForTransaction( session ) ){
			throw new UserNotAuthenticatedException( "Transaccion ya fue enviada." );	
		}
	}
	public void validateRequest(HttpSession session ) throws UserNotAuthenticatedException{
		UsuarioBean loggedUser = (UsuarioBean) session.getAttribute( "loggedUser" );
		
		if ( loggedUser == null || !loggedUser.isLogged() ){
			throw new UserNotAuthenticatedException( "No hay ningun usuario logeado" );
		}
	}
	public UsuarioBean getLoggedUser(HttpSession session ) {
		UsuarioBean loggedUser = (UsuarioBean) session.getAttribute( "loggedUser" );
		
		return loggedUser;
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
	public void println( HttpSession session,  String str ){
		System.out.println( "[" + new Date() + getLoggedUser(session).getNombre() + "] " + str ); 
	}
	
	public boolean isValidTimeForTransaction( HttpSession session ){
		boolean valid = false;
		String lastTRX = (String)session.getAttribute("lastTRX");
		if( lastTRX != null ){
			long lasttime = Long.valueOf( lastTRX );
			long current  = System.currentTimeMillis();
			
			if( ( current - lasttime ) / 1000 > SECONDS ){
				valid = true;
				lastTRX = String.valueOf( current );
			}
		} else {
			lastTRX = String.valueOf( System.currentTimeMillis() );
			valid = true;
		}
		session.setAttribute( "lastTRX", lastTRX );
		return valid;
	}
}
