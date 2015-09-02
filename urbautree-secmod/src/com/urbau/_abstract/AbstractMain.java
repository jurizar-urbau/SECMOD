/**
 * 
 */
package com.urbau._abstract;


import com.j256.ormlite.support.ConnectionSource;
import com.urbau.db.ConnectionManager;
import com.urbau.db.ORMConnectionManager;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * @author jurizar
 *
 */
public abstract class AbstractMain {
	protected ConnectionSource conSource = null ; 
	
	public ArrayList<String[]> getComboItems( String table ){
        ArrayList<String[]> list = new ArrayList<String[]>();
		Connection con = null;
		Statement  stmt= null;
		ResultSet  res = null;

		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "SELECT CODIGO,NOMBRE FROM "+table+" WHERE VALIDO > 0";
			res = stmt.executeQuery( sql );
			while( res.next()){
                String str [] = new String[]{res.getString(1),res.getString(2)};
				list.add( str );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, res );
		}
		return list;
	}
	
	public String getProgramName(){
		return this.getClass().getName();
	}
	
	protected void closeCon() {
		ORMConnectionManager.close(conSource);
	}
}
