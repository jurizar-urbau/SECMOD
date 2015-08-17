package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.BodegaClienteBean;
import com.urbau.feeders.BodegasClientesMain;

@WebServlet("/BodegasClientes")
public class BodegasClientes extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println("****** BODEGAS_CLIENTES ***** " );
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( "mode" );
			String id = request.getParameter( "id" );
			String idCliente = request.getParameter( "cliente" );
			String idBodega = request.getParameter( "bodega" );
			String idBodegaBorrar = request.getParameter( "idBodegaBorrar" );
			
			
			System.out.println("mode: " + mode);
			System.out.println("id: " + id);
			System.out.println("idCliente: " + idCliente);
			System.out.println("idPrecio: " + idBodega);
			
			String message = "";
			
			BodegaClienteBean bean = new BodegaClienteBean();
			
			if(null != id ){
				bean.setId(Integer.parseInt(id));
			}
			
			if( null != idCliente){
				bean.setIdCliente(Integer.parseInt(idCliente));
			}
			
			if( null != idBodega){				
				bean.setIdBodega(Integer.parseInt(idBodega));
			}else{
				if(mode.equals("remove")){
					bean.setIdBodega(Integer.parseInt(idBodegaBorrar));
					
				}
			}
														
			
							
																							
			BodegasClientesMain main = new BodegasClientesMain();
					
			if( "add".equals( mode )){
				if(main.duplicate(bean)){
					message = "Registro ya existe!";
				}else{
					if ( main.add( bean ) ){
						message = "Registro creado con exito.";
					} else {
						showMessage( "No se pudo crear el registro" , response );
					}
				}
			} else if( "edit".equals( mode )){						
				if(main.duplicate(bean)){
					message = "Registro ya existe!";
				}else{
					if ( main.mod( bean ) ){
						message = "Registro modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el registro" , response );
					}
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
			

			
		} catch( UserNotAuthenticatedException exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
	
}
				