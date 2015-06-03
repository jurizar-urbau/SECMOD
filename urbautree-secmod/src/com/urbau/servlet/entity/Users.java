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

@WebServlet("/Users")
public class Users extends Entity {
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
					UsuarioBean bean = new UsuarioBean();
					
					bean.setUsuario( request.getParameter("loginid") );
					bean.setNombre( request.getParameter("nombresapellidos") );
					bean.setClave( request.getParameter("clave") );
					bean.setEmail( request.getParameter( "email" ));
					bean.setEstado( request.getParameter("activo") != null );
					bean.setTelefono( request.getParameter( "telefono" ));					
					
					if(null != request.getParameter("rol")){
						bean.setRol( Integer.parseInt( request.getParameter("rol") ));
					}
												
					if( !"add".equals( request.getParameter( "mode" ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					UsuariosMain main = new UsuariosMain();
					
					if( "add".equals( mode )){
						if ( main.add( bean ) ){
							message = "Usuario creado con exito.";
						} else {
							showMessage( "No se pudo crear el usuario" , response );
						}
					} else if( "edit".equals( mode )){
						if ( main.mod( bean ) ){
							message = "Usuario modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el usuario", response  );
						}
					} else if( "remove".equals( mode )){
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
				
				
				

