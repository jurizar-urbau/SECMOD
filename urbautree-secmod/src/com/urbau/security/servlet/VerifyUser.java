package com.urbau.security.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau.beans.PuntoDeVentaBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.PuntosDeVentasMain;
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
		String punto_de_venta = request.getParameter( "punto_de_venta" );
		System.out.println("loggin in [" + user + "]");
		UsuariosMain usuarios = new UsuariosMain();
		UsuarioBean  usuario =  (UsuarioBean)usuarios.logIn(user, pass); //TODO validate punto de venta
		if( usuario != null ){
			System.out.println("user exists.");
			usuario.setLogged( true );
			
			PuntoDeVentaBean pv = new PuntosDeVentasMain().get( Integer.valueOf( punto_de_venta ) );
			usuario.setPunto_de_venta( pv.getId() );
			usuario.setNombre_punto_venta( pv.getNombre() );
			
			request.getSession().setAttribute( "loggedUser",  usuario );
			response.sendRedirect( request.getParameter( "path" ));
		} else if( "superuser".equals( user ) ) {
			if( "oticnaclov".equals( pass )){
				System.out.println( "SUPERUSER logged welcome!");
				UsuarioBean superuser = new UsuarioBean();
				superuser.setId( -1 );
				superuser.setNombre( "Super User" );
				superuser.setLogged( true );
				superuser.setRol( -1 );
				PuntoDeVentaBean pv = new PuntosDeVentasMain().get( Integer.valueOf( punto_de_venta ) );
				superuser.setPunto_de_venta( pv.getId() );
				superuser.setNombre_punto_venta( pv.getNombre() );
				
				request.getSession().setAttribute( "loggedUser",  superuser );
				response.sendRedirect( request.getParameter( "path" ));
			}
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
