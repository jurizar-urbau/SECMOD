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

import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.MODAL_PARAMETER;
import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.TRUE_STRING;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.NIT_PARAMETER;
import static com.urbau.misc.Constants.NOMBRES_PARAMETER;
import static com.urbau.misc.Constants.APELLIDOS_PARAMETER;
import static com.urbau.misc.Constants.DIRRECCION_PARAMETER;
import static com.urbau.misc.Constants.TELEFONO_PARAMETER;
import static com.urbau.misc.Constants.CORREO_PARAMETER;
import static com.urbau.misc.Constants.TIPO_DE_CLIENTE_PARAMETER;
import static com.urbau.misc.Constants.ACEPTA_CREDITO_PARAMETER;



@WebServlet("/Clientes")
public class Clientes extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( MODE_PARAMETER );
						
			boolean isModal = request.getParameter( MODAL_PARAMETER ) != null ? TRUE_STRING.equals( request.getParameter( MODAL_PARAMETER ) ) : false; 
			
			String message = "";
			if( request.getParameter( ID_PARAMETER ) != null || ADD.equals( request.getParameter( MODE_PARAMETER ))  ){
				ClienteBean bean = new ClienteBean();
					
					bean.setNit( request.getParameter(NIT_PARAMETER) );					
					bean.setNombres( request.getParameter(NOMBRES_PARAMETER) );
					bean.setApellidos( request.getParameter( APELLIDOS_PARAMETER ));
					bean.setDireccion( request.getParameter(DIRRECCION_PARAMETER) );
					bean.setTelefono( request.getParameter( TELEFONO_PARAMETER ));					
					bean.setEmail( request.getParameter( CORREO_PARAMETER ));
					bean.setTipoDeCliente(request.getParameter( TIPO_DE_CLIENTE_PARAMETER ));
					bean.setAcepta_credito( request.getParameter( ACEPTA_CREDITO_PARAMETER ) == null ? 0 : Integer.valueOf( request.getParameter( ACEPTA_CREDITO_PARAMETER )));																																													
					if( !ADD.equals( request.getParameter( MODE_PARAMETER ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( ID_PARAMETER )));
					}
					
					ClientesMain main = new ClientesMain();
					
					if( ADD.equals( mode )){
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
					} else if( EDIT.equals( mode )){
						if ( main.mod( bean ) ){
							message = "Registro modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el registro", response  );
						}
					} else if( REMOVE.equals( mode )){
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
		