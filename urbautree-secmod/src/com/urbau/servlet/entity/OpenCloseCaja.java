package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.misc.Constants;
import com.urbau.misc.ExtendedFieldsFilter;
import com.urbau.misc.Util;

@WebServlet("/bin/OpenCloseCaja")
public class OpenCloseCaja extends Entity {
	private static final long serialVersionUID = 1L;
	

       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "Open close Caja");
			HttpSession session = request.getSession();
			UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			
			String id_caja  = request.getParameter( "id_caja"  );
			String efectivo = request.getParameter( "efectivo" );
			String tarjeta  = request.getParameter( "tarjeta"  );
			String credito  = request.getParameter( "credito"  );
			String accion   = request.getParameter( "accion"   );
			
			int loggedUserId = loggedUser.getId();
 			
			String message = validateParameters( id_caja, efectivo, tarjeta, credito, accion );
				
			if( message.length() > 0 ){
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			
			message = "Ocurrio un error.";
			
			
			ExtendedFieldsBaseMain caja_detalle_main = new ExtendedFieldsBaseMain( "CAJA_DETALLE", 
					new String[] { 
							"ID_CAJA",
							"FECHA_APERTURA","FECHA_CIERRE",
							"USUARIO_APERTURA","USUARIO_CIERRE",
							"EFECTIVO_APERTURA","EFECTIVO_CIERRE",
							"TARJETA_APERTURA","TARJETA_CIERRE",
							"CREDITO_APERTURA","CREDITO_CIERRE" 
							}	
					, new int[]{ 
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_DATE,Constants.EXTENDED_TYPE_DATE,
							Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_DOUBLE,Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_DOUBLE,Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_DOUBLE,Constants.EXTENDED_TYPE_DOUBLE
					} );
			
			
			
			ExtendedFieldsBean caja_detalle_bean = null;
			
			if( "abrir".equals( accion ) ) {
				caja_detalle_bean = new ExtendedFieldsBean();
				
				caja_detalle_bean.putValue( "ID_CAJA", id_caja );
				caja_detalle_bean.putValue( "USUARIO_APERTURA", String.valueOf( loggedUserId ) );
				caja_detalle_bean.putValue( "FECHA_APERTURA", "NOW()" );
				caja_detalle_bean.putValue( "EFECTIVO_APERTURA", efectivo );
				caja_detalle_bean.putValue( "TARJETA_APERTURA", tarjeta );
				caja_detalle_bean.putValue( "CREDITO_APERTURA", credito );
				
				boolean inserted = caja_detalle_main.add( caja_detalle_bean );
				
				if( inserted ){
					message = "Operacion ejecutada con exito.";
				} else {
					message = "Error al hacer la operacion. [00]";
				}
				
			} else if( "cerrar".equals( accion ) ) {
				
				ExtendedFieldsFilter filter = new ExtendedFieldsFilter( 
						new String[]{"ID_CAJA","FECHA"} , 
						new int[]{ExtendedFieldsFilter.EQUALS,ExtendedFieldsFilter.EQUALS},
						new int[]{Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_DATE},
						new String[]{ id_caja,Util.getTodayDate()} );
				
				ArrayList<ExtendedFieldsBean> list = caja_detalle_main.getAll( filter );
				if( list.size() > 0 ){
					caja_detalle_bean = list.get( 0 );
				}
				caja_detalle_bean.putValue( "USUARIO_CIERRE", String.valueOf( loggedUserId ) );
				caja_detalle_bean.putValue( "FECHA_CIERRE", "NOW()" );
				caja_detalle_bean.putValue( "EFECTIVO_CIERRE", efectivo );
				caja_detalle_bean.putValue( "TARJETA_CIERRE", tarjeta );
				caja_detalle_bean.putValue( "CREDITO_CIERRE", credito );
				
				boolean updated = caja_detalle_main.mod( caja_detalle_bean );
				
				if( updated ){
					message = "Pagado con exito.";
				} else {
					message = "Error al hacer la operacion. [01]";
				}
 			} else {
				message = "Error al hacer la operacion. [02]";
			}
			
			response.getOutputStream().write( message.getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
			
		} catch( Exception exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
    
    private String  validateParameters( String id_caja,String efectivo,String tarjeta,String credito,String accion ) {
    	
		String message = "";
		
		if( Util.isEmpty( id_caja )){
			message = "No ha seleccionado una caja";
		} else if( Util.isEmpty(efectivo)) {
			message = "No ha ingresado un monto para efectivo.";
		} else if( Util.isEmpty( tarjeta )){
			message = "No ha ingresado un monto para tarjeta.";
		} else if( Util.isEmpty( credito )){
			message = "No ha ingresado un monto para credito.";
		} else if( Util.isEmpty( accion )){
			message = "No ha seleccionado una accion.";
		}
		
		return message;
    	
    }
   
}
				
							