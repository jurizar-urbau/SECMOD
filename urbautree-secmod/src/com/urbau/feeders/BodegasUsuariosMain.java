package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.BodegaBean;
import com.urbau.beans.BodegaUsuarioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class BodegasUsuariosMain extends AbstractMain {
	
	private final String TABLE_NAME = "BODEGAS_USUARIOS"; 
	
	public ArrayList<BodegaUsuarioBean> get( String q, int from){
		return get( q, from, -1);
	}
	
		public ArrayList<BodegaUsuarioBean> getFromUser( int iduser ){
		
		
		ArrayList<BodegaUsuarioBean> list = new ArrayList<BodegaUsuarioBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
											
			
				String sql="SELECT ID,ID_BODEGA,ID_USUARIO FROM "+TABLE_NAME+" WHERE ID_USUARIO="+ iduser ;
				System.out.println("1sql:"+sql);
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( TABLE_NAME, " WHERE ID_USUARIO="+ iduser );
			
			while( rs.next() ){
				BodegaUsuarioBean bean = new BodegaUsuarioBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdBodega(rs.getInt( 2  ));				
				bean.setIdUsuario(rs.getInt( 3  ));
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
	public ArrayList<BodegaUsuarioBean> get( String q, int from, int limit){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<BodegaUsuarioBean> list = new ArrayList<BodegaUsuarioBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
											
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				String sql="SELECT ID,ID_BODEGA,ID_USUARIO FROM "+TABLE_NAME+" LIMIT " + from + "," + items;
				System.out.println("1sql:"+sql);
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( TABLE_NAME, "" );
				
			} else {
				String rem_where = Util.getBodegaPorUsuarioWhere( q );
				String sql="SELECT ID,ID_BODEGA,ID_USUARIO FROM "+TABLE_NAME+" " + rem_where + " LIMIT " + from + "," + items;
				System.out.println("2sql:"+sql);
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs( TABLE_NAME, rem_where );
			}
			while( rs.next() ){
				BodegaUsuarioBean bean = new BodegaUsuarioBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdBodega(rs.getInt( 2  ));				
				bean.setIdUsuario(rs.getInt( 3  ));
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
	
	public ArrayList<BodegaBean> getForUser(  int user_id ){
		
		ArrayList<BodegaBean> list = new ArrayList<BodegaBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
											
			
			String sql="SELECT BU.ID_BODEGA, BO.NOMBRE FROM BODEGAS_USUARIOS BU, BODEGAS BO WHERE BU.ID_BODEGA = BO.ID AND BU.ID_USUARIO = " + user_id;
			rs = stmt.executeQuery( sql );
			
			while( rs.next() ){
				BodegaBean bean = new BodegaBean();
				bean.setId( rs.getInt( 1 ));
				bean.setNombre( rs.getString( 2 ));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public BodegaUsuarioBean get( int idBodegaCliente ){
		if(  idBodegaCliente < 0){
			return getBlankBean();
		}
		BodegaUsuarioBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT ID,ID_BODEGA,ID_USUARIO FROM "+TABLE_NAME+" WHERE ID_USUARIO='"+idBodegaCliente+"'";
			System.out.println("sql:"+sql);
			rs = stmt.executeQuery( sql);
			while( rs.next() ){
				bean = new BodegaUsuarioBean();
				bean.setId( rs.getInt   ( 1  ));
				bean.setIdBodega(rs.getInt( 2  ));				
				bean.setIdUsuario(rs.getInt( 3  ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
		
	public BodegaUsuarioBean getBlankBean(){
		BodegaUsuarioBean bean = new BodegaUsuarioBean();
		bean.setId(-1);
		bean.setIdUsuario(-1);
		bean.setIdBodega(-1);			
		return bean;
	}
	
	public boolean add( BodegaUsuarioBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE_NAME+
					" (ID_USUARIO,ID_BODEGA) " +
						"VALUES " +
					"("+ bean.getIdUsuario()+","+bean.getIdBodega()+")";
			
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
	public boolean mod( BodegaUsuarioBean bean ){
		if ( bean.getIdUsuario() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE_NAME+" SET " +
					"ID_USUARIO = " + bean.getIdUsuario() + " , " +
					"ID_BODEGA = " + bean.getIdBodega() + " " +					
					"WHERE ID = " + bean.getId(); 					
					
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
	
	public boolean del( BodegaUsuarioBean bean ){
		if ( bean.getIdUsuario() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE_NAME+" WHERE ID_USUARIO = " + bean.getIdUsuario() + " AND ID_BODEGA = " + bean.getIdBodega();
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
		
	
	public boolean duplicate( BodegaUsuarioBean bean ){
		
		if ( bean.getIdUsuario() <= 0||  bean.getIdBodega() <= 0 ){
			return false;
		}
				
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();			
			String sql = "SELECT * from "+TABLE_NAME+" where ID_USUARIO = "+bean.getIdUsuario()+" AND ID_BODEGA = '"+bean.getIdBodega()+"'";
			System.out.println("sql>" + sql);
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
