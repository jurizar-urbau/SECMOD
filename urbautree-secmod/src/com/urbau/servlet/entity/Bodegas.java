package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.BodegaBean;
import com.urbau.feeders.BodegasMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.NOMBRE_PARAMETER;
import static com.urbau.misc.Constants.DIRRECCION_PARAMETER;
import static com.urbau.misc.Constants.TELEFONO_PARAMETER;
import static com.urbau.misc.Constants.PRINCIPAL_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;

@WebServlet("/Bodegas")
public class Bodegas extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
						
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( MODE_PARAMETER );			
						
			String message = "";
			if( request.getParameter( ID_PARAMETER ) != null || ADD.equals( request.getParameter( MODE_PARAMETER ))  ){
					BodegaBean bean = new BodegaBean();
					
					bean.setNombre( request.getParameter(NOMBRE_PARAMETER) );
					bean.setDireccion( request.getParameter(DIRRECCION_PARAMETER) );
					bean.setTelefono( request.getParameter( TELEFONO_PARAMETER ));					
															
					if(null == request.getParameter( PRINCIPAL_PARAMETER )){
						bean.setEstado(false);
					}else{
						bean.setEstado(true);
					}
					
					if( !ADD.equals( request.getParameter( MODE_PARAMETER ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( ID_PARAMETER )));
					}
					BodegasMain beanain = new BodegasMain();
					
					if( ADD.equals( mode )){
						if ( beanain.addBodega( bean ) ){
							message = "Registro creado con exito.";
						} else {
							showMessage( "No se pudo crear el registro" , response );
						}
					} else if( EDIT.equals( mode )){
						if ( beanain.modBodega( bean ) ){
							message = "Registro modificada con exito.";
						} else {
							showMessage( "No se pudo modificar el registro", response  );
						}
					} else if( REMOVE.equals( mode )){
						if ( beanain.delBodega( bean ) ){
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
				
				
				

