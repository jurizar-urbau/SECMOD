package com.urbau.servlet.entity;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ClienteBean;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.OrdenBean;
import com.urbau.beans.OrdenPagoBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.ClientesMain;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.OrdenesMain;
import com.urbau.feeders.OrdenesPagoOrdenMain;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/bin/SaveCreditOrderPayment")
public class SaveOrderPayment extends Entity {
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
			String factura = request.getParameter( "factura" );
			
			
			String message = validateParameters( id, tipo_pago, numero_cheque, banco, tipo_tarjeta, numero_tarjeta, autorizacion, monto );
				
			if( message.length() > 0 ){
				System.out.println( "returning message: " + message );
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			
			OrdenPagoBean b = new OrdenPagoBean();
			b.setOrden_id( Integer.valueOf( id ));
			b.setTipo_pago(tipo_pago);
			b.setNumero_cheque(numero_cheque);
			if( banco != null ){
				b.setId_banco( Integer.valueOf( banco )	);
			}
			b.setTipo_tarjeta(tipo_tarjeta);
			b.setNumero_tarjeta(numero_tarjeta);
			b.setNumero_autorizacion(autorizacion);
			b.setMonto( Double.valueOf( monto ));
			b.setId_usuario( loggedUser.getId() );
			
			ExtendedFieldsBaseMain creditoMain = new ExtendedFieldsBaseMain( "CLIENTES_CREDITOS", new String[]{"ID_CLIENTE"},
					new int[]{ Constants.EXTENDED_TYPE_INTEGER});
			ExtendedFieldsBean creditoBean = creditoMain.get( Integer.valueOf( id ));
			System.out.println( "ORDEN ID: " + id );
			
			int client_id = creditoBean.getValueAsInt( "ID_CLIENTE" );
			ClientesMain clientesMain = new ClientesMain();
			ClienteBean  clienteBean = clientesMain.get( client_id );
			
			OrdenesPagoOrdenMain opm = new OrdenesPagoOrdenMain();

			if( opm.add( b ) ){
				ExtendedFieldsBaseMain facturasMain = new ExtendedFieldsBaseMain( 
						"FACTURAS" , 
						new String[]{"ORDEN","FACTURA","FECHA","SUBTOTAL","TOTAL","USUARIO","NIT","NOMBRE","DIRECCION"}, 
						new int[]{ 
								Constants.EXTENDED_TYPE_INTEGER,
								Constants.EXTENDED_TYPE_STRING,
								Constants.EXTENDED_TYPE_INTEGER,
								Constants.EXTENDED_TYPE_DOUBLE,
								Constants.EXTENDED_TYPE_DOUBLE,
								Constants.EXTENDED_TYPE_INTEGER,
								Constants.EXTENDED_TYPE_STRING,
								Constants.EXTENDED_TYPE_STRING,
								Constants.EXTENDED_TYPE_STRING
						}
				);
				ExtendedFieldsBean facturaBean = new ExtendedFieldsBean();
				
				facturaBean.putValue( "ORDEN", id );
				facturaBean.putValue( "FACTURA", factura );
				facturaBean.putValue( "FECHA", "NOW()" );
				facturaBean.putValue( "SUBTOTAL", monto );
				facturaBean.putValue( "TOTAL", monto );
				facturaBean.putValue( "USUARIO", String.valueOf( loggedUser.getId() ));
				facturaBean.putValue( "NIT", clienteBean.getNit() );
				facturaBean.putValue( "NOMBRE", clienteBean.getNombres() + " " + clienteBean.getApellidos() );
				facturaBean.putValue( "DIRECCION", clienteBean.getDireccion() );
				
				String transactionID = facturasMain.addForTransaction(facturaBean);
				int facturaID = facturasMain.getIdFromTransaction(transactionID);
				System.out.println( "Id factura: " + facturaID );
				message = "Pagado con exito.";
			} else {
				message = "No se pudo pagar.";
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
				
							