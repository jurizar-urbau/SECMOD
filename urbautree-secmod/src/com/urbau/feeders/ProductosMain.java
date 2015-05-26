package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ProductoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class ProductosMain extends AbstractMain {
	public ArrayList<ProductoBean> getProducto( String q, int from ){
		ArrayList<ProductoBean> list = new ArrayList<ProductoBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			int total_regs = 0;
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT ID,CODIGO,DESCRIPCION,COEFICIENTE_UNIDAD,PROVEEDOR,PRECIO,PRECIO_IMPORTACION,IMAGE_PATH FROM PRODUCTOS ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( "SELECT ID,CODIGO,DESCRIPCION,COEFICIENTE_UNIDAD,PROVEEDOR,PRECIO,PRECIO_IMPORTACION,IMAGE_PATH FROM PRODUCTOS ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE);
				total_regs = Util.getTotalRegs( "PRODUCTOS", "" );
				 
			} else {
				sql = "SELECT ID,CODIGO,DESCRIPCION,COEFICIENTE_UNIDAD,PROVEEDOR,PRECIO,PRECIO_IMPORTACION,IMAGE_PATH FROM PRODUCTOS " + Util.getProductosWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE + " ORDER BY ID DESC";
				rs = stmt.executeQuery( "SELECT ID,CODIGO,DESCRIPCION,COEFICIENTE_UNIDAD,PROVEEDOR,PRECIO,PRECIO_IMPORTACION,IMAGE_PATH FROM PRODUCTOS " + Util.getProductosWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				
				total_regs = Util.getTotalRegs( "PRODUCTOS", Util.getProductosWhere( q ) );
			}
			System.out.println( "sql: " + sql );
			while( rs.next() ){
				ProductoBean bean = new ProductoBean();
				bean.setTotal_regs( total_regs );
				bean.setId(  rs.getInt   ( 1  ));
				bean.setCodigo( Util.trimString( rs.getString( 2 )) );
				bean.setDescripcion( Util.trimString( rs.getString( 3 )) );
				bean.setCoeficiente_unidad( rs.getInt( 4 ));
				bean.setProveedor( rs.getInt( 5 ));
				bean.setPrecio( rs.getDouble( 6 )); 
				bean.setPrecio_importacion( rs.getDouble( 7 )) ;
				bean.setImage_path( Util.trimString( rs.getString( 8 )) );
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
			System.out.println( "sql: [" + sql + "]");
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public ProductoBean getProducto( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ProductoBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,CODIGO,DESCRIPCION,COEFICIENTE_UNIDAD,PROVEEDOR,PRECIO,PRECIO_IMPORTACION,IMAGE_PATH FROM PRODUCTOS WHERE ID=" + id );
			while( rs.next() ){
				bean = new ProductoBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setCodigo( Util.trimString( rs.getString( 2 )) );
				bean.setDescripcion( Util.trimString( rs.getString( 3 )) );
				bean.setCoeficiente_unidad( rs.getInt( 4 ));
				bean.setProveedor( rs.getInt( 5 ));
				bean.setPrecio( rs.getDouble( 6 )); 
				bean.setPrecio_importacion( rs.getDouble( 7 )) ;
				bean.setImage_path( Util.trimString( rs.getString( 8 )) );
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	
	
	public ProductoBean getBlankBean(){
		ProductoBean bean = new ProductoBean();
		bean.setCodigo( "");
		bean.setDescripcion( "");
		bean.setCoeficiente_unidad(-1);
		bean.setProveedor(-1);
		bean.setPrecio( 0); 
		bean.setPrecio_importacion( 0) ;
		bean.setImage_path( "");
		return bean;
	}
	public boolean addProducto( ProductoBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO PRODUCTOS " +
					"(CODIGO,DESCRIPCION,COEFICIENTE_UNIDAD,PROVEEDOR,PRECIO,PRECIO_IMPORTACION,IMAGE_PATH) " +
						"VALUES " +
					"('"+ bean.getCodigo()+"','"+ bean.getDescripcion()+"',"+ bean.getCoeficiente_unidad()+","+ bean.getProveedor()+","+ bean.getPrecio()+","+ bean.getPrecio_importacion()+",'"+ bean.getImage_path()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean modProducto( ProductoBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE ProductoS SET " +
					
					"CODIGO = " + Util.vs( bean.getCodigo() ) + ", " +
					"DESCRIPCION = " + Util.vs( bean.getDescripcion() ) + ", " +
					"COEFICIENTE_UNIDAD = " + bean.getCoeficiente_unidad()  + ", "+
					"PROVEEDOR = " + bean.getProveedor() + ", " +
					"PRECIO = " + bean.getPrecio() + ", " +
					"PRECIO_IMPORTACION = " + bean.getPrecio_importacion() + ", " +
					"IMAGE_PATH = " + Util.vs( bean.getImage_path() ) + " " +
					"WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean delProducto( ProductoBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM PRODUCTOS WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public long count( ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		long count = 0;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT count(ID) FROM PRODUCTOS" );
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
	
	

	public static int getProgramId() {
		return 1;
	}

	
	
}