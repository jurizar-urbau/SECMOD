package com.urbau.servlet.entity;

import java.io.IOException;

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

@WebServlet("/bin/SalidaBodega")
public class SalidaBodega extends Entity {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String bodegaidStr = request.getParameter( "bodegaid" );
			int bodegaid = Integer.valueOf( bodegaidStr );
			
			String productidStr[] = request.getParameterValues( "productid" );
			String amountStr[] = request.getParameterValues( "amount" );
			String packStr[] = request.getParameterValues( "pack" );
			String observaciones = request.getParameter("observaciones" );
			 
			String message = validateParameters( bodegaidStr, productidStr, amountStr, packStr );
			
			if( message.length() > 0 ){
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			
			message = "No se pudo crear la salida.";
			
			InventariosMain im = new InventariosMain();
			
			UsuarioBean loggedUser = getLoggedUser(session);
			
			ExtendedFieldsBaseMain salida_bodega = new ExtendedFieldsBaseMain( 
					"SALIDAS_BODEGA", new String[]{"BODEGA","FECHA","USUARIO","CORRELATIVO","OBSERVACIONES"}, new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_DATE, Constants.EXTENDED_TYPE_INTEGER, Constants.EXTENDED_TYPE_INTEGER, Constants.EXTENDED_TYPE_STRING
			});
			ExtendedFieldsBean salida_bean = new ExtendedFieldsBean();
			
			CorrelativosUtil correlativosUtil = new CorrelativosUtil();
			
			int next = correlativosUtil.getNextAndAdvance( "SALIDAS_BODEGA_" + bodegaid );
			
			salida_bean.putValue("BODEGA", String.valueOf( bodegaid)  );
			salida_bean.putValue("FECHA", "NOW()" );
			salida_bean.putValue( "USUARIO", String.valueOf( loggedUser.getId() ));
			salida_bean.putValue( "CORRELATIVO", String.valueOf( next ));
			salida_bean.putValue( "OBSERVACIONES", observaciones );
			
			String transaction_id = salida_bodega.addForTransaction( salida_bean );
			
			int salida_id = salida_bodega.getIdFromTransaction( transaction_id );
			salida_bean.setId( salida_id );
					
			ExtendedFieldsBaseMain salida_bodega_detail = new ExtendedFieldsBaseMain( "SALIDAS_BODEGA_DETALLE", 
					new String[]{ "ID_SALIDA", "ID_PRODUCTO", "UNIDADES_PRODUCTO", "UNITARIO", "PACKING_SELECCIONADO" }, 
					new int[]{ Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER} 
			);
			
			for( int i = 0; i < productidStr.length; i++ ){
				int prodid = Integer.valueOf( productidStr[ i ] );
				int amount = Integer.valueOf( amountStr[ i ] );
				int pack = Integer.valueOf( packStr[ i ] );
				
				ExtendedFieldsBean salida_bodega_detalle_bean = new ExtendedFieldsBean();
				
				
				salida_bodega_detalle_bean.putValue( "ID_SALIDA", String.valueOf(  salida_id ));
				salida_bodega_detalle_bean.putValue( "ID_PRODUCTO", String.valueOf( prodid ));
				salida_bodega_detalle_bean.putValue( "UNIDADES_PRODUCTO", String.valueOf( amount * pack ));
				salida_bodega_detalle_bean.putValue( "UNITARIO", String.valueOf( amount ));
				salida_bodega_detalle_bean.putValue( "PACKING_SELECCIONADO", String.valueOf( pack ));
				
				salida_bodega_detail.add( salida_bodega_detalle_bean );
				
					InvetarioBean a = im.get ( prodid, "a", bodegaid );
					if( a == null ){ 
						message = "error|Producto no existe en bodega!";
					} else {
						a.setAmount( a.getAmount() - ( amount * pack ) );
						a.setIdBodega( bodegaid );
						if( im.mod( a ) ) {
							message =  salida_id  + "|Carga agregada exitosamente!";
						} else {
							message = "error|No se pudo descargar del inventaio!";
							System.out.println( "No se pudo descargar del inventario...");
						}
					}
			}
			
			response.getOutputStream().write( message.getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
		} catch( Exception exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( ( "error|" + exception.getMessage()).getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
    
    private String  validateParameters( String bodegaidStr, String[] productidStr,String[] amountStr,String[] packStr ) {
    	String message = "";
    	if( Util.isEmpty( bodegaidStr )) {
    		message = "No ha seleccionado una bodega";
     	} else if( Util.isEmpty( productidStr ) || Util.isEmpty( amountStr ) || Util.isEmpty( packStr )) {
    		message = "No ha seleccionado ningun producto";
    	}
    	return message;
    }
}
				
							