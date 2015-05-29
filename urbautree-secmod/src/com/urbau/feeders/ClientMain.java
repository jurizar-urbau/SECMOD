package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ClientBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

import static com.urbau.beans.ClientBean.*;

public class ClientMain extends AbstractMain {
	
	public ArrayList<ClientBean> getItems( String q, int from ){
		ArrayList<ClientBean> list = new ArrayList<ClientBean>();
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
				ClientBean bean = getBean(rs);
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	private ClientBean getBean(ResultSet rs) throws Exception {
		ClientBean bean = new ClientBean();
		
		bean.setId(  rs.getInt   ( 1  ));
		bean.setRzsocial(Util.trimString( rs.getString( 2 )));
		bean.setClient(Util.trimString( rs.getString( 3 )));
		bean.setFax(Util.trimString( rs.getString( 4 )));
		bean.setFaxalt(Util.trimString( rs.getString( 5 )));
		bean.setTel(Util.trimString( rs.getString( 6 )));
		bean.setTelalt(Util.trimString( rs.getString( 7 )));
		bean.setNumfiscal(Util.trimString( rs.getString( 8 )));
		bean.setAddrfiscal(Util.trimString( rs.getString( 9 )));
		bean.setEmail(Util.trimString( rs.getString( 10 )));
		bean.setAddrship(Util.trimString( rs.getString( 11 )));
		bean.setCountry(rs.getInt(12));
		bean.setTipo_cliente(rs.getInt(13));
		bean.setSeller(rs.getInt(14));
		
		return bean;
	}



	public ClientBean getItem( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ClientBean bean = null;
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
	
	public ClientBean getBlankBean(){
		ClientBean bean = new ClientBean();
		bean.setRzsocial("");
		bean.setClient("");
		bean.setFax("");
		bean.setFaxalt("");
		bean.setTel("");
		bean.setTelalt("");
		bean.setNumfiscal("");
		bean.setNumfiscal("");
		bean.setAddrfiscal("");
		bean.setEmail("");
		bean.setRating(0);
		bean.setAddrship("");
		bean.setCountry(0);
		bean.setTipo_cliente(0);
		bean.setSeller(0);
		
		
		return bean;
	}
	public boolean addItem( ClientBean bean ){
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
	private String getSQLInsetStatement(ClientBean bean) {
		String sql = "INSERT INTO "+TABLE+
				" ( " + SQL_FIELDS +") VALUES " +
					
				"('" 
				+ bean.getRzsocial() +"','"
				+ bean.getClient()  +"','" 
				+ bean.getFax()  +"','" 
				+ bean.getFaxalt()  +"','" 
				+ bean.getTel()  +"','" 
				+ bean.getTelalt()  +"','" 
				+ bean.getNumfiscal()  +"','"
				+ bean.getAddrfiscal()  +"','" 
				+ bean.getEmail()  +"','"  
				+ String.valueOf(bean.getRating())  +"','" 
				+ bean.getCountry()  +"','" 
				+ bean.getTipo_cliente()  +"','" 
				+ bean.getSeller()
				+  "')";
		
		return sql;
	}



	public boolean modItem( ClientBean bean ){
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
	
	private String getUpdateSQLStatement(ClientBean bean) {
		String sql = "UPDATE "+TABLE+
				    " SET RZSOCIAL = " +RZSOCIAL_TAG+ 
   				    " , CLIENT = " + CLIENT_TAG + 
					" , FAX = " + FAX_TAG + 
					" , FAXALT = " +FAXALT_TAG + 
					" , TEL = " +TEL_TAG + 
					" , TELALT = "+ TELALT_TAG + 
					" , NUMFISCAL = " +NUMFISCAL_TAG + 
					" , ADDRFISCAL = " +ADDRFISCAL_TAG + 
					" , EMAIL = " +EMAIL_TAG + 
					" , RATING = " +RATING_TAG + 
					" , ADDRSHIP = " +ADDRSHIP_TAG + 
					" , COUNTRY = " +COUNTRY_TAG + 
					" , TIPO_CLIENTE = " +TIPO_CLIENTE_TAG + 
					" , SELLER = " +SELLER_TAG + 
				   	" WHERE ID = " + bean.getId();
		sql = sql.replace(RZSOCIAL_TAG,  Util.vs(bean.getRzsocial()) ); 
		sql = sql.replace(CLIENT_TAG,    Util.vs(bean.getClient()) ); 
		sql = sql.replace(FAX_TAG,    	 Util.vs(bean.getFax()) ); 
		sql = sql.replace(FAXALT_TAG,    Util.vs(bean.getFaxalt()) ); 
		sql = sql.replace(TEL_TAG,       Util.vs(bean.getTel()) ); 
		sql = sql.replace(TELALT_TAG,    Util.vs(bean.getTelalt()) ); 
		sql = sql.replace(NUMFISCAL_TAG, Util.vs(bean.getNumfiscal()) ); 
		sql = sql.replace(ADDRFISCAL_TAG,Util.vs(bean.getAddrfiscal()) ); 
		sql = sql.replace(EMAIL_TAG,     Util.vs(bean.getEmail()) ); 
		sql = sql.replace(RATING_TAG,    String.valueOf(bean.getRating()) ); 
		sql = sql.replace(ADDRSHIP_TAG,  Util.vs(bean.getAddrship()) ); 
		sql = sql.replace(COUNTRY_TAG,  String.valueOf( bean.getCountry() )); 
		sql = sql.replace(TIPO_CLIENTE_TAG,    String.valueOf(bean.getTipo_cliente()) ); 
		sql = sql.replace(SELLER_TAG,    String.valueOf(bean.getSeller()) ); 
		
	
		System.out.println(sql);			
		return sql;
		
	}



	public boolean delItem( ClientBean bean ){
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
