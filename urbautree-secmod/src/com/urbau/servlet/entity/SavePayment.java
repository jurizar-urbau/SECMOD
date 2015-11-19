package com.urbau.servlet.entity;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.OrdenPagoBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.OrdenesMain;
import com.urbau.feeders.OrdenesPagoMain;
import com.urbau.misc.Util;
import static com.urbau.misc.Constants.ESTADO_PAGADO;

@WebServlet("/bin/SavePayment")
public class SavePayment extends Entity {
	private static final long serialVersionUID = 1L;
	

       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling save paymnt...");
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
				System.out.println( "returning message: " + message );
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			
			message = "No se pudo crear el pago.";
			
			OrdenPagoBean b = new OrdenPagoBean();
			b.setOrden_id( Integer.valueOf( id ));
			b.setTipo_pago(tipo_pago);
			b.setNumero_cheque(numero_cheque);
			b.setId_banco( Integer.valueOf( banco )	);
			b.setTipo_tarjeta(tipo_tarjeta);
			b.setNumero_tarjeta(numero_tarjeta);
			b.setNumero_autorizacion(autorizacion);
			b.setMonto( Double.valueOf( monto ));
			b.setId_usuario( loggedUser.getId() );
			
			OrdenesPagoMain opm = new OrdenesPagoMain();
			OrdenesMain ordenesMain = new OrdenesMain();
			if( opm.add( b ) ){
				if( ordenesMain.changeStatus( b.getOrden_id(), ESTADO_PAGADO, loggedUser.getId() )){
					//TODO unreserve products from storage.
					message = "Pagado con exito."; 
					 
				} else {
					
				}
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
    
    void printParameterValues( String[] values ){
    	for( String s : values ){
    		System.out.println( ">\t" + s);
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
				
							