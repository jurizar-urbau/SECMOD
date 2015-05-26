package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.BancoBean;
import com.urbau.feeders.BancosMain;

@WebServlet("/Bancos")
public class Bancos extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( "mode" );
			System.out.println( "mode: " + mode );
			
			
			String message = "";
			if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" ))  ){
					BancoBean rm = new BancoBean();
					
					rm.setNombre( request.getParameter("nombre") );					
												
					if( !"add".equals( request.getParameter( "mode" ) ) ){
						rm.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					BancosMain rmain = new BancosMain();
					
					if( "add".equals( mode )){
						if ( rmain.add( rm ) ){
							message = "Registro creado con exito.";
						} else {
							showMessage( "No se pudo crear el registro" , response );
						}
					} else if( "edit".equals( mode )){
						if ( rmain.mod( rm ) ){
							message = "Registro modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el registro", response  );
						}
					} else if( "remove".equals( mode )){
						if ( rmain.del( rm ) ){
							message = "Registro eliminado con exito.";
						} else {
							showMessage( "No se pudo eliminar el registro" , response );
						}
					}
					response.getOutputStream().write( message.getBytes() );
					response.getOutputStream().flush();
					response.getOutputStream().close();
				}
			
		} catch( UserNotAuthenticatedException exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
	
}
				