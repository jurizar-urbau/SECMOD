package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;

import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.BodegaBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;


public class BodegasMain extends AbstractMain {
	public ArrayList<BodegaBean> getBodega( String q, int from ){
		ArrayList<BodegaBean> list = new ArrayList<BodegaBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			int total_regs = 0;
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT ID,NOMBRE,DIRECCION,TELEFONO FROM BODEGAS ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( "SELECT ID,NOMBRE,DIRECCION,TELEFONO,ESTADO FROM BODEGAS  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE);
				total_regs = Util.getTotalRegs( "BODEGAS", "" );
				 
			} else {
				sql = "SELECT ID,NOMBRE,DIRECCION,TELEFONO FROM BODEGAS " + Util.getBodegasWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE + " ORDER BY ID DESC";
				rs = stmt.executeQuery( "SELECT ID,NOMBRE,DIRECCION,TELEFONO,ESTADO FROM BODEGAS " + Util.getBodegasWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				
				total_regs = Util.getTotalRegs( "BODEGAS", Util.getBodegasWhere( q ) );
			}
			System.out.println( "sql: " + sql );
			while( rs.next() ){
				BodegaBean bean = new BodegaBean();
				bean.setTotal_regs( total_regs );
				bean.setId(  rs.getInt   ( 1  ));
				bean.setNombre(  Util.trimString( rs.getString( 2 )));
				bean.setDireccion( Util.trimString( rs.getString( 3 )));
				bean.setTelefono( Util.trimString( rs.getString( 4 )));
				bean.setEstado( rs.getBoolean( 5 ));
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
	
	
	
	public BodegaBean getBodega( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		BodegaBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NOMBRE,DIRECCION,TELEFONO,ESTADO FROM BODEGAS WHERE ID=" + id );
			while( rs.next() ){
				bean = new BodegaBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setNombre(  Util.trimString( rs.getString( 2 )));
				bean.setDireccion( Util.trimString( rs.getString( 3 )));
				bean.setTelefono( Util.trimString( rs.getString( 4 )));
				bean.setEstado( rs.getBoolean( 5 ));			
			}
							
			verificarSiEsBodegaPrincipal(bean);
			
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	
	public void verificarSiEsBodegaPrincipal(BodegaBean bean){
					
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT ID,NOMBRE,DIRECCION,TELEFONO,ESTADO from BODEGAS where ESTADO = '"+1+"'";
							
			PreparedStatement statement = con.prepareStatement(sql); 
			statement.setMaxRows(1); 
			rs = statement.executeQuery();
					
			int idPrincipal = 0;			
			while( rs.next() ){
				idPrincipal = rs.getInt   ( 1  );
			}			
						
			if(idPrincipal == bean.getId()){
				bean.setEstadoEsEditable(true);
			}else{
				bean.setEstadoEsEditable(false);
			}
			
			rs.beforeFirst();
			rs.last();
			int total = rs.getRow();					
			if(total == 1){
				bean.setExisteBodegaPrincipal(true);
								
			}else if(total <= 0){
				bean.setExisteBodegaPrincipal(false);				
			}
								
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public BodegaBean getBlankBean(){
		BodegaBean bean = new BodegaBean();
		bean.setNombre( "" );
		bean.setDireccion( "" );
		bean.setTelefono( "" );
		bean.setEstado(false);		
		verificarSiEsBodegaPrincipal(bean);
		return bean;
	}
	
	public boolean addBodega( BodegaBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO BODEGAS " +
					"(NOMBRE,DIRECCION,TELEFONO,ESTADO) " +
						"VALUES " +
					"('"+ bean.getNombre()+"','"+ bean.getDireccion()+"','"+ bean.getTelefono()+"',"+ bean.getEstado()+")";
			System.out.println("sql: " + sql);
			int total = stmt.executeUpdate( sql );
			
			verificarSiEsBodegaPrincipal(bean);
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean modBodega( BodegaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE BODEGAS SET " +
					"NOMBRE = " + Util.vs( bean.getNombre() ) + ", " +
					"DIRECCION = " + Util.vs( bean.getDireccion() ) + ", " +
					"TELEFONO = " + Util.vs( bean.getTelefono() ) + ", "+
					"ESTADO = " + bean.getEstado()  + " "+
					"WHERE ID = " + bean.getId();
			System.out.println("sql: " + sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean delBodega( BodegaBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM BODEGAS WHERE ID = " + bean.getId();
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
			rs = stmt.executeQuery( "SELECT count(ID) FROM BODEGAS" );
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
