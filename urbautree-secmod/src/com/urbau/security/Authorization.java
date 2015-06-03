package com.urbau.security;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.urbau.db.ConnectionManager;

public class Authorization {

	public static boolean isAuthorizedOption( int idrol, int idprograma, int idopcion 	){
		
		System.out.println( "requesting authorization to " + idrol + "~" + idprograma + "~" + idopcion );
		
		boolean authorized = false;
		Connection con = null;
		Statement  stmt = null;
		ResultSet  rs  = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT COUNT( * ) FROM OPCIONESXPROGRAMA WHERE ID_ROL='" + idrol + "' AND ID_PROGRAMA='" + idprograma + "' AND ID_OPCION='" + idopcion + "'";
			rs = stmt.executeQuery( sql );
			if( rs.next() && rs.getInt( 1 ) > 0 ){
				return true;
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return authorized;
	}
	
	public static boolean isAuthorizedProgram( int idrol, int idprograma ){
		System.out.println( "requesting authorization to " + idrol + "~" + idprograma  );
		boolean authorized = false;
		Connection con = null;
		Statement  stmt = null;
		ResultSet  rs  = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT COUNT( * ) FROM OPCIONESXPROGRAMA WHERE ID_ROL='" + idrol + "' AND ID_PROGRAMA='" + idprograma + "'";
			rs = stmt.executeQuery( sql );
			if( rs.next() && rs.getInt( 1 ) > 0 ){
				return true;
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return authorized;
	}
	public static boolean isAuthorizedProgram( int idrol, String programa_name ){
		System.out.println( "requesting authorization to " + idrol + "~" + programa_name  );
		boolean authorized = false;
		Connection con = null;
		Statement  stmt = null;
		ResultSet  rs  = null;
		String sql = "SELECT count( * ) FROM OPCIONESXPROGRAMA , programas prg WHERE ID_ROL='"+idrol+"' AND ID_PROGRAMA = prg.id and prg.`PROGRAM_NAME` = '"+programa_name+"'";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery( sql );
			if( rs.next() && rs.getInt( 1 ) > 0 ){
				System.out.println( "authorized: " + idrol + "~" + programa_name  );
				return true;
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		System.out.println( "NOT authorized: " + idrol + "~" + programa_name  + " (" + sql + ")");
		return authorized;
	}
	
	public static boolean isAuthorizedOption( int idrol, String programa_name, int option ){
	
		System.out.println( "requesting authorization to " + idrol + "~" + programa_name + "~" + option );
		Connection con = null; 
		Statement  stmt = null;
		ResultSet  rs  = null;
		String sql = "SELECT count( * ) FROM OPCIONESXPROGRAMA , PROGRAMAS prg WHERE ID_ROL='"+idrol+"' AND ID_PROGRAMA = prg.id and prg.`PROGRAM_NAME` = '"+programa_name+"' AND ID_OPCION='" + option + "'";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			
			rs = stmt.executeQuery( sql );
			if( rs.next() && rs.getInt( 1 ) > 0 ){
				System.out.println( "authorized: " + idrol + "~" + programa_name + "~" + option );
				return true;
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		System.out.println( "NOT authorized: " + idrol + "~" + programa_name  + "~" + option + " (" + sql + ")");
		return false;
	}
	
	
	
}
