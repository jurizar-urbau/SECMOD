package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.InvetarioBean;
import com.urbau.feeders.InventariosMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.BODEGA_PARAMETER;
import static com.urbau.misc.Constants.PRODUCTO_PARAMETER;
import static com.urbau.misc.Constants.ESTATUS_PARAMETER;
import static com.urbau.misc.Constants.CANTIDAD_PARAMETER;
import static com.urbau.misc.Constants.ESTATUS_REMOVE_PARAMETER;

@WebServlet("/Inventarios")
public class Inventarios extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{				
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( MODE_PARAMETER );						
			String id = request.getParameter( ID_PARAMETER );
			String idBodega = request.getParameter( BODEGA_PARAMETER );
			String producto = request.getParameter( PRODUCTO_PARAMETER );
			String estatus = request.getParameter( ESTATUS_PARAMETER );
			String estatusremove = request.getParameter( ESTATUS_REMOVE_PARAMETER );
			String cantidad = request.getParameter( CANTIDAD_PARAMETER );					
			
			String message = "";
			
			InvetarioBean bean = new InvetarioBean();
			
			if(null != idBodega ){
				bean.setIdBodega(Integer.parseInt(idBodega));
			}
			
			if(ADD.equals(mode)){
				if( null != producto){
					bean.setId_product(Integer.parseInt(producto));
				}
			}else{
				if( null != id){
					bean.setId_product(Integer.parseInt(id));
				}
			}
			
			
			if(REMOVE.equals(mode)){				
				if( null != estatusremove){
					bean.setEstatus(estatusremove);
				}
			}else{
				if( null != estatus){
					bean.setEstatus(estatus);
				}
			}
			
			if( null != cantidad){
				bean.setAmount(Integer.parseInt(cantidad));
			}
			
			
			if( bean.getIdBodega() > 0  && null != bean.getEstatus()){
																								
					InventariosMain main = new InventariosMain();
					
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
				