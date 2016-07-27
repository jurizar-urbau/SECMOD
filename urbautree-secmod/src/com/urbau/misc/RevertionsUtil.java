package com.urbau.misc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import org.json.simple.JSONObject;

import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.InvetarioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.InventariosMain;

public class RevertionsUtil {

//	
//	public String revertBuy( int correlativo, int bodega, String codigo, int cantidad ){
//		
//	}
	
	@SuppressWarnings("unchecked")
	public String revertLoad( int correlativo, int bodega, String codigo, int cantidad ){
		Connection c =  null;
		Statement  s = null;
		ResultSet  r = null;
		JSONObject jsonObject = new JSONObject();				
		
		
		String sql = "SELECT " + 
							"DETALLE.ID, DETALLE.UNIDADES_PRODUCTO, " + 
							"DETALLE.UNITARIO,PRODUCTO.ID " + 
						"FROM  " +
							"CARGAS_BODEGA_DETALLE DETALLE, " +
							"PRODUCTOS PRODUCTO,CARGAS_BODEGA CARGA " + 
						"WHERE  " +
							"CARGA.ID = DETALLE.ID_CARGA AND " + 
							"CARGA.CORRELATIVO = "+correlativo+" AND  " +
							"CARGA.BODEGA = "+bodega+"  AND  " +
							"DETALLE.ID_PRODUCTO = PRODUCTO.ID AND " + 
							"PRODUCTO.CODIGO='"+codigo+"'"; 
		try {
			c = ConnectionManager.getConnection();
			s = c.createStatement();
			r = s.executeQuery( sql );
			if ( r.next() ){
				jsonObject.put("found", true );
				int id = r.getInt( 1 );
				int unidades = r.getInt( 2 );
				int producto = r.getInt( 4 );
				
				InventariosMain inventarioMain = new InventariosMain();
				InvetarioBean inventario = inventarioMain.get( producto, "a", bodega );
				
				System.out.println( "INVENTARIO:" );
				System.out.println("id:"+inventario.getId());
				System.out.println( "amount:"+ inventario.getAmount());
				
				
				
				boolean deleteReg = false;
				
				if( cantidad == unidades ){
					deleteReg = true;
				}
				
				inventario.setAmount( inventario.getAmount() - cantidad );
				if ( inventarioMain.mod(inventario)){
					jsonObject.put( "status", "ok" );
					jsonObject.put( "message", "Eliminacion exitosa" );
				} else {
					jsonObject.put( "status", "fail" );
					jsonObject.put( "message", "Eliminacion no exitosa" );
				}
				ExtendedFieldsBaseMain cargaDetalleMain = new ExtendedFieldsBaseMain( "CARGAS_BODEGA_DETALLE", 
						new String[]{
								"UNIDADES_PRODUCTO",
								"UNITARIO",
								"PACKING_SELECCIONADO"
						}, 
						new int[]{
								Constants.EXTENDED_TYPE_INTEGER,
								Constants.EXTENDED_TYPE_INTEGER,
								Constants.EXTENDED_TYPE_INTEGER
						});
				
				ExtendedFieldsBean cargaDetalleBean = cargaDetalleMain.get(id);
				System.out.println( ">updating carga" );
				System.out.println( ">" + cargaDetalleBean.getId() );
				System.out.println( ">" + cargaDetalleBean.getValue("UNIDADES_PRODUCTO") );
				System.out.println( ">" + cargaDetalleBean.getValue("UNITARIO") );
				System.out.println( ">" + cargaDetalleBean.getValue("PACKING_SELECCIONADO") );
				
				System.out.println( "===================================================================" );
				
				if( deleteReg ){
					System.out.println( ">Object will be deleted" );
					cargaDetalleMain.del(cargaDetalleBean);
				} else {
					int storedUnidades = Integer.valueOf( cargaDetalleBean.getValue("UNIDADES_PRODUCTO")  );
					int storedUnitario = Integer.valueOf( cargaDetalleBean.getValue("UNITARIO")  );
					int storedPacking  = Integer.valueOf( cargaDetalleBean.getValue("PACKING_SELECCIONADO")  );
					
					if( storedPacking == 1 ){
						storedUnidades = storedUnidades - cantidad;
						storedUnitario = storedUnitario - cantidad;
						
						cargaDetalleBean.putValue("UNIDADES_PRODUCTO", String.valueOf( storedUnidades ) );
						cargaDetalleBean.putValue("UNITARIO",          String.valueOf( storedUnitario ) );
					}
					
					System.out.println( ">Object to save" );
					System.out.println( ">" + cargaDetalleBean.getId() );
					System.out.println( ">" + cargaDetalleBean.getValue("UNIDADES_PRODUCTO") );
					System.out.println( ">" + cargaDetalleBean.getValue("UNITARIO") );
					System.out.println( ">" + cargaDetalleBean.getValue("PACKING_SELECCIONADO") );
					boolean saved = cargaDetalleMain.mod(cargaDetalleBean);
					jsonObject.put("cargaDetailDeleted", saved );
				}
				
			} else {
				jsonObject.put("found", false );
				jsonObject.put( "message", "Carga no encontrada" );
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonObject.toJSONString();
	}
}
