package com.urbau.beans;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import com.urbau.db.ConnectionManager;
import com.urbau.misc.Util;

public class ExtendedFieldsBean {

	private int id;
	private int total_regs;
	
	private Map<String, String> values = new HashMap<String, String>();
	
	public void printValues(){
		System.out.println( "Values:" +  values );
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	
	public Map<String, String> getValues() {
		return values;
	}
	public void setValues(Map<String, String> values) {
		this.values = values;
	}
	
	public void putValue( String key, String value ){
		values.put(key, value);
	}
	public String getValue( String key ){
		String value = values.get( key );
		if( Util.isEmpty( value )){
			return "";
		} else {
			return value;
		}
	}
	public String getValue( String key, String defaultValue  ){
		String value = values.get( key );
		if( Util.isEmpty( value )){
			return defaultValue;
		} else {
			return value;
		}
	}
	public int getValueAsInt( String key ){
		if ( key != null ){
			return Integer.valueOf( getValue( key ));
		} else {
			return -1;	
		}
	}
	
	public String getReferenced( String key, String referenced_table, String description_field ){
		
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "SELECT " + description_field + " FROM " + referenced_table + " WHERE ID=" + getValue( key )  ;
		String value = "";
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( sql );
			if( rs.next() ){
				value = rs.getString( 1 );
			}
		} catch( Exception e ){
			System.out.println( sql );
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return value;
	}
	
}
