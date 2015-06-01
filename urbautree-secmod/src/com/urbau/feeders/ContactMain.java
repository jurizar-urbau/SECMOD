package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ContactBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

import static com.urbau.beans.ContactBean.*;

public class ContactMain extends AbstractMain {
	
	public ArrayList<ContactBean> getItems( String q, int from ){
		ArrayList<ContactBean> list = new ArrayList<ContactBean>();
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
				ContactBean bean = getBean(rs);
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	private ContactBean getBean(ResultSet rs) throws Exception {
		ContactBean bean = new ContactBean();
		
		bean.setId(  rs.getInt   ( 1  ));
		bean.setName(  Util.trimString( rs.getString( 2 )));
		bean.setSurname( Util.trimString( rs.getString( 3 )));
		bean.setTel1( Util.trimString( rs.getString( 4 )));
		bean.setTel2(Util.trimString( rs.getString( 5 )));
		bean.setMobile(Util.trimString( rs.getString( 6 )));
		bean.setAsingment(Util.trimString( rs.getString( 7 )));
		bean.setEmail(Util.trimString( rs.getString( 8 )));
		bean.setEmail2(Util.trimString( rs.getString( 9 )));
		bean.setComment(Util.trimString( rs.getString( 10 )));
		bean.setArea(Util.trimString( rs.getString( 11 )));
		bean.setFax(Util.trimString( rs.getString( 12 )));
		bean.setCountry(rs.getInt(13));
		bean.setUser(rs.getInt(14));
		bean.setClient(rs.getInt(15));
		bean.setAddrr1line1(Util.trimString( rs.getString( 16 )));
		bean.setAddrr1line2(Util.trimString( rs.getString( 17 )));
		bean.setMunicipality1(rs.getInt(18));
		bean.setDepto1(rs.getInt(19));
		bean.setAddrr2line1(Util.trimString( rs.getString( 20 )));
		bean.setAddrr2line2(Util.trimString( rs.getString( 21 )));
		bean.setDepto2(rs.getInt(22));
		bean.setMunicipality2(rs.getInt(23));
		
		
		
	
		return bean;
	}



	public ContactBean getItem( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ContactBean bean = null;
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
	
	public ContactBean getBlankBean(){
		ContactBean bean = new ContactBean();
		
		bean.setName("");
		bean.setSurname("");
		bean.setTel1("");
		bean.setTel2("");
		bean.setMobile("");
		bean.setAsingment("");
		bean.setEmail("");
		bean.setEmail2("");
		bean.setComment("");
		bean.setArea("");
		bean.setFax("");
		bean.setCountry(0);
		bean.setUser(0);
		bean.setClient(0);
		bean.setAddrr1line1("");
		bean.setAddrr1line2("");
		bean.setMunicipality1(0);
		bean.setDepto1(0);
		bean.setAddrr2line1("");
		bean.setAddrr2line2("");
		bean.setDepto2(0);
		bean.setMunicipality2(0);
		
		
		return bean;
	}
	public boolean addItem( ContactBean bean ){
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
	private String getSQLInsetStatement(ContactBean bean) {
		String sql = "INSERT INTO "+TABLE+
				" ( " + SQL_FIELDS +") VALUES " +
					
				"('" 
				+ bean.getName() +"','"
				+ bean.getSurname() +"','"
				+ bean.getTel1() +"','"
				+ bean.getTel2() +"','"
				+ bean.getMobile() +"','"
				+ bean.getAsingment() +"','"
				+ bean.getEmail() +"','"
				+ bean.getEmail2() +"','"
				+ bean.getComment() +"','" 
				+ bean.getArea() +"','"  
				+ bean.getCountry() +"','" 
				+ bean.getUser() +"','"
				+ bean.getClient() +"','"
				+ bean.getAddrr1line1() +"','" 
				+ bean.getAddrr1line2() +"','"
				+ bean.getMunicipality1() +"','" 
				+ bean.getDepto1() +"','" 
				+ bean.getAddrr2line1() +"','" 
				+ bean.getAddrr2line2()+"','" 
				+ bean.getDepto2() +"','"
				+ bean.getMunicipality2() 
				+  "')";
		
		return sql;
	}



	public boolean modItem( ContactBean bean ){
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
	
	private String getUpdateSQLStatement(ContactBean bean) {
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



	public boolean delItem( ContactBean bean ){
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
