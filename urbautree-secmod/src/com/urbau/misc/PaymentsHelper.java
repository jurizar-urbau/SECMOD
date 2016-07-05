package com.urbau.misc;

import com.urbau.beans.ClienteBean;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.OrdenPagoBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.ClientesMain;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.OrdenesPagoOrdenMain;

public class PaymentsHelper {
	
	public static synchronized boolean saveCompraProveedorPayment(
			String idcompra ,
			String tipo_pago,
			String numero_cheque,
			String banco,
			String tipo_tarjeta,
			String numero_tarjeta,
			String autorizacion,
			String monto,
			UsuarioBean loggedUser
			){
		ExtendedFieldsBaseMain pagosMain = new ExtendedFieldsBaseMain( "PROVEEDORES_PAGOS", 
				new String[]{
						"ID_COMPRA",
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
		
		b.putValue( "ID_COMPRA", idcompra );
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
			return true;
		} else {
			return false;
		}
	}
			
			
	public static synchronized boolean saveCliendCreditOrderPayment( 
													String id, 
													String tipo_pago, 
													String numero_cheque, 
													String banco, 
													String tipo_tarjeta, 
													String numero_tarjeta, 
													String autorizacion, 
													String monto, 
													String factura,
													UsuarioBean loggedUser
												){
		
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
			return true;
		} else {
			return false;
		}

	}
}
