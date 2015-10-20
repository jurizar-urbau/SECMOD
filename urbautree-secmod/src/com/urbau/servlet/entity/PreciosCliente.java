package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.PreciosClienteBean;
import com.urbau.feeders.PreciosClientesMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.CLIENTE_PARAMETER;
import static com.urbau.misc.Constants.PRECIO_PARAMETER;
import static com.urbau.misc.Constants.ID_PRECIO_BORRAR_PARAMETER;

@WebServlet("/PreciosCliente")
public class PreciosCliente extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{				
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( MODE_PARAMETER );
			String id = request.getParameter( ID_PARAMETER );
			String idCliente = request.getParameter( CLIENTE_PARAMETER );
			String idPrecio = request.getParameter( PRECIO_PARAMETER );
			String idPrecioBorrar = request.getParameter( ID_PRECIO_BORRAR_PARAMETER );						
			
			String message = "";
			
			PreciosClienteBean bean = new PreciosClienteBean();
			
			if(null != id ){
				bean.setId(Integer.parseInt(id));
			}
			
			if( null != idCliente){
				bean.setIdCliente(Integer.parseInt(idCliente));
			}
			
			if( null != idPrecio){				
				bean.setIdPrecio(Integer.parseInt(idPrecio));
			}else{
				if(mode.equals(REMOVE)){
					bean.setIdPrecio(Integer.parseInt(idPrecioBorrar));
					
				}
			}
																							
			PreciosClientesMain main = new PreciosClientesMain();
					
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
			} else if( EDIT.equals( mode )){						
				if(main.duplicate(bean)){
					message = "Registro ya existe!";
				}else{
					if ( main.mod( bean ) ){
						message = "Registro modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el registro" , response );
					}
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
			
		} catch( UserNotAuthenticatedException exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
	
}
				