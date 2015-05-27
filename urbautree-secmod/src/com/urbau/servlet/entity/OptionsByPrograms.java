package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.OptionsByProgramBean;
import com.urbau.feeders.OptionsByProgramMain;

@WebServlet("/OptionsByPrograms")
public class OptionsByPrograms extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
						
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( "mode" );
			String idProgram =request.getParameter("idProgram");
			String idOption =request.getParameter("idOption");
			String idRol = request.getParameter( "idRol" );
			String id = request.getParameter( "id" );
						
			
			String message = "";
			if( null != mode ){
				
					OptionsByProgramBean rm = new OptionsByProgramBean();
																											
					if(null != idProgram){
						rm.setId_program( idProgram );
					}
					if(null != idOption){
						rm.setId_option(idOption);
					}
					if(null != idRol){
						rm.setId_rol(idRol);	
					}
																																		
					if( !"add".equals( mode ) && null != id){
						rm.setId( Integer.parseInt( id));
					}
										
					OptionsByProgramMain rmain = new OptionsByProgramMain();
					
					if( "add".equals( mode )){
						if ( rmain.add( rm ) ){
							message = "Registro creado con exito.";
						} else {
							showMessage( "No se pudo crear el registro" , response );
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
				