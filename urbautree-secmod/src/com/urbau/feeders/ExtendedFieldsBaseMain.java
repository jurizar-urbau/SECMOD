package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.KeyValue;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.ExtendedFieldsFilter;
import com.urbau.misc.Util;

public class ExtendedFieldsBaseMain extends AbstractMain {
		
	private String tablename;
	private String[] field_names;
	private int[] data_types;
	private String raw_fields;
	private String raw_fields_without_id;
	
	public String getTableName(){
		return tablename;
	}
	public String[] getFieldNamesArray(){
		return field_names;
	}
	public int[] getDataTypesArray(){
		return data_types;
	}
	
	public ExtendedFieldsBaseMain( String tablename, String[] field_names, int[] data_types ){
		this.tablename   = tablename;
		this.field_names = field_names;
		this.data_types  = data_types;
		this.raw_fields  = getFieldNamesWithId();
		this.raw_fields_without_id = getFieldNames();
	}
	
	private String getFieldNamesWithId(){
		StringBuffer sb = new StringBuffer();
		sb.append( "ID" );
		for( String s : field_names ){
			sb.append( "," ).append( s );
		}
		return sb.toString();
	}
	
	private String getFieldNames(){
		StringBuffer sb = new StringBuffer();
		for( String s : field_names ){
			sb.append( "," ).append(  s );
		}
		return sb.toString().substring( 1 );
	}
	
	public ArrayList<ExtendedFieldsBean> get( String q, int from ){
		ArrayList<ExtendedFieldsBean> list  = new ArrayList<ExtendedFieldsBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			int total_regs = 0;
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT " + raw_fields + " FROM " + tablename + " ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs(tablename, "" );
				 
			} else {
				//TODO implement 'getWhere' first just for String, later for any type or on demand types...
				sql = "SELECT " + raw_fields + " FROM "+tablename +" " + getWhereClause( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs( tablename, getWhereClause( q ) );
			}
			System.out.println( "excecuted: " + sql );
			while( rs.next() ){
				
				ExtendedFieldsBean bean = new ExtendedFieldsBean();

				bean.setId        ( rs.getInt( 1 ));
				bean.setTotal_regs( total_regs    );
				for( String field : field_names ){
					bean.putValue( field, Util.trimString( rs.getString( field )));
				}
				list.add( bean );
			}
		} catch( Exception e ){
			System.out.println( "sql: [" + sql + "]");
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	
	
	public ArrayList<ExtendedFieldsBean> getSubdetail( String q, int from, KeyValue[] keysAndValues ){
		ArrayList<ExtendedFieldsBean> list  = new ArrayList<ExtendedFieldsBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection(); 
			stmt = con.createStatement();
			int total_regs = 0;
			StringBuffer plusWhere = new StringBuffer();
			for( KeyValue kv : keysAndValues ){
				if( plusWhere.length() > 0 ){
					plusWhere.append( " AND " );
				} else {
					plusWhere.append( " WHERE " );
				}
				plusWhere.append( kv.getKey() ).append( " = '" ).append( kv.getValue() ).append( "'" );
			}
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT " + raw_fields + " FROM " + tablename + " " + plusWhere + " ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				System.out.println( "sql: [" + sql + "]");
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs(tablename, "" );
				 
			} else {
				//TODO implement 'getWhere' first just for String, later for any type or on demand types...
				sql = "SELECT " + raw_fields + " FROM "+tablename +" " + plusWhere + " AND " + Util.getDescriptionWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				System.out.println( "sql: [" + sql + "]");
				rs = stmt.executeQuery( sql);
				total_regs = Util.getTotalRegs( tablename, Util.getDescriptionWhere( q ) );
			}
			while( rs.next() ){
				
				ExtendedFieldsBean bean = new ExtendedFieldsBean();

				bean.setId        ( rs.getInt( 1 ));
				bean.setTotal_regs( total_regs    );
				for( String field : field_names ){
					bean.putValue( field, Util.trimString( rs.getString( field )));
				}
				list.add( bean );
			}
		} catch( Exception e ){
			System.out.println( "sql: [" + sql + "]");
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public ExtendedFieldsBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ExtendedFieldsBean bean = getBlankBean();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "SELECT " + raw_fields + " FROM " + tablename + " WHERE ID=" + id ;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( sql );
			if( rs.next() ){
				bean.setTotal_regs( 1 );
				bean.setId( rs.getInt( 1 ));
				for( String field : field_names ){
					bean.putValue( field, Util.trimString( rs.getString( field )));
				}												
			}
		} catch( Exception e ){
			System.out.println( sql );
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public ExtendedFieldsBean getBlankBean(){
		ExtendedFieldsBean bean = new ExtendedFieldsBean();
		bean.setId         ( -1 );
		bean.setTotal_regs ( 0 );
		bean.setValues     ( new HashMap<String,String>());
		return bean;
	}
	
	public boolean add( ExtendedFieldsBean bean ){
		Connection con = null;
		Statement  stmt= null;
		String sql = "NOT SET";
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			sql = "INSERT INTO "+tablename+
					" (" + raw_fields_without_id + ") " +
						"VALUES " +
					"(" + getQuotedValues( bean ) + ")";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			System.out.println( sql );
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public String addForTransaction( ExtendedFieldsBean bean ){
		Connection con = null;
		Statement  stmt= null;
		String sql = "NOT SET";
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String transid = Util.getRandomTransactionID( "EFT" ); 
			sql = "INSERT INTO "+tablename+
					" (" + raw_fields_without_id + ",TRANSID) " +
						"VALUES " +
					"(" + getQuotedValues( bean ) + ",'" + transid + "')";
			int total = stmt.executeUpdate( sql );
			return total > 0 ? transid :"NULL"; 
			
		} catch (Exception e) {
			System.out.println( sql );
			e.printStackTrace();
			return "NULL";
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public int getIdFromTransaction( String transaction ){
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rec = null;
		String sql = "";
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement(); 
			sql = "SELECT ID FROM "+getTableName()+" WHERE TRANSID='" + transaction + "'";
			rec = stmt.executeQuery( sql );
			if( rec.next() ){
				return rec.getInt( 1 );
			} else {
				System.out.println( "not found for [" + sql + "]");
				return -1;
			}
			
		} catch (Exception e) {
			System.out.println( sql );
			e.printStackTrace();
			return -1;
		} finally {
			ConnectionManager.close( con, stmt, rec );
		}
	}
	
	public boolean mod( ExtendedFieldsBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+tablename+" SET " +
					getFieldNamesWithValues( bean ) + " " +
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
	
	public boolean del( ExtendedFieldsBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM " + tablename + " WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	private String getQuotedValues( ExtendedFieldsBean bean ){
		StringBuffer sb = new StringBuffer();
		
		for( String field_name : field_names ){
			sb.append( "," ).append( getQuotedValue( bean.getValue( field_name ), data_types[ Util.getIndexOf( field_name, field_names ) ]));
		}
		
		return sb.toString().substring( 1 );
	}
	
	private String getQuotedValue( String value, int extended_type ){
		switch (extended_type) {
		case Constants.EXTENDED_TYPE_STRING:
			return "'" + value + "'";
		case Constants.EXTENDED_TYPE_BOOLEAN:
			return  value;
		case Constants.EXTENDED_TYPE_INTEGER:
			return integerValue( value );
		case Constants.EXTENDED_TYPE_DOUBLE:
			return doubleValue( value ) ;
		case Constants.EXTENDED_TYPE_DATE:
			return "NOW()".equals(value)  ? value : Util.isEmpty( value ) ? "null" : "'" + value + "'";
		default:
			return value;
		}
		
	}
	
	public String integerValue( String value ){
		int n=0;
		try {
			n = Integer.parseInt( value );
		} catch (Exception e ){
			
		}
		return "" + n;
	}
	public String doubleValue( String value ){
		double n=0;
		try {
			n = Double.parseDouble( value );
		} catch (Exception e ){
			
		}
		return "" + n;
	}
	public String getFieldNamesWithValues( ExtendedFieldsBean bean ){
		StringBuffer sb = new StringBuffer();
		for( String field_name : field_names ){
			sb.append( "," ).append( field_name ).append( "=" ).append( getQuotedValue( bean.getValue( field_name ), data_types[ Util.getIndexOf( field_name, field_names) ]));
		}
		return sb.substring( 1 );
	}
	
	public ArrayList<ExtendedFieldsBean> getAll(ExtendedFieldsFilter filter) {
		ArrayList<ExtendedFieldsBean> list  = new ArrayList<ExtendedFieldsBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			sql = "SELECT " + raw_fields + " FROM "+tablename +" WHERE " + filter.getWhereClause()  + "  ORDER BY ID DESC";
			
			rs = stmt.executeQuery( sql);
			
			while( rs.next() ){
				
				ExtendedFieldsBean bean = new ExtendedFieldsBean();

				bean.setId        ( rs.getInt( 1 ));
				for( String field : field_names ){
					bean.putValue( field, Util.trimString( rs.getString( field )));
				}
				list.add( bean );
			}
		} catch( Exception e ){
			System.out.println( "sql: [" + sql + "]");
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}	
	public ArrayList<ExtendedFieldsBean> getAll(ExtendedFieldsFilter filter, ExtendedFieldsOrderBy orderBy ) {
		ArrayList<ExtendedFieldsBean> list  = new ArrayList<ExtendedFieldsBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			sql = "SELECT " + raw_fields + " FROM "+tablename +" WHERE " + filter.getWhereClause()  + " " + orderBy.toString();
			
			rs = stmt.executeQuery( sql);
			
			while( rs.next() ){
				
				ExtendedFieldsBean bean = new ExtendedFieldsBean();

				bean.setId        ( rs.getInt( 1 ));
				for( String field : field_names ){
					bean.putValue( field, Util.trimString( rs.getString( field )));
				}
				list.add( bean );
			}
		} catch( Exception e ){
			System.out.println( "sql: [" + sql + "]");
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public ArrayList<ExtendedFieldsBean> getAllWithoutID(ExtendedFieldsFilter filter) {
		ArrayList<ExtendedFieldsBean> list  = new ArrayList<ExtendedFieldsBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			sql = "SELECT " + raw_fields_without_id + " FROM "+tablename +" WHERE " + filter.getWhereClause() ;
			
			rs = stmt.executeQuery( sql);
			
			while( rs.next() ){
				
				ExtendedFieldsBean bean = new ExtendedFieldsBean();

				bean.setId        ( rs.getInt( 1 ));
				for( String field : field_names ){
					bean.putValue( field, Util.trimString( rs.getString( field )));
				}
				list.add( bean );
			}
		} catch( Exception e ){
			System.out.println( "sql: [" + sql + "]");
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}	

	public ExtendedFieldsBean fillBean(String...strings ){
		ExtendedFieldsBean bean = new ExtendedFieldsBean();
		String[] fields = getFieldNamesArray();
		for( int n = 0; n < strings.length; n++ ){
			bean.putValue( fields[ n ], strings[ n ]);
		}
		return bean;
	}
	public String getWhereClause( String q ){
		StringBuffer sb = new StringBuffer();
		for( String field_name : field_names ){
			if( data_types[ Util.getIndexOf( field_name, field_names) ] == Constants.EXTENDED_TYPE_STRING ){
				sb.append( " OR " + field_name + " LIKE '%" + q + "%'" );
			}
		}
		if ( sb.length() > 4 ){
			return " WHERE " + sb.substring( 3 );
		} else {
			return "";
		}
	}
	
}
