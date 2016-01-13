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
import com.urbau.misc.Util;

@WebServlet("/bin/IngresoBodega")
public class IngresoBodega extends Entity {
	private static final long serialVersionUID = 1L;
	public static final String ESTADO_INGRESADO = "I";
	public static final String ESTADO_CANCELADO = "C";
	public static final String ESTADO_DESPACHADO = "D";
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling save orders...");
			HttpSession session = request.getSession();
			//UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			
			String bodegaidStr = request.getParameter( "bodegaid" );
			int bodegaid = Integer.valueOf( bodegaidStr );
			String productidStr[] = request.getParameterValues( "productid" );
			String amountStr[] = request.getParameterValues( "amount" );
			String packStr[] = request.getParameterValues( "pack" );
			
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
					"CARGAS_BODEGA", new String[]{"FECHA","USUARIO"}, new int[]{ Constants.EXTENDED_TYPE_DATE, Constants.EXTENDED_TYPE_INTEGER
			});
			ExtendedFieldsBean carga_bean = new ExtendedFieldsBean();
			carga_bean.putValue("FECHA", Util.getTodayDate() );
			carga_bean.putValue( "USUARIO", String.valueOf( loggedUser.getId() ));
			
			String transaction_id = carga_bodega.addForTransaction( carga_bean );
			
			int carga_id = carga_bodega.getIdFromTransaction( transaction_id );
			carga_bean.setId( carga_id );
					
			ExtendedFieldsBaseMain carga_bodega_detail = new ExtendedFieldsBaseMain( "CARGAS_BODEGA_DETALLE", 
					new String[]{ "ID_CARGA", "ID_PRODUCTO", "UNIDADES_PRODUCTO", "UNITARIO", "PACKING_SELECCIONADO" }, 
					new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER} 
			);
			
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
				
				carga_bodega_detail.add( carga_bean_detalle_bean );
				
					InvetarioBean a = im.get ( prodid, "a", bodegaid );
					if( a == null ){
						a = new InvetarioBean();
						a.setIdBodega( bodegaid );
						a.setId_product( prodid );
						a.setEstatus( "a" );
						a.setAmount( amount * pack );
						
						if( im.add( a ) ) {
							message = "Carga agregada exitosamente!";
						} else {
							System.out.println( "No se pudo agregar el nuevo inventario...");
						}
					} else {
						a.setAmount( a.getAmount() + ( amount * pack ) );
						a.setIdBodega( bodegaid );
						if( im.mod( a ) ) {
							message = "Carga agregada exitosamente!";
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
    private String getUID(){
    	UUID id = UUID.randomUUID();
    	return id.toString();
    }
}
				
							