package com.urbau.servlet.entity;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.BancoMovimientoBean;
import com.urbau.feeders.BancosMovimientosMain;

@WebServlet("/TiposDeMovimientosBanco")
public class TiposDeMovimientosBanco extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{								
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( "mode" );
			String id = request.getParameter( "id" );
			String idBanco = request.getParameter( "banco" );
			String fecha = request.getParameter( "fecha" );
			String idTipoMovimiento = request.getParameter( "tipomovimiento" );
			String descripcion = request.getParameter( "descripcion" );
			String monto = request.getParameter( "monto" );
																
			String message = "";
			
			BancoMovimientoBean bean = new BancoMovimientoBean();
			
			if(null != id ){
				bean.setId(Integer.parseInt(id));
			}			
			if( null != idBanco){
				bean.setIdBanco((Integer.parseInt(idBanco)));
			}
			if( null != fecha){				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				
				Date date = formatter.parse(fecha);				
				bean.setFecha(date);
			}
			if(null != idTipoMovimiento ){
				bean.setIdTipoMovimiento(Integer.parseInt(idTipoMovimiento));
			}
			if(null != descripcion ){
				bean.setDescripcion(descripcion);
			}
			if( null != monto){
				bean.setMonto((Double.parseDouble(monto)));
			}
			
																											
			BancosMovimientosMain main = new BancosMovimientosMain();
					
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
						
		} catch( UserNotAuthenticatedException exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (ParseException e) {
			System.out.println( "Error: " + e.getMessage() );			
		}
	}
	
}
				