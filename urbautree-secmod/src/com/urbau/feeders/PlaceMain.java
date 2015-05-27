package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.PlaceBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

import static com.urbau.beans.PlaceBean.*;

public class PlaceMain extends AbstractMain {
	
	public ArrayList<PlaceBean> getItems( String q, int from ){
		ArrayList<PlaceBean> list = new ArrayList<PlaceBean>();
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
				PlaceBean bean = getBean(rs);
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	private PlaceBean getBean(ResultSet rs) throws Exception {
		PlaceBean bean = new PlaceBean();
		
		bean.setId(  rs.getInt   ( 1  ));
		bean.setName(  Util.trimString( rs.getString( 2 )));
		bean.setDescription(  Util.trimString( rs.getString( 3 )));
		bean.setAddressLine1(  Util.trimString( rs.getString( 4 )));
		bean.setAddressLine2(  Util.trimString( rs.getString( 5 )));
		bean.setDepartment(rs.getInt(6));
		bean.setMunicipality(rs.getInt(7));
		bean.setCountry(rs.getInt(8));
	
		return bean;
	}



	public PlaceBean getItem( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		PlaceBean bean = null;
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
	
	public PlaceBean getBlankBean(){
		PlaceBean bean = new PlaceBean();
		bean.setName("");
		bean.setDescription("");
		bean.setAddressLine1("");
		bean.setAddressLine2("");
		bean.setDepartment(0);
		bean.setMunicipality(0);
		bean.setCountry(0);
		
		return bean;
	}
	public boolean addItem( PlaceBean bean ){
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
	private String getSQLInsetStatement(PlaceBean bean) {
		String sql = "INSERT INTO "+TABLE+
				" ( " + SQL_FIELDS +") VALUES " +
					
				"('" 
				+ bean.getName() +"','"
				+ bean.getDescription() + "','" 
				+ bean.getAddressLine1() + "','"
				+ bean.getAddressLine2() + "','"
				+ bean.getDepartment() + "','" 
				+ bean.getMunicipality() + "','" 
				+ bean.getCountry()
				+  "')";
		
		return sql;
	}



	public boolean modItem( PlaceBean bean ){
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
	
	private String getUpdateSQLStatement(PlaceBean bean) {
		String sql = "UPDATE "+TABLE+
				    " SET NAME = " +NAME_TAG+ 
   				    " , DESCRIPTION = " + DESCRIPTION_TAG + 
					" , ADDRESS_LINE1 = " + ADDRESS_LINE1_TAG + 
					" , ADDRESS_LINE2 = " +ADDRESS_LINE2_TAG + 
					" , DEPARTMENT = " +DEPARTMENT_TAG + 
					" , MUNICIPALITY = "+ MUNICIPALITY_TAG + 
					" , COUNTRY = " +COUNTRY_TAG + 
				   	" WHERE ID = " + bean.getId();
		sql = sql.replace(NAME_TAG,    Util.vs(bean.getName()) ); 
		sql = sql.replace(DESCRIPTION_TAG,    Util.vs(bean.getDescription()) ); 
		sql = sql.replace(ADDRESS_LINE1_TAG,    Util.vs(bean.getAddressLine1()) ); 
		sql = sql.replace(ADDRESS_LINE2_TAG,    Util.vs(bean.getAddressLine2()) ); 
		sql = sql.replace(DEPARTMENT_TAG,    String.valueOf(  bean.getDepartment())); 
		sql = sql.replace(MUNICIPALITY_TAG,  String.valueOf( bean.getMunicipality())) ; 
		sql = sql.replace(COUNTRY_TAG,    String.valueOf( bean.getCountry() )); 
		System.out.println(sql);			
		return sql;
		
	}



	public boolean delItem( PlaceBean bean ){
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
