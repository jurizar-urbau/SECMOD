package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import com.urbau.beans.ClienteBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class ClientesMain {
	
	public ArrayList<ClienteBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<ClienteBean> get( String q, int from, int limit ){
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		
		ArrayList<ClienteBean> list = new ArrayList<ClienteBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				String sql = "SELECT ID,NIT,NOMBRES,APELLIDOS,DIRECCION,TELEFONO,CORREO,TIPODECLIENTE,ACEPTA_CREDITO FROM CLIENTES LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql );
				
			} else {
				String sql = "SELECT ID,NIT,NOMBRES,APELLIDOS,DIRECCION,TELEFONO,CORREO,TIPODECLIENTE,ACEPTA_CREDITO FROM CLIENTES " + Util.getClientesWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE ;
				rs = stmt.executeQuery( sql);				
			}
			while( rs.next() ){
				ClienteBean bean = new ClienteBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setNit( Util.trimString( rs.getString( 2 )));
				bean.setNombres(  Util.trimString( rs.getString( 3 )));
				bean.setApellidos( Util.trimString( rs.getString( 4 )));
				bean.setDireccion( Util.trimString( rs.getString( 5 )) );
				bean.setTelefono( Util.trimString( rs.getString( 6 )) );
				bean.setEmail( Util.trimString( rs.getString( 7 )));
				bean.setTipoDeCliente(Util.trimString( rs.getString( 8 )));
				bean.setAcepta_credito( rs.getInt( 9 ) );
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public ClienteBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ClienteBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NIT,NOMBRES,APELLIDOS,DIRECCION,TELEFONO,CORREO,TIPODECLIENTE,ACEPTA_CREDITO FROM CLIENTES WHERE ID=" + id );
			while( rs.next() ){
				bean = new ClienteBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setNit( Util.trimString( rs.getString( 2 )));
				bean.setNombres(  Util.trimString( rs.getString( 3 )));
				bean.setApellidos( Util.trimString( rs.getString( 4 )));
				bean.setDireccion( Util.trimString( rs.getString( 5 )) );
				bean.setTelefono( Util.trimString( rs.getString( 6 )) );
				bean.setEmail( Util.trimString( rs.getString( 7 )));
				bean.setTipoDeCliente( Util.trimString( rs.getString( 8 )));
				bean.setAcepta_credito( rs.getInt( 9 ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public ClienteBean getByNit( String nit ){
		if( nit == null ){
			return null;
		}
		ClienteBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,NIT,NOMBRES,APELLIDOS,DIRECCION,TELEFONO,CORREO,TIPODECLIENTE,ACEPTA_CREDITO FROM CLIENTES WHERE NIT='" + nit + "'" );
			while( rs.next() ){
				bean = new ClienteBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setNit( Util.trimString( rs.getString( 2 )));
				bean.setNombres(  Util.trimString( rs.getString( 3 )));
				bean.setApellidos( Util.trimString( rs.getString( 4 )));
				bean.setDireccion( Util.trimString( rs.getString( 5 )) );
				bean.setTelefono( Util.trimString( rs.getString( 6 )) );
				bean.setEmail( Util.trimString( rs.getString( 7 )));
				bean.setTipoDeCliente( Util.trimString( rs.getString( 8 )));
				bean.setAcepta_credito( rs.getInt( 9 ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public ClienteBean getBlankBean(){
		ClienteBean bean = new ClienteBean();
		bean.setNit(  "" );
		bean.setNombres(  "" );
		bean.setApellidos( "" );
		bean.setDireccion( "" );
		bean.setEmail( "" );
		bean.setTelefono( "" );
		bean.setCelular( "" );
		bean.setFecha_ingreso( new java.util.Date( System.currentTimeMillis() ));
		bean.setObservaciones( "" );
		bean.setTipoDeCliente("");
		bean.setAcepta_credito( -1 );
		return bean;
	}
	
	public boolean add( ClienteBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO CLIENTES ( NIT, NOMBRES, APELLIDOS, DIRECCION, TELEFONO, CORREO, TIPODECLIENTE,ACEPTA_CREDITO ) VALUES " +
						 "('" + bean.getNit() + "','"+bean.getNombres()+"','"+bean.getApellidos()+"','"+bean.getDireccion()+"','"+bean.getTelefono()+"','"+bean.getEmail()+"','"+bean.getTipoDeCliente()+ "'," + bean.getAcepta_credito() + ")";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean mod( ClienteBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE CLIENTES SET " +
					"NIT=" + Util.vs( bean.getNit() ) + ", NOMBRES=" + Util.vs( bean.getNombres() ) + ", APELLIDOS=" + Util.vs( bean.getApellidos() ) + ", DIRECCION=" + Util.vs( bean.getDireccion() ) + "," + 
					"CORREO=" + Util.vs( bean.getEmail() ) + ", TELEFONO=" + Util.vs( bean.getTelefono() )+ ", TIPODECLIENTE=" + Util.vs( bean.getTipoDeCliente() ) + ", ACEPTA_CREDITO=" + bean.getAcepta_credito() + " WHERE ID=" + bean.getId();

			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( ClienteBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM CLIENTES WHERE ID = " + bean.getId();
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
		return 2;
	}
	
	public String getDateString( Date date ){
		Calendar cal = Calendar.getInstance();
		String str = cal.get(Calendar.YEAR ) + "-" + ( cal.get( Calendar.MONTH ) + 1 ) + "-" + cal.get( Calendar.DAY_OF_MONTH );
		return str;
	}

	public boolean existeNit(String nit) {
boolean exists = true;
		
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT count(ID) FROM CLIENTES WHERE NIT='" + nit + "'";
			
	
			rs = stmt.executeQuery( sql );
			if( rs.next() ){
				int total = rs.getInt( 1 );
	
				if( total == 0  ){
					exists = false;
				}
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return exists;
	}
	
}
