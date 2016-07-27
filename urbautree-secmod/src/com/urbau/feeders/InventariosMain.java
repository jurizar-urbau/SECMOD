package com.urbau.feeders;


import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.InvetarioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;
import com.urbau.misc.InventarioHelper;

public class InventariosMain extends AbstractMain {
	
	private final String TABLE_NAME = "INV"; 
	
	public ArrayList<InvetarioBean> get( String q, int from, int idBodega ){
		return get( q, from, -1, idBodega );
	}
	
	public ArrayList<InvetarioBean> get( String q, int from, int limit, int idBodega ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<InvetarioBean> list = new ArrayList<InvetarioBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			InventarioHelper invHelper = new InventarioHelper();
			invHelper.addBodega( idBodega );
			
			String bodegaTabla = TABLE_NAME+idBodega;
			
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				String sql = "SELECT "+ bodegaTabla+".ID_PRODUCT,"+bodegaTabla+".ESTATUS,"+bodegaTabla+".AMOUNT,PROD.CODIGO,PROD.DESCRIPCION,PROD.COEFICIENTE_UNIDAD,PROD.PROVEEDOR,PROD.PRECIO,PROD.PRECIO_1,PROD.PRECIO_2,PROD.PRECIO_3,PROD.PRECIO_4,PROD.IMAGE_PATH,PROD.STOCK_MINIMO FROM "+bodegaTabla+" INNER JOIN PRODUCTOS AS PROD ON "+ bodegaTabla+".ID_PRODUCT=PROD.ID  LIMIT " + from + "," + items;
				
				System.out.println("sql: "+sql);
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( TABLE_NAME+idBodega, "" );
			} else {
				String rem_where = Util.getMonedasWhere( q );
				//String sql = "SELECT ID_PRODUCT,ESTATUS,AMOUNT FROM "+TABLE_NAME+idBodega+" " + rem_where + " LIMIT " + from + "," + items;
				String sql = "SELECT "+ bodegaTabla+".ID_PRODUCT,"+bodegaTabla+".ESTATUS,"+bodegaTabla+".AMOUNT," +
						"PROD.CODIGO,PROD.DESCRIPCION,PROD.COEFICIENTE_UNIDAD,PROD.PROVEEDOR,PROD.PRECIO,PROD.PRECIO_1,PROD.PRECIO_2,PROD.PRECIO_3,PROD.PRECIO_4,PROD.IMAGE_PATH,PROD.STOCK_MINIMO " +
						"FROM "+bodegaTabla+" INNER JOIN PRODUCTOS AS PROD ON "+ bodegaTabla+".ID_PRODUCT=PROD.ID  LIMIT " + from + "," + items;
				System.out.println("sql: "+sql);
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( TABLE_NAME+idBodega, rem_where );
			}
			while( rs.next() ){
				InvetarioBean bean = new InvetarioBean();
				bean.setId_product( rs.getInt   ( 1  ));
				bean.setEstatus( Util.trimString( rs.getString( 2  )));
				bean.setAmount( rs.getInt( 3 ));
				
				bean.setProdCodigo(Util.trimString(rs.getString(4)));
				bean.setProdDescripcion(Util.trimString(rs.getString(5)));
				bean.setProdCoeficienteUnidad(rs.getInt( 6 ));
				bean.setProdProveedor(rs.getInt( 7 ));
				bean.setProdPrecio(rs.getDouble(8));
				bean.setProdPrecio1(rs.getDouble(9));
				bean.setProdPrecio2(rs.getDouble(10));
				bean.setProdPrecio3(rs.getDouble(11));
				bean.setProdPrecio4(rs.getDouble(12));
				bean.setProdImagePath(Util.trimString(rs.getString(13)));
				bean.setProdStockMinimo(rs.getInt( 14 ));
								
				bean.setTotal_regs( total_regs );
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public InvetarioBean get( int product_id, String estatus, int idBodega ){
		if( product_id < 0  || null == estatus){
			return getBlankBean();
		}
		InvetarioBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String query = "SELECT ID_PRODUCT,ESTATUS,AMOUNT,ID_ORDEN FROM "+TABLE_NAME+idBodega+" WHERE ID_PRODUCT=" + product_id +" AND ESTATUS='"+estatus+"'";
			System.out.println( "looking for products in store:" +  query );
			rs = stmt.executeQuery( query);
			while( rs.next() ){
				bean = new InvetarioBean();
				bean.setId( idBodega );
			    bean.setId_product(  rs.getInt   ( 1  ));
			    bean.setEstatus(  Util.trimString( rs.getString( 2 )));												
			    bean.setAmount(  rs.getInt( 3 ));
			    bean.setId_orden( rs.getInt( 4 ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public InvetarioBean get( int product_id, String estatus, int idBodega, int idOrden ){
		if( product_id < 0  || null == estatus){
			return getBlankBean();
		}
		InvetarioBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String query = "SELECT ID_PRODUCT,ESTATUS,AMOUNT,ID_ORDEN FROM "+TABLE_NAME+idBodega+" WHERE ID_PRODUCT=" + product_id +" AND ESTATUS='"+estatus+"' AND ID_ORDEN=" + idOrden;
			System.out.println("query:"+query);
			rs = stmt.executeQuery( query);
			while( rs.next() ){
				bean = new InvetarioBean();
				bean.setId( idBodega );
			    bean.setId_product(  rs.getInt   ( 1  ));
			    bean.setEstatus(  Util.trimString( rs.getString( 2 )));												
			    bean.setAmount(  rs.getInt( 3 ));
			    bean.setId_orden( rs.getInt( 4 ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public InvetarioBean getBlankBean(){
		InvetarioBean bean = new InvetarioBean();
		
		bean.setId_product(-1);
		bean.setEstatus("");
		bean.setAmount(0);	
		bean.setId_orden(0);	
		return bean;
	}
	
	
	public boolean add( InvetarioBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			
			InventarioHelper invHelper = new InventarioHelper();
			invHelper.addBodega( bean.getIdBodega() );
			
			String sql = "INSERT INTO "+TABLE_NAME+bean.getIdBodega()+
					" (ID_PRODUCT,ESTATUS,AMOUNT,ID_ORDEN) " +
						"VALUES " +
					"("+ bean.getId_product()+",'"+bean.getEstatus()+"',"+bean.getAmount()+"," + bean.getId_orden() + ")";
			
			System.out.println(sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( InvetarioBean bean ){
		if ( bean.getIdBodega() <= 0 ){
			System.out.println("bodega id["+ bean.getId() + "]" );
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+bean.getIdBodega()+" SET " +
					"ID_PRODUCT = " + bean.getId_product() + " , " +
					"ESTATUS = " + Util.vs( bean.getEstatus() ) + ", " +
					"ID_ORDEN = " +bean.getId_orden()  + ", " +
					"AMOUNT = " + bean.getAmount() + " " +
					"WHERE ID_PRODUCT = " + bean.getId_product() + " " + 
					"AND ESTATUS = " + Util.vs( bean.getEstatus() );
					
			System.out.println(sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean modWithoutStatus( InvetarioBean bean ){
		if ( bean.getIdBodega() <= 0 ){
			System.out.println("bodega id["+ bean.getId() + "]" );
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+bean.getIdBodega()+" SET " +
					"ESTATUS = " + Util.vs( bean.getEstatus() ) + ", " +
					"AMOUNT = " + bean.getAmount() + ", " +
					"ID_USUARIO = " + bean.getId_usuario() +
					" WHERE " +
			"ID_PRODUCT = " + bean.getId_product() + " AND " +
			"ID_ORDEN = " +bean.getId_orden() ;
			
					
			System.out.println(sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( InvetarioBean bean ){
		if ( bean.getIdBodega() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE_NAME+bean.getIdBodega()+" WHERE ID_PRODUCT = " + bean.getId_product() + " AND ESTATUS = '"+bean.getEstatus()+"' AND ID_ORDEN=" + bean.getId_orden();
			System.out.println("sql:"+sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	/*
	 * Se necesita agregar el idBodega para la tabla de inventario
	public long count( ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		long count = 0;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT count(ID_PRODUCT,ESTATUS) FROM " + TABLE_NAME );
			if( rs.next() ){
				count = rs.getLong( 1 );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return count;
	}
	*/
	
	public boolean duplicate( InvetarioBean bean ){
		
		if ( bean.getId_product() <= 0 || null == bean.getEstatus() ||  bean.getIdBodega() <= 0 ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null; 
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+bean.getIdBodega()+" where ID_PRODUCT = "+bean.getId_product()+" AND ESTATUS = '"+bean.getEstatus()+"'";
			rs = stmt.executeQuery(sql);			
			rs.beforeFirst();
			rs.last();
			int total = rs.getRow();			
			return total >= 1;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public static int getProgramId() {
		return 1;
	}
	
	
}
