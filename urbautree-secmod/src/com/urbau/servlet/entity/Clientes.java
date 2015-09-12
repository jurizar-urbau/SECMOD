package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ClienteBean;
import com.urbau.feeders.ClientesMain;

@WebServlet("/Clientes")
public class Clientes extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( "mode" );
			System.out.println( "mode: " + mode );
			
			boolean isModal = request.getParameter( "modal" ) != null ? "true".equals( request.getParameter( "modal" ) ) : false; 
			
			String message = "";
			if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" ))  ){
				ClienteBean bean = new ClienteBean();
					
					bean.setNit( request.getParameter("nit") );					
					bean.setNombres( request.getParameter("nombres") );
					bean.setApellidos( request.getParameter( "apellidos" ));
					bean.setDireccion( request.getParameter("direccion") );
					bean.setTelefono( request.getParameter( "telefono" ));					
					bean.setEmail( request.getParameter( "correo" ));
					bean.setTipoDeCliente(request.getParameter( "tipodecliente" ));
																																													
					if( !"add".equals( request.getParameter( "mode" ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					
					ClientesMain main = new ClientesMain();
					
					if( "add".equals( mode )){
						if ( main.add( bean ) ){
							if( isModal ){
								ClienteBean beanb = main.getByNit(bean.getNit());
								if( beanb != null ){
									message = "clientid: " + String.valueOf( beanb.getId() ) + "," + bean.getNombres() + " " + bean.getApellidos();
								} else {
									message = "Registro no guardado ";
								}
							} else {
								message = "Registro creado con exito.";
							}
						} else {
							showMessage( "No se pudo crear el registro" , response );
						}
					} else if( "edit".equals( mode )){
						if ( main.mod( bean ) ){
							message = "Registro modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el registro", response  );
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
		