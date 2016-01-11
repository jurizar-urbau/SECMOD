package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.InvetarioBean;
import com.urbau.beans.OrdenBean;
import com.urbau.beans.OrdenDetailBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.InventariosMain;
import com.urbau.feeders.OrdenesDetalleMain;
import com.urbau.feeders.OrdenesMain;

import static com.urbau.misc.Constants.ESTADO_INGRESADO;
import static com.urbau.misc.Constants.CLIENT_ID_PARAMETER;
import static com.urbau.misc.Constants.BODEGA_ID_PARAMETER;
import static com.urbau.misc.Constants.PRODUCT_ID_PARAMETER;
import static com.urbau.misc.Constants.AMOUNT_PARAMETER;
import static com.urbau.misc.Constants.PRICE_PARAMETER;

@WebServlet("/bin/Ordenes")
public class Ordenes extends Entity {
	private static final long serialVersionUID = 1L;

       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling save orders...");
			HttpSession session = request.getSession();
			UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			
			String clientidStr = request.getParameter( CLIENT_ID_PARAMETER );
			String bodegaidStr = request.getParameter( BODEGA_ID_PARAMETER );
			String productidStr[] = request.getParameterValues( PRODUCT_ID_PARAMETER  );
			String amountStr[] = request.getParameterValues( AMOUNT_PARAMETER );
			String priceStr[] = request.getParameterValues( PRICE_PARAMETER );
			
			String message = validateParameters( clientidStr, bodegaidStr, productidStr, amountStr, priceStr );
			
			if( message.length() > 0 ){
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			
			message = "No se pudo crear el pedido.";
			
			OrdenBean ordenBean = new OrdenBean();
			ordenBean.setId_cliente( Integer.parseInt( clientidStr ));
			ordenBean.setId_bodega ( Integer.parseInt( bodegaidStr ));
			
			ordenBean.setId_usuario( loggedUser.getId() );
			ordenBean.setEstado( ESTADO_INGRESADO );
			ordenBean.setUid( ordenBean.getId_cliente() + "-" + getUID() );
			ordenBean.setId_punto_venta( loggedUser.getPunto_de_venta() );
			
			double monto = 0.00;
			for( int i = 0; i < productidStr.length; i++ ){
				int amount = Integer.valueOf( amountStr[ i ] );
				double price = Double.valueOf( priceStr[ i ] );
				monto += amount * price;
			}
			ordenBean.setMonto(monto);
			
			OrdenesMain om = new  OrdenesMain();
			boolean added = om.add( ordenBean );
			ordenBean  =  om.get( ordenBean.getUid() );
			
			//ArrayList<OrdenDetailBean> details = new ArrayList<>();
			
			OrdenesDetalleMain odm = new OrdenesDetalleMain();
			InventariosMain im = new InventariosMain();
			
			for( int i = 0; i < productidStr.length; i++ ){
				int prodid = Integer.valueOf( productidStr[ i ] );
				int amount = Integer.valueOf( amountStr[ i ] );
				double price = Double.valueOf( priceStr[ i ] );
				
				OrdenDetailBean b = new OrdenDetailBean();
				b.setId_orden( ordenBean.getId() );
				b.setId_producto(prodid) ;
				b.setCantidad(amount);
				b.setPrecio_unitario(price);
				b.setTotal( b.getCantidad() * b.getPrecio_unitario() );
				
				if( odm.add( b ) ) {
					InvetarioBean a = im.get( b.getId_producto(), "a", ordenBean.getId_bodega() );
					a.setAmount( a.getAmount() - b.getCantidad() );
					a.setIdBodega( ordenBean.getId_bodega() );
					if( im.mod( a )) {
						InvetarioBean newi;
						
						newi = im.get(a.getId_product(), "r", ordenBean.getId_bodega(), ordenBean.getId() );
						if( newi == null ){
							 newi = new  InvetarioBean();
							 newi.setId_product( a.getId_product() );
							 newi.setEstatus( "r" );
							 newi.setIdBodega( ordenBean.getId_bodega() );
							 newi.setId_orden( ordenBean.getId() );
							 newi.setAmount( 0 );
						}
						newi.setAmount( b.getCantidad() + newi.getAmount() );
						
						
						if( im.add( newi ) ) {
							System.out.println( "added " + newi.getId_product() + " to order...");
							message = "Pedido agregado exitosamente!";
						} else {
							System.out.println( "No se pudo agregar el nuevo inventario...");
						}
					} else {
						System.out.println( "No se pudo modificar inventario ..." );
					}
					
					
				} else {
					System.out.println( "No se pudo agregar detalle..." );
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
	
    private String  validateParameters( String clientidStr, String bodegaidStr, String[] productidStr,String[] amountStr,String[] priceStr ) {
    	String message = "";
    	if( isEmpty(clientidStr) ){
    		message = "No ha seleccionado un cliente";
    	} else if( isEmpty( bodegaidStr )) {
    		message = "No ha seleccionado una bodega";
     	} else if( isEmpty( productidStr ) || isEmpty( amountStr ) || isEmpty( priceStr )) {
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
    private String getUID(){
    	UUID id = UUID.randomUUID();
    	return id.toString();
    }
}
				
							