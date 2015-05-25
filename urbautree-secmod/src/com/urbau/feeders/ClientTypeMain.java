package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ClientTypeBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

import static com.urbau.beans.ClientTypeBean.*;

public class ClientTypeMain extends AbstractMain {
	
	public ArrayList<ClientTypeBean> getItems( String q, int from ){
		ArrayList<ClientTypeBean> list = new ArrayList<ClientTypeBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( SQL_STATMENT
						 				+TABLE+" LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );

			} else {
				rs = stmt.executeQuery( SQL_STATMENT + TABLE + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			while( rs.next() ){
				ClientTypeBean bean = new ClientTypeBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setType(  Util.trimString( rs.getString( 2 )));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public ClientTypeBean getItem( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ClientTypeBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			System.out.println(SQL_STATMENT
					+TABLE +" WHERE ID=" + id);
			rs = stmt.executeQuery( SQL_STATMENT
					+TABLE +" WHERE ID=" + id );
			
			while( rs.next() ){
				bean = new ClientTypeBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setType(  Util.trimString( rs.getString( 2 )));
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public ClientTypeBean getBlankBean(){
		ClientTypeBean bean = new ClientTypeBean();
		bean.setType("");
		return bean;
	}
	public boolean addItem( ClientTypeBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = getSQLInsetStatement(bean);
			
			
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	private String getSQLInsetStatement(ClientTypeBean bean) {
		String sql = "INSERT INTO "+TABLE+
				" ( " + SQL_FIELDS +") VALUES " +
					
				"('" +bean.getType()+  "')";
		
		return sql;
	}



	public boolean modItem( ClientTypeBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = getUpdateSQLStatement(bean);
			
					
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	private String getUpdateSQLStatement(ClientTypeBean bean) {
		String sql = "UPDATE "+TABLE+
				   " SET TIPO = " +TYPE_TAG+ 
				   	" WHERE ID = " + bean.getId();;
		sql = sql.replace(TYPE_TAG,    Util.vs(bean.getType()) ); 
		System.out.println(sql);			
		return sql;
		
	}



	public boolean delItem( ClientTypeBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE+" WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
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
