package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.PrecioBean;
import com.urbau.feeders.PreciosMain;

@WebServlet("/Precios")
public class Precios extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( "mode" );						
			
			String message = "";
			if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" ))  ){
														
					double coeficiente = 0.0;
					String coeficienteParameter = request.getParameter("coeficiente");
					
					if(null != coeficienteParameter){
						coeficiente = Double.parseDouble(coeficienteParameter);
					}
					
					PrecioBean bean = new PrecioBean();					
					bean.setNombre( request.getParameter("nombre") );
					bean.setCoeficiente(coeficiente );
												
					if( !"add".equals( request.getParameter( "mode" ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					PreciosMain main = new PreciosMain();
					
					if( "add".equals( mode )){						
						if ( main.add( bean ) ){
							message = "Registro creado con exito.";
						} else {
							showMessage( "No se pudo crear el registro" , response );
						}						
						
					} else if( "edit".equals( mode )){												
						if ( main.mod( bean ) ){
							message = "Registro modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el registro" , response );
						}
																								
					} else if( "remove".equals( mode )){
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
				