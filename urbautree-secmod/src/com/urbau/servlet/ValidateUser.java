package com.urbau.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau.feeders.UsuariosMain;

/**
 * Servlet implementation class VidrioMarketConfig
 */
@WebServlet(
		urlPatterns = { "/ValidateUser" } 
		)

public class ValidateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateUser() {
        super();
    }

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter( "user" );
		UsuariosMain um = new UsuariosMain();
		if ( um.existeUsuario(user) ){
			response.getOutputStream().write( "true".getBytes() );
		} else {
			response.getOutputStream().write( "false".getBytes() );
		}
			response.getOutputStream().flush();
			response.getOutputStream().close();
		
	}

}
