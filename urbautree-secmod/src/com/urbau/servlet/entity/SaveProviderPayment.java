package com.urbau.servlet.entity;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/bin/SaveProviderPayment")
public class SaveProviderPayment extends Entity {
	private static final long serialVersionUID = 1L;
	

       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling save provider payment...");
			HttpSession session = request.getSession();
			UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			
			String id = request.getParameter( "formid" );
			String tipo_pago = request.getParameter( "tipo_pago" );
			String numero_cheque = request.getParameter( "numero_cheque" );
			String banco = request.getParameter( "banco" );
			String tipo_tarjeta = request.getParameter( "tipo_tarjeta" );
			String numero_tarjeta = request.getParameter( "numero_tarjeta" );
			String autorizacion = request.getParameter( "autorizacion" );
			String monto = request.getParameter( "monto" );
			
			String message = validateParameters( id, tipo_pago, numero_cheque, banco, tipo_tarjeta, numero_tarjeta, autorizacion, monto );
				
			if( message.length() > 0 ){
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			ExtendedFieldsBaseMain pagosMain = new ExtendedFieldsBaseMain( "PROVEEDORES_PAGOS", 
					new String[]{
							"ID_PROVEEDOR",
							"FECHA",
							"MONTO",
							"TIPO_PAGO",
							"NO_AUTORIZACION",
							"NO_CHEQUE",
							"ID_BANCO",
							"TIPO_TARJETA",
							"NO_TARJETA",
							"ID_USUARIO"
						},
					new int[]{ 
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_DATE,
							Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_STRING,
							Constants.EXTENDED_TYPE_STRING,
							Constants.EXTENDED_TYPE_STRING,
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_STRING,
							Constants.EXTENDED_TYPE_STRING,
							Constants.EXTENDED_TYPE_INTEGER
							
						}
			);
			
			ExtendedFieldsBean b = new ExtendedFieldsBean();
			
			b.putValue( "ID_PROVEEDOR", id );
			b.putValue("TIPO_PAGO", tipo_pago );
			b.putValue( "NO_CHEQUE", numero_cheque );
			if( banco != null ){
				b.putValue( "ID_BANCO", banco );
			}
			b.putValue( "TIPO_TARJETA", tipo_tarjeta );
			b.putValue( "NO_TARJETA", numero_tarjeta );
			b.putValue( "NO_AUTORIZACION", autorizacion );
			b.putValue( "MONTO", monto );
			b.putValue( "ID_USUARIO", String.valueOf( loggedUser.getId() ));
			b.putValue( "FECHA", "NOW()" );
			
			

			if( pagosMain.add( b ) ){
				message = "Pago guardado con exito.";
			} else {
				message = "No se pudo guardar el pago.";
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
    
    private String  validateParameters(
    		String order_id, String tipo_pago, String numero_cheque, String banco, String tipo_tarjeta, 
    		String numero_tarjeta, String autorizacion, String monto ) {
    	
		String message = "";
		
		if( Util.isEmpty( order_id )){
			message = "No ha seleccionado una orden";
		} else if( Util.isEmpty(tipo_pago)) {
			message = "No ha seleccionado un tipo de pago";
		} else if( Util.isEmpty( monto )){
			message = "No ha ingresado un monto";
		}
		
		if( "tarjeta".equals( tipo_pago  )){
			if( Util.isEmpty( banco  )){
				message = "No ha seleccionado un banco";
			} else if( Util.isEmpty( tipo_tarjeta )) {
				message = "No ha seleccionado un tipo de tarjeta";
			} else if ( Util.isEmpty( numero_tarjeta )){
				message = "No ha ingresado un numero de tarjeta";
			} else if ( Util.isEmpty( autorizacion )){
				message = "No ha ingresado una autorizacion";
			}
		} else if( "cheque".equals( tipo_pago  )){
			if( Util.isEmpty( numero_cheque )){
				message = "No ha ingresado un numero de cheque";
			} else if( Util.isEmpty( banco  )){
				message = "No ha seleccionado un banco";
			}
		}
		return message;
    	
    }
   
}
				
							