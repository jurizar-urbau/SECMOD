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

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.ID_PROGRAM_PARAMETER;
import static com.urbau.misc.Constants.ID_OPTION_PARAMETER;
import static com.urbau.misc.Constants.ID_ROL_PARAMETER;

@WebServlet("/OptionsByPrograms")
public class OptionsByPrograms extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{									
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( MODE_PARAMETER );
			String idProgram =request.getParameter( ID_PROGRAM_PARAMETER );
			String idOption =request.getParameter( ID_OPTION_PARAMETER );
			String idRol = request.getParameter( ID_ROL_PARAMETER );
			String id = request.getParameter( ID_PARAMETER );
														
			if( null != mode ){
								
				String message = "";
				
					OptionsByProgramBean bean = new OptionsByProgramBean();
																											
					if(null != idProgram){
						bean.setId_program( idProgram );
					}
					if(null != idOption){
						bean.setId_option(idOption);
					}
					if(null != idRol){
						bean.setId_rol(idRol);	
					}
																																																	
					OptionsByProgramMain main = new OptionsByProgramMain();
					
					if( ADD.equals( mode )){
					
						if(main.duplicate(bean)){
							message = "Registro ya existe!";
						}else{
							if ( main.add( bean ) ){
								message = "Registro creado con exito.";
							} else {
								showMessage( "No se pudo crear el registro" , response );
							}
						}
						
					} else if( REMOVE.equals( mode )){
						
						try{
							bean.setId( Integer.parseInt( id));
						}catch(NumberFormatException e){
							showMessage( "No se pudo eliminar el registro" , response );
							System.out.println( "Error: " + e.getMessage() );
						}
												
						if ( main.del( bean ) ){
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
				