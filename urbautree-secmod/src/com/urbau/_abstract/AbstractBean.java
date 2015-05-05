/**
 * 
 */
package com.urbau._abstract;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.urbau.beans.ClienteBean;
import com.urbau.db.ConnectionManager;
import com.urbau.feeders.ClientesMain;

/**
 * @author jurizar
 *
 */
public class AbstractBean {

	public final String DDMMYYYY = "dd/MM/yyyy";
	public final String DDMMYYYYHHMM = "dd/MM/yyyy HH:mm";
	
	
	public String formatDate( Date date, String format ){
		if ( date == null ){
			return "-";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		return sdf.format( date );
	}
	
	public String getClientShortDescription( int id ){
		ClientesMain cm = new ClientesMain();
		ClienteBean bean = cm.getCliente(id);
		String name = bean.getNombres() + " " + bean.getApellidos();
		return name;
	}
	public int getNext( String table, String field ){
		Connection con = null;
		Statement  stmt= null;
		ResultSet  res = null;
		int next = 1;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "SELECT MAX(" + field + ") FROM " + table;
			res = stmt.executeQuery( sql );
			if( res.next()){
				next = res.getInt( 1 ) + 1; 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, res );
		}
		return next;
	}
}
