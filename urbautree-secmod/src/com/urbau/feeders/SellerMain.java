package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.SellerBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class SellerMain extends AbstractMain {
	private static final String NAME_TAG = "{name}";
	private static final String SUR_NAME_TAG = "{surname}";
	private static final String USER_TAG = "{user}";
	
	private static String SQL_FIELDS = "NAME, SURNAME, USER ";
	private static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	private static String TABLE = "SELLERS";
	
	public ArrayList<SellerBean> getSellers( String q, int from ){
		ArrayList<SellerBean> list = new ArrayList<SellerBean>();
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
				SellerBean bean = new SellerBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setName(  Util.trimString( rs.getString( 2 )));
				bean.setSurname(   Util.trimString( rs.getString( 3 )));
				bean.setUser(Util.trimString( rs.getString( 4 )));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public SellerBean getSeller( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		SellerBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			
			rs = stmt.executeQuery( SQL_STATMENT
					+TABLE +" WHERE ID=" + id );
		
			while( rs.next() ){
				bean = new SellerBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setName(  Util.trimString( rs.getString( 2 )));
				bean.setSurname(   Util.trimString( rs.getString( 3 )));
				bean.setUser(Util.trimString( rs.getString( 4 )));
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public SellerBean getBlankBean(){
		SellerBean bean = new SellerBean();
		bean.setName("");
		bean.setSurname( "");
		bean.setUser("");
		return bean;
	}
	public boolean addSeller( SellerBean bean ){
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
	private String getSQLInsetStatement(SellerBean bean) {
		String sql = "INSERT INTO "+TABLE+
				" ( " + SQL_FIELDS +") VALUES " +
					
				"('"+ bean.getName()+"','" 
				    + bean.getSurname() +"','" 
				    + bean.getUser() +  "')";
		
		return sql;
	}



	public boolean modSeller( SellerBean bean ){
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
	
	private String getUpdateSQLStatement(SellerBean bean) {
		String sql = "UPDATE "+TABLE+" SET NAME = " +NAME_TAG+ 
				   " , SURNAME ="+SUR_NAME_TAG+", USER = "+USER_TAG +	" WHERE ID = " + bean.getId();;
		sql = sql.replace(NAME_TAG,    Util.vs(bean.getName()) ); 
		sql = sql.replace(SUR_NAME_TAG,Util.vs(bean.getSurname()) ); 
		sql = sql.replace(USER_TAG,    Util.vs(bean.getUser()) ); 
		System.out.println(sql);			
		return sql;
		
	}



	public boolean delSeller( SellerBean bean ){
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
