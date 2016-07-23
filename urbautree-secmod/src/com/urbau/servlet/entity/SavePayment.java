package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.OrdenBean;
import com.urbau.beans.OrdenDetailBean;
import com.urbau.beans.OrdenPagoBean;
import com.urbau.beans.ProductoBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.OrdenesDetalleMain;
import com.urbau.feeders.OrdenesMain;
import com.urbau.feeders.OrdenesPagoMain;
import com.urbau.feeders.ProductosMain;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;
import static com.urbau.misc.Constants.ESTADO_PAGADO;

@WebServlet("/bin/SavePayment")
public class SavePayment extends Entity {
	private static final long serialVersionUID = 1L;
	

       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling save paymnt from caja...");
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
			String id_cupon = request.getParameter( "cupon" );
			
			
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
			if( banco != null ){
				b.setId_banco( Integer.valueOf( banco )	);
			}
			b.setTipo_tarjeta(tipo_tarjeta);
			b.setNumero_tarjeta(numero_tarjeta);
			b.setNumero_autorizacion(autorizacion);
			b.setMonto( Double.valueOf( monto ));
			b.setId_usuario( loggedUser.getId() );
			b.setPunto_de_venta( loggedUser.getPunto_de_venta() );
			b.setCaja_punto_de_venta( loggedUser.getCaja_punto_de_venta() );
			b.setId_cupon( Integer.valueOf( id_cupon ) );
			
			//TODO marcar como usado.
			
			OrdenesPagoMain opm = new OrdenesPagoMain();
			OrdenesMain ordenesMain = new OrdenesMain();
			OrdenesDetalleMain ordenesDetalleMain = new OrdenesDetalleMain();
			ArrayList<OrdenDetailBean> orderDetalle = ordenesDetalleMain.getDetails( Integer.valueOf( id ) );
			if( opm.add( b ) ){
				if( ordenesMain.changeStatus( b.getOrden_id(), ESTADO_PAGADO, loggedUser.getId() )){
					if( "credito".equals( tipo_pago ) ){
						ExtendedFieldsBaseMain creditos_cliente = new ExtendedFieldsBaseMain( "CLIENTES_CREDITOS", 
								new String[] { "ID_CLIENTE", "ID_ORDEN", "FECHA_CREDITO", "MONTO", "ID_USUARIO" }	
								, new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_DATE,Constants.EXTENDED_TYPE_DOUBLE,Constants.EXTENDED_TYPE_INTEGER } );
						
						ExtendedFieldsBean creditos_cliente_bean = new ExtendedFieldsBean();
						OrdenBean ordenBean = ordenesMain.get( b.getOrden_id() );
						creditos_cliente_bean.putValue( "ID_CLIENTE", String.valueOf( ordenBean.getId_cliente() ));
						creditos_cliente_bean.putValue( "ID_ORDEN", id );
						creditos_cliente_bean.putValue( "FECHA_CREDITO", Util.getDateString( new Date() ));
						creditos_cliente_bean.putValue( "MONTO", monto );
						creditos_cliente_bean.putValue( "ID_USUARIO", String.valueOf( loggedUser.getId() ) );
						
						if( creditos_cliente.add( creditos_cliente_bean )) {
							message = "Pagado con exito.";
						}
					} else {
						
						OrdenBean ordenBean = ordenesMain.get( b.getOrden_id() );
						
						ExtendedFieldsBaseMain facturasMain = new ExtendedFieldsBaseMain( 
								"FACTURAS" , 
								new String[]{"ORDEN","FACTURA","FECHA","SUBTOTAL","TOTAL","USUARIO","NIT","NOMBRE","DIRECCION"}, 
								new int[]{ 
										Constants.EXTENDED_TYPE_INTEGER,
										Constants.EXTENDED_TYPE_STRING,
										Constants.EXTENDED_TYPE_DATE,
										Constants.EXTENDED_TYPE_DOUBLE,
										Constants.EXTENDED_TYPE_DOUBLE,
										Constants.EXTENDED_TYPE_INTEGER,
										Constants.EXTENDED_TYPE_STRING,
										Constants.EXTENDED_TYPE_STRING,
										Constants.EXTENDED_TYPE_STRING
								}
						);
						
						ExtendedFieldsBaseMain facturasDetail = new ExtendedFieldsBaseMain( 
								"FACTURAS_DETALLE" , 
								new String[]{"ID_FACTURA","CANTIDAD","DESCRIPCION","SUBTOTAL","TOTAL"}, 
								new int[]{ 
										Constants.EXTENDED_TYPE_INTEGER,
										Constants.EXTENDED_TYPE_INTEGER,
										Constants.EXTENDED_TYPE_STRING,
										Constants.EXTENDED_TYPE_DOUBLE,
										Constants.EXTENDED_TYPE_DOUBLE
								}
						);
						
						
						ExtendedFieldsBean facturaBean = new ExtendedFieldsBean();
						
						ExtendedFieldsBaseMain clienteMain = new ExtendedFieldsBaseMain( "CLIENTES",
								new String[]{ "NIT","NOMBRES","APELLIDOS","DIRECCION"},
								new int[]{Constants.EXTENDED_TYPE_STRING,Constants.EXTENDED_TYPE_STRING,Constants.EXTENDED_TYPE_STRING,Constants.EXTENDED_TYPE_STRING,});
						
						ExtendedFieldsBean clienteBean = clienteMain.get( ordenBean.getId_cliente() );
						facturaBean.putValue( "ORDEN", id );
						facturaBean.putValue( "FACTURA", factura );
						facturaBean.putValue( "FECHA", "NOW()" );
						facturaBean.putValue( "SUBTOTAL", monto );
						facturaBean.putValue( "TOTAL", monto );
						facturaBean.putValue( "USUARIO", String.valueOf( loggedUser.getId() ));
						facturaBean.putValue( "NIT", clienteBean.getValue( "NIT" ));
						facturaBean.putValue( "NOMBRE", clienteBean.getValue ( "NOMBRES" ) + " " + clienteBean.getValue( "APELLIDOS" ) );
						facturaBean.putValue( "DIRECCION", clienteBean.getValue( "DIRECCION" ) );
						
						String transactionID = facturasMain.addForTransaction(facturaBean);
						int facturaID = facturasMain.getIdFromTransaction(transactionID);
						System.out.println( "Id factura: " + facturaID );
						ProductosMain productos = new ProductosMain();
						
						for( OrdenDetailBean detalle : orderDetalle ){
							ProductoBean producto = productos.get( detalle.getId_producto() );
							ExtendedFieldsBean bean = new ExtendedFieldsBean();
							bean.putValue( "ID_FACTURA", String.valueOf(( facturaID )));
							bean.putValue( "CANTIDAD", String.valueOf( detalle.getCantidad()) );
							bean.putValue( "DESCRIPCION",  producto.getDescripcion() );
							bean.putValue( "SUBTOTAL", String.valueOf( detalle.getPrecio_unitario() ));
							bean.putValue( "TOTAL", String.valueOf( detalle.getTotal() ) );
							facturasDetail.add( bean );
						}
						
						message = facturaID + "|Pagado con exito.";
					}
				} else {
					message = "No se pudo pagar.";
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
			}
//			else if ( Util.isEmpty( numero_tarjeta )){
//				message = "No ha ingresado un numero de tarjeta";
//			}
			else if ( Util.isEmpty( autorizacion )){
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
				
							