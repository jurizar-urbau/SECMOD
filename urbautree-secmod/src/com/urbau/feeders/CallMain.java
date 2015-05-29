package com.urbau.feeders;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.CallsBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

import static com.urbau.beans.CallsBean.*;

public class CallMain extends AbstractMain {
	
	public ArrayList<CallsBean> getItems( String q, int from ){
		ArrayList<CallsBean> list = new ArrayList<CallsBean>();
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
				CallsBean bean = getBean(rs);
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	private CallsBean getBean(ResultSet rs) throws Exception {
		CallsBean bean = new CallsBean();
		
		bean.setId(  rs.getInt   ( 1  ));
		bean.setTopic(Util.trimString( rs.getString( 2 )));
		bean.setCallDate(rs.getDate(3));
		bean.setReason(rs.getInt(4));
		bean.setClient(rs.getInt(5));;
		bean.setDescription(Util.trimString( rs.getString( 6 )));
		bean.setType(rs.getInt(7));
		bean.setStatus(rs.getInt(8));
		bean.setSeller(rs.getInt(9));
		bean.setContact(rs.getInt(10));
		
		return bean;
	}



	public CallsBean getItem( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		CallsBean bean = null;
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
				bean = getBean(rs);
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public CallsBean getBlankBean(){
		CallsBean bean = new CallsBean();
		bean.setTopic("");
		
		bean.setCallDate(new Date(0));
		bean.setReason(0);
		bean.setClient(0);
		bean.setDescription("");
		bean.setType(0);
		bean.setStatus(0);
		bean.setSeller(0);
		bean.setContact(0);
		
		
		return bean;
	}
	public boolean addItem( CallsBean bean ){
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
	private String getSQLInsetStatement(CallsBean bean) {
		String sql = "INSERT INTO "+TABLE+
				" ( " + SQL_FIELDS +") VALUES " +
					
				"('" 
				+ bean.getTopic() +"','"
				+ bean.getCallDate().toString() + "','" 
				+ bean.getReason() + "','" 
				+ bean.getClient() + "','" 
				+ bean.getDescription() + "','" 
				+ bean.getType() + "','" 
				+ bean.getStatus() + "','" 
				+ bean.getSeller() + "','" 
				+ bean.getContact() 
				+  "')";
		
		return sql;
	}



	public boolean modItem( CallsBean bean ){
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
	
	private String getUpdateSQLStatement(CallsBean bean) {
		String sql = "UPDATE "+TABLE+
				    " SET TOPIC = " +TOPIC_TAG+ 
				    " , DATE_CALL = " + DATE_CALL_TAG + 
				    " , REASON = " + REASON_TAG + 
				    " , CLIENT = " + CLIENT_TAG + 
				    " , DESCRIPTION = " + DESCRIPTION_TAG + 
				    " , TYPE = " + TYPE_TAG + 
				    " , STATUS = " + STATUS_TAG + 
				    " , SELLER = " + SELLER_TAG + 
   				    " , CONTACT = " + CONTACT_TAG + 
					
				   	" WHERE ID = " + bean.getId();
		sql = sql.replace(TOPIC_TAG,    Util.vs(bean.getTopic()) ); 
		sql = sql.replace(DATE_CALL_TAG,    Util.vs(bean.getCallDate().toString()) ); 
		sql = sql.replace(REASON_TAG,    String.valueOf( bean.getReason()) ); 
		sql = sql.replace(CLIENT_TAG,    String.valueOf( bean.getClient()) ); 
		sql = sql.replace(DESCRIPTION_TAG,    String.valueOf(  bean.getDescription())); 
		sql = sql.replace(TYPE_TAG,  String.valueOf( bean.getType())) ; 
		sql = sql.replace(STATUS_TAG,    String.valueOf( bean.getStatus() )); 
		sql = sql.replace(SELLER_TAG,    String.valueOf( bean.getSeller() )); 
		sql = sql.replace(CONTACT_TAG,    String.valueOf( bean.getContact() )); 
		System.out.println(sql);			
		return sql;
		
	}



	public boolean delItem( CallsBean bean ){
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
