package com.urbau.security.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.UsuariosMain;

/**
 * Servlet implementation class Redirect
 */
@WebServlet("/bin/VerifyUser")
public class VerifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public VerifyUser() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("path:" + request.getParameter("path") );
		String user = request.getParameter( "user" );
		String pass = request.getParameter( "password" );
		System.out.println("loggin in [" + user + "]");
		UsuariosMain usuarios = new UsuariosMain();
		UsuarioBean  usuario =  usuarios.logIn(user, pass);
		if( usuario != null ){
			System.out.println("user exists.");
			usuario.setLogged( true );
			request.getSession().setAttribute( "loggedUser",  usuario );
			response.sendRedirect( request.getParameter( "path" ));
		} else {
			System.out.println("user doesn't exist ");
			request.getSession().setAttribute( "messages", new String[]{"Usuario o clave no existe"} );
			String referrer = request.getHeader("referer");
			response.sendRedirect( referrer );
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
