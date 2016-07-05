package com.urbau.servlet.entity;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.ExtendedFieldsOrderBy;
import com.urbau.misc.Constants;
import com.urbau.misc.ExtendedFieldsFilter;
import com.urbau.misc.PaymentsHelper;
import com.urbau.misc.Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;


@WebServlet("/bin/PayCompraProveedor")
public class PayCompraProveedor extends Entity {
	private static final long serialVersionUID = 1L;
	

       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
		try{
			
			Enumeration<String> parameters = request.getParameterNames();
			while( parameters.hasMoreElements() ){
				String s = parameters.nextElement();
				println(session, s + ":" + request.getParameter( s ));
			}
			println( session, "paying compra proveedor");
			validateRequest( session );
			
			String id_proveedor = request.getParameter( "proveedorid" );
			String monto = request.getParameter( "monto" );
			
			String tipo_pago = request.getParameter( "tipo_pago" );
			String numero_cheque = request.getParameter( "numero_cheque" );
			String banco = request.getParameter( "banco" );
			String tipo_tarjeta = request.getParameter( "tipo_tarjeta" );
			String numero_tarjeta = request.getParameter( "numero_tarjeta" );
			String autorizacion = request.getParameter( "autorizacion" );
			
			String message = validateParameters( id_proveedor, monto );
				
			if( message.length() > 0 ){
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			

			
			ExtendedFieldsBaseMain creditoMain = new ExtendedFieldsBaseMain( "COMPRAS", new String[]{"TOTAL"},
					new int[]{ Constants.EXTENDED_TYPE_DOUBLE});
			
			ExtendedFieldsFilter filter = new ExtendedFieldsFilter( 
					new String[]{"ID_PROVEEDOR"}, 
					new int[]{ExtendedFieldsFilter.EQUALS}, 
					new int[]{Constants.EXTENDED_TYPE_INTEGER}, 
					new String[]{id_proveedor}
					);
			
			ExtendedFieldsOrderBy orderBy = new ExtendedFieldsOrderBy( new String[]{"ID"}, false);
			
			ArrayList<ExtendedFieldsBean> creditos = creditoMain.getAll(filter, orderBy);
			double montoTotal = Double.valueOf( monto );
			double disponible = montoTotal;
			
			for( ExtendedFieldsBean bean : creditos ){
				double montocredito = Double.valueOf( bean.getValue( "TOTAL" ) );
				double montopagado  = Util.getTotalOrderPayments( bean.getId() );
				double saldo = montocredito - montopagado;
				if( saldo > 0 ){
					println( session, "ID:" + bean.getId() + ", credito: "+ montocredito + ",pagado: " + montopagado + ", aplica para pago" );
					println( session, "monto a pagar: " + saldo );
					println( session, "disponible: " + disponible );
					if( saldo > disponible ){
						
						println( session, "Pago parcial" );
						boolean paid = PaymentsHelper.saveCompraProveedorPayment(
								String.valueOf( bean.getId() ), 
								tipo_pago, numero_cheque, banco, tipo_tarjeta, numero_tarjeta, autorizacion, 
								String.valueOf( disponible ), getLoggedUser(session));
						println( session, "Pago realizado: " + paid );
						message = "Pago realizado con exito.";
					} else {
						println( session, "Pago completo" );
						boolean paid = PaymentsHelper.saveCompraProveedorPayment(
								String.valueOf( bean.getId() ), 
								tipo_pago, numero_cheque, banco, tipo_tarjeta, numero_tarjeta, autorizacion, 
								String.valueOf( saldo ), getLoggedUser(session));
								
						println( session, "Pago realizado: " + paid );
						message = "Pago realizado con exito.";
					}
					disponible-=saldo;
				}
			}
			
			

			
			response.getOutputStream().write( message.getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
			
		} catch( Exception exception ){
			println( session, "paying client credit");
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
    
    private String  validateParameters(
    		String id_proveedor, String monto ) {
    	
		String message = "";
		
		if( Util.isEmpty( id_proveedor )){
			message = "No ha seleccionado un proveedor";
		} else if( Util.isEmpty(monto)) {
			message = "No ha ingresado un monto";
		} else if( !Util.isNumber( monto )){
			message = "El monto debe ser numerico";
		}
		return message;
    	
    }
   
}
				
							