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

@WebServlet("/Inventarios")
public class Inventarios extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println("\n\n\n INVENTARIO ***** " );
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( "mode" );						
			String id = request.getParameter( "id" );
			String idBodega = request.getParameter( "bodega" );
			String producto = request.getParameter( "producto" );
			String estatus = request.getParameter( "estatus" );
			String estatusremove = request.getParameter( "estatusremove" );
			String cantidad = request.getParameter( "cantidad" );
			
			
			System.out.println("Mode: " +  mode);
			System.out.println("Id: " + id);
			System.out.println("Bodega: " + idBodega);
			System.out.println("producto: " + producto);
			System.out.println("Estatus: " + estatus);
			System.out.println("estatusremove: " + estatusremove);
			System.out.println("cantidad: " + cantidad);
			
			String message = "";
			
			InvetarioBean bean = new InvetarioBean();
			
			if(null != idBodega ){
				bean.setIdBodega(Integer.parseInt(idBodega));
			}
			
			if("add".equals(mode)){
				if( null != producto){
					bean.setId_product(Integer.parseInt(producto));
				}
			}else{
				if( null != id){
					bean.setId_product(Integer.parseInt(id));
				}
			}
			
			
			if("remove".equals(mode)){				
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
				