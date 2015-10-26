package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.UsuariosMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.LOGIN_ID_PARAMETER;
import static com.urbau.misc.Constants.NOMBRES_APELLIDOS_PARAMETER;
import static com.urbau.misc.Constants.CLAVE_PARAMETER;
import static com.urbau.misc.Constants.EMAIL_PARAMETER;
import static com.urbau.misc.Constants.ACTIVO_PARAMETER;
import static com.urbau.misc.Constants.TELEFONO_PARAMETER;
import static com.urbau.misc.Constants.ROL_PARAMETER;

@WebServlet("/Users")
public class Users extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{						
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( MODE_PARAMETER );			
			String message = "";
			
			if( request.getParameter( ID_PARAMETER ) != null || ADD.equals( request.getParameter( MODE_PARAMETER ))  ){
					UsuarioBean bean = new UsuarioBean();
					
					bean.setUsuario( request.getParameter( LOGIN_ID_PARAMETER ) );
					bean.setNombre( request.getParameter( NOMBRES_APELLIDOS_PARAMETER) );
					bean.setClave( request.getParameter( CLAVE_PARAMETER ) );
					bean.setEmail( request.getParameter( EMAIL_PARAMETER ));
					bean.setEstado( request.getParameter( ACTIVO_PARAMETER) != null );
					bean.setTelefono( request.getParameter( TELEFONO_PARAMETER ));					
					
					String rolParameter = request.getParameter( ROL_PARAMETER );
					if(null != rolParameter ){
						bean.setRol( Integer.parseInt( rolParameter ));
					}
												
					if( !ADD.equals( request.getParameter( MODE_PARAMETER ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( ID_PARAMETER )));
					}
					UsuariosMain main = new UsuariosMain();
					
					if( ADD.equals( mode )){
						if ( main.add( bean ) ){
							message = "Usuario creado con exito.";
						} else {
							showMessage( "No se pudo crear el usuario" , response );
						}
					} else if( EDIT.equals( mode )){
						if ( main.mod( bean ) ){
							message = "Usuario modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el usuario", response  );
						}
					} else if( REMOVE.equals( mode )){
						if ( main.del( bean ) ){
							message = "Usuario eliminado con exito.";
						} else {
							showMessage( "No se pudo eliminar el usuario" , response );
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