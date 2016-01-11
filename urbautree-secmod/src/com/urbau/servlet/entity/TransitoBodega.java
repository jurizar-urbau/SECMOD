package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
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
import com.urbau.misc.ExtendedFieldsFilter;
import com.urbau.misc.InventarioHelper;
import com.urbau.misc.Util;

@WebServlet("/bin/TransitoBodega")
public class TransitoBodega extends Entity {
	private static final long serialVersionUID = 1L;
	public static final String ESTADO_INGRESADO = "I";
	public static final String ESTADO_CANCELADO = "C";
	public static final String ESTADO_DESPACHADO = "D";
	public static final int TRANSIT_PREFIX = 1000000;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "traslado entre bodegas...");
			HttpSession session = request.getSession();
			//UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			Enumeration<String> parameter_list =  request.getParameterNames();
			while( parameter_list.hasMoreElements() ){
				String param_name = parameter_list.nextElement();
				
				System.out.println("parameter: " + param_name + " value [" + Util.arrayToFlat( request.getParameterValues( param_name ) ) + "]" );
			}
			System.out.println( "-------------------------------------------------");
			
			String idStr = request.getParameter( "id" );
			int id = Integer.valueOf( idStr );
			
			ExtendedFieldsBaseMain traslado_head = new ExtendedFieldsBaseMain( "TRASLADOS_HEADER", 
					new String[]{"BODEGA_ORIGEN","BODEGA_DESTINO","FECHA","ESTADO","USUARIO"}, 
					new int[] {Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_DATE,Constants.EXTENDED_TYPE_STRING,Constants.EXTENDED_TYPE_INTEGER}
					);
			
			ExtendedFieldsBaseMain traslado_detail = new ExtendedFieldsBaseMain( "TRASLADOS_DETAIL", 
					new String[]{"ID_TRASLADO","PRODUCTO","UNIDADES","PACKING"}, 
					new int[] {Constants.EXTENDED_TYPE_INTEGER,
					Constants.EXTENDED_TYPE_INTEGER,
					Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_STRING}
					);
			
			
			ExtendedFieldsBean traslado_head_bean = traslado_head.get( id );
			traslado_head_bean.putValue( "ESTADO" , "T" );
			
			String bodegaOrigen  =String.valueOf(  TRANSIT_PREFIX + Integer.valueOf( traslado_head_bean.getValue( "BODEGA_DESTINO" )));
			String bodegaDestino = traslado_head_bean.getValue( "BODEGA_DESTINO" );
			
			
			int bodegaid  = Integer.valueOf( bodegaOrigen );
			int bodega2id = Integer.valueOf( bodegaDestino );
			
			ExtendedFieldsFilter filterDetail =
                    new ExtendedFieldsFilter(
                  		  new String[]{"ID_TRASLADO"}, 
                  		  new int[]{ ExtendedFieldsFilter.EQUALS},
                  		  new int[]{Constants.EXTENDED_TYPE_INTEGER}, 
                  		  new String[]{ String.valueOf( id )});
			
			ArrayList<ExtendedFieldsBean> details = traslado_detail.getAll( filterDetail );
			
			
			String productidStr[] = new String[ details.size() ];
			String amountStr[] = new String[ details.size() ];
			String packStr[] = new String[ details.size() ];
			
			int count = 0;
			for( ExtendedFieldsBean b: details ){
				productidStr[ count ] = b.getValue( "PRODUCTO" );
				amountStr[ count ] = b.getValue( "UNIDADES" );
				packStr[ count ] = b.getValue( "PACKING" );
				count++;
			}
			
			traslado_head.mod( traslado_head_bean );
			
			UsuarioBean user = this.getLoggedUser(session);
			
			String message = validateParameters( bodegaOrigen, bodegaDestino, productidStr, amountStr, packStr );
			
			if( message.length() > 0 ){
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				return;
			}
			
			message = "No se pudo crear el pedido.";
			
			InventariosMain im = new InventariosMain();
			
			
			
			
			for( int i = 0; i < productidStr.length; i++ ){
				int prodid = Integer.valueOf( productidStr[ i ] );
				int amount = Integer.valueOf( amountStr[ i ] );
				int pack = Integer.valueOf( packStr[ i ] );
				
				
				System.out.println( "translating from " + bodegaid + " to " + bodega2id );
					InvetarioBean a = im.get ( prodid, "a", bodegaid );
					InvetarioBean b = im.get ( prodid, "a", bodega2id );
					
					if( b == null ){
						b = new InvetarioBean();
						b.setIdBodega( bodega2id );
						b.setId_product( prodid );
						b.setEstatus( "a" );
						b.setAmount( amount * pack );
						
						a.setAmount( a.getAmount() - ( amount * pack ) );
						a.setIdBodega( bodegaid );
						
						
						
						if( im.mod( a ) ) {
							InventarioHelper ih = new InventarioHelper();
							ih.addBodega( b.getIdBodega() );
							if( im.add( b ) ){
								message =  "C|Carga agregada exitosamente!";
							} else {
								message = "No se pudo crear en bodega destino.";
							}
						} else {
							System.out.println( "No se pudo agregar el nuevo inventario...");
						}
					} else {
						a.setAmount( a.getAmount() - ( amount * pack ) );
						a.setIdBodega( bodegaid );
						b.setAmount( b.getAmount() + ( amount * pack ) );
						b.setIdBodega( bodega2id );
						
						if( im.mod( a ) ) {
							if( im.mod( b ) ){
								message = "C|Carga agregada exitosamente!";	
							} else {
								message = "No se pudo crear en bodega destino";
							}
							
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
	
    private String  validateParameters( String bodegaidStr, String bodegaid2Str, String[] productidStr,String[] amountStr,String[] packStr ) {
    	String message = "";
    	if( isEmpty( bodegaidStr )) {
    		message = "No ha seleccionado bodega origen";
     	} else if( isEmpty( bodegaid2Str )) {
    		message = "No ha seleccionado bodega destino";
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
				
							