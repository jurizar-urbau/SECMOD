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

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.BANCO_PARAMETER;
import static com.urbau.misc.Constants.FECHA_PARAMETER;
import static com.urbau.misc.Constants.TIPO_MOVIMIENTO_PARAMETER;
import static com.urbau.misc.Constants.DESCRIPCION_PARAMETER;
import static com.urbau.misc.Constants.MONTO_PARAMETER;

@WebServlet("/TiposDeMovimientosBanco")
public class TiposDeMovimientosBanco extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{								
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( MODE_PARAMETER );
			String id = request.getParameter( ID_PARAMETER );
			String idBanco = request.getParameter( BANCO_PARAMETER );
			String fecha = request.getParameter( FECHA_PARAMETER );
			String idTipoMovimiento = request.getParameter( TIPO_MOVIMIENTO_PARAMETER );
			String descripcion = request.getParameter( DESCRIPCION_PARAMETER );
			String monto = request.getParameter( MONTO_PARAMETER );
																
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
				if ( main.mod( bean ) ){
					message = "Registro modificado con exito.";
				} else {
					showMessage( "No se pudo modificar el registro" , response );
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
		} catch (ParseException e) {
			System.out.println( "Error: " + e.getMessage() );			
		}
	}
	
}
				