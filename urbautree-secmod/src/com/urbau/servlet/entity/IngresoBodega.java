package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.InvetarioBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.InventariosMain;
import com.urbau.misc.Constants;
import com.urbau.misc.CorrelativosUtil;
import com.urbau.misc.Util;

@WebServlet("/bin/IngresoBodega")
public class IngresoBodega extends Entity {
	private static final long serialVersionUID = 1L;
	public static final String ESTADO_INGRESADO = "I";
	public static final String ESTADO_CANCELADO = "C";
	public static final String ESTADO_DESPACHADO = "D";
	
	ExtendedFieldsBaseMain comprasMain = new ExtendedFieldsBaseMain( "COMPRAS_DETALLE", 
			new String[]{ 
					"ID_COMPRA","ID_BODEGA","ID_PRODUCTO","UNIDADES","COSTO","SUBTOTAL"
		    },
			new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER, 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE
			} );
	
	
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling save orders...");
			HttpSession session = request.getSession();
			//UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			
			String bodegaidStr = request.getParameter( "bodegaid" );
			
			String proveedoridStr = request.getParameter( "proveedorid" );
			String cheque_ref     = request.getParameter( "cheque" );
			
			int bodegaid = Integer.valueOf( bodegaidStr );
			String productidStr[] = request.getParameterValues( "productid" );
			String amountStr[] = request.getParameterValues( "amount" );
			String packStr[] = request.getParameterValues( "pack" );
			
			String priceStr[] = request.getParameterValues( "price" );
			
			String numeroDeCompra = request.getParameter( "numero-de-compra" );
			
			boolean withProvider = false;
			
			if ( priceStr != null && proveedoridStr != null ){
				withProvider = true;
			}
			
			
			String descuentoStr = request.getParameter( "descuento" );
			double descuento = 0;
			if( descuentoStr != null ){
				try{
					descuento = Double.valueOf( descuentoStr );
				 } catch ( Exception ig ){
					 
				 }
			}
			
			
			System.out.println( "descuento: " + descuento );
			System.out.println( "proveedor: " + proveedoridStr ) ;
			System.out.println( "bodega   : " + bodegaidStr  );
			 
			String message = validateParameters( bodegaidStr, productidStr, amountStr, packStr );
			
			if( message.length() > 0 ){
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			
			message = "No se pudo crear el pedido.";
			
			InventariosMain im = new InventariosMain();
			
			UsuarioBean loggedUser = getLoggedUser(session);
			
			ExtendedFieldsBaseMain carga_bodega = new ExtendedFieldsBaseMain( 
					"CARGAS_BODEGA", new String[]{"BODEGA","FECHA","USUARIO","CORRELATIVO"}, new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_DATE, Constants.EXTENDED_TYPE_INTEGER, Constants.EXTENDED_TYPE_INTEGER
			});
			ExtendedFieldsBean carga_bean = new ExtendedFieldsBean();
			
			CorrelativosUtil correlativosUtil = new CorrelativosUtil();
			int next = correlativosUtil.getNextAndAdvance( "CARGA_BODEGA_" + bodegaid );
			
			carga_bean.putValue("BODEGA", String.valueOf( bodegaid)  );
			carga_bean.putValue("FECHA", "NOW()" );
			//carga_bean.putValue("FECHA", Util.getTodayDate() );
			carga_bean.putValue( "USUARIO", String.valueOf( loggedUser.getId() ));
			carga_bean.putValue( "CORRELATIVO", String.valueOf( next ));
			
			String transaction_id = carga_bodega.addForTransaction( carga_bean );
			
			int carga_id = carga_bodega.getIdFromTransaction( transaction_id );
			carga_bean.setId( carga_id );
					
			ExtendedFieldsBaseMain carga_bodega_detail = new ExtendedFieldsBaseMain( "CARGAS_BODEGA_DETALLE", 
					new String[]{ "ID_CARGA", "ID_PRODUCTO", "UNIDADES_PRODUCTO", "UNITARIO", "PACKING_SELECCIONADO" }, 
					new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER} 
			);
			int compraID = -1;
			if( !Util.isEmpty(proveedoridStr )){
				 
				ExtendedFieldsBaseMain comprasMain = new ExtendedFieldsBaseMain( "COMPRAS", 
						new String[]{ 
							"FECHA","ID_PROVEEDOR",
							"ID_ORDEN_DE_COMPRA","TIPO_DE_PAGO",
							"FORMA_DE_INGRESO","SUBTOTAL",
							"DESCUENTO","TOTAL","GASTOS",
							"TOTAL_CON_GASTOS","ESTADO","CHEQUE_REF","NUMERO_DE_COMPRA"
					    },
						new int[]{ 
							Constants.EXTENDED_TYPE_DATE, 
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_DOUBLE,
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_STRING,
							Constants.EXTENDED_TYPE_STRING
						} );
				
				double subtotal = 0;
				double total = 0;
				for( int i = 0; i < productidStr.length; i++ ){
					double price = Double.valueOf( priceStr[ i ]);
					int amount = Integer.valueOf( amountStr[ i ] );
					int pack = Integer.valueOf( packStr[ i ] );
					subtotal +=  price * pack * amount;
					total +=  price * pack * amount;
				}
				
				ExtendedFieldsBean compra = new ExtendedFieldsBean();
				compra.putValue( "FECHA", "NOW()" );
				compra.putValue( "ID_PROVEEDOR", proveedoridStr );
				compra.putValue( "ID_ORDEN_DE_COMPRA",  String.valueOf( carga_id ) );
				compra.putValue( "TIPO_DE_PAGO", "0" );
				compra.putValue( "FORMA_DE_INGRESO", "0" );
				compra.putValue( "SUBTOTAL", "" + subtotal );
				compra.putValue( "DESCUENTO", ""+descuento );
				compra.putValue( "TOTAL", "" + (total-descuento) );
				compra.putValue( "GASTOS", "0" );
				compra.putValue( "TOTAL_CON_GASTOS", "" + total  );
				compra.putValue( "ESTADO", "0" );
				compra.putValue( "CHEQUE_REF", cheque_ref );
				compra.putValue( "NUMERO_DE_COMPRA", numeroDeCompra );
				String addedCompra = comprasMain.addForTransaction(compra);
				compraID = comprasMain.getIdFromTransaction( addedCompra );
				System.out.println( "compra added: " + addedCompra );
				
			}
			
			for( int i = 0; i < productidStr.length; i++ ){
				int prodid = Integer.valueOf( productidStr[ i ] );
				int amount = Integer.valueOf( amountStr[ i ] );
				int pack = Integer.valueOf( packStr[ i ] );
				
				ExtendedFieldsBean carga_bean_detalle_bean = new ExtendedFieldsBean();
				
				
				carga_bean_detalle_bean.putValue( "ID_CARGA", String.valueOf(  carga_id ));
				carga_bean_detalle_bean.putValue( "ID_PRODUCTO", String.valueOf( prodid ));
				carga_bean_detalle_bean.putValue( "UNIDADES_PRODUCTO", String.valueOf( amount * pack ));
				carga_bean_detalle_bean.putValue( "UNITARIO", String.valueOf( amount ));
				carga_bean_detalle_bean.putValue( "PACKING_SELECCIONADO", String.valueOf( pack ));
				
				if( withProvider && compraID > 0 ){
					double price = Double.valueOf( priceStr[ i ]);
					System.out.println( "prodID :" + productidStr );
					System.out.println( "pack   :" + pack );
					System.out.println( "amount :" + amount );
					System.out.println( "price  :" + price );
					ExtendedFieldsBean compra_detalle_bean = comprasMain.fillBean(
							String.valueOf( compraID ),
							String.valueOf( bodegaid ), 
							productidStr[ i ], 
							String.valueOf( pack * amount),
							priceStr[ i ], 
							String.valueOf( price * pack * amount )   
					);
					comprasMain.add( compra_detalle_bean );
				}

				carga_bodega_detail.add( carga_bean_detalle_bean );
				
				
					InvetarioBean a = im.get ( prodid, "a", bodegaid );
					if( a == null ){
						a = new InvetarioBean();
						a.setIdBodega( bodegaid );
						a.setId_product( prodid );
						a.setEstatus( "a" );
						a.setAmount( amount * pack );
						
						if( im.add( a ) ) {
							message = carga_id + "|Carga agregada exitosamente!";
						} else {
							System.out.println( "No se pudo agregar el nuevo inventario...");
						}
					} else {
						a.setAmount( a.getAmount() + ( amount * pack ) );
						a.setIdBodega( bodegaid );
						if( im.mod( a ) ) {
							message = carga_id + "|Carga agregada exitosamente!";
						} else {
							System.out.println( "No se pudo agregar el nuevo inventario...");
						}
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
	
    private String  validateParameters( String bodegaidStr, String[] productidStr,String[] amountStr,String[] packStr ) {
    	String message = "";
    	if( isEmpty( bodegaidStr )) {
    		message = "No ha seleccionado una bodega";
     	} else if( isEmpty( productidStr ) || isEmpty( amountStr ) || isEmpty( packStr )) {
    		message = "No ha seleccionado ningun producto";
    	}
    	return message;
    	
    }
    private boolean isEmpty( String str ){
    	if( str == null || "".equals( str.trim() ) || "null".endsWith( str ) || "undefined".equals( str ) ){
    		return true;
    	}
    	return false;
    }
    private boolean isEmpty( String[] strs ){
    	if( strs == null || strs.length == 0  ){
    		return true;
    	} else {
    		for( String str : strs ){
    			if( isEmpty( str )){
    				return true;
    			}
    		}
    	}
    	return false;
    }
}
				
							