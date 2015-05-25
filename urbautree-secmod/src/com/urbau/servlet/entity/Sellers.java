package com.urbau.servlet.entity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.SellerBean;
import com.urbau.feeders.SellerMain;


@WebServlet("/sellers")
public class Sellers extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String ADD_MODE = "add";
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( "mode" );
			System.out.println( "mode: " + mode );
			System.out.println( "id: " + request.getParameter( "id") );
			
			String message = "";
			if( request.getParameter( "id" ) != null || ADD_MODE.equals( request.getParameter( "mode" ))  ){
					SellerBean rm = new SellerBean();
					rm.setName( request.getParameter("name") );
					rm.setSurname( request.getParameter("surname") );
					rm.setUser( request.getParameter("user") );
					if( !ADD_MODE.equals( request.getParameter( "mode" ) ) ){
						rm.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					SellerMain rmain = new SellerMain();
					
					if( ADD_MODE.equals( mode )){
						if ( rmain.addSeller(rm) ){
							message = "Vendedor creado con exito.";
						} else {
							showMessage( "No se pudo crear el Vendedor" , response );
						}
					} else if( "edit".equals( mode )){
						if ( rmain.modSeller(rm) ){
							message = "Vendedor modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el Vendedor", response  );
						}
					} else if( "remove".equals( mode )){
						if ( rmain.delSeller( rm ) ){
							message = "Vendedor eliminado con exito.";
						} else {
							showMessage( "No se pudo eliminar el Vendedor" , response );
						}
					}
					System.out.println(message);
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
				
				
				

