package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.UsuarioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

/**
 * 
 * @author Jose Alejandro Urizar
 * @category Security
 *
 */
public class UsuariosMain extends AbstractMain {
	
	public ArrayList<UsuarioBean> getUsuario( String q, int from ){
		ArrayList<UsuarioBean> list = new ArrayList<UsuarioBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,USUARIO,NOMBRE,CLAVE,ROL,ESTADO FROM USUARIOS LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			} else {
				rs = stmt.executeQuery( "SELECT ID,USUARIO,NOMBRE,CLAVE,ROL,ESTADO FROM USUARIOS " + Util.getUsuariosWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			while( rs.next() ){
				UsuarioBean bean = new UsuarioBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setUsuario( Util.trimString( rs.getString( 2 )));
				bean.setNombre(  Util.trimString( rs.getString( 3 )));
				bean.setClave( Util.trimString( rs.getString( 4 )));
				bean.setRol( rs.getInt( 5 ) );
				bean.setEstado( rs.getBoolean( 6 ));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	public UsuarioBean logIn( String user, String pass ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID FROM USUARIOS WHERE USUARIO='" + user + "' AND CLAVE='" + pass + "'" );
			if( rs.next() ){
				return getUsuario( rs.getInt( 1 ) );
			} else {
				return null;
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return null;
	}
	
	public UsuarioBean getUsuario( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		UsuarioBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,USUARIO,NOMBRE,CLAVE,ROL,ESTADO FROM USUARIOS WHERE ID=" + id );
			while( rs.next() ){
				bean = new UsuarioBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setUsuario( Util.trimString( rs.getString( 2 )));
				bean.setNombre(  Util.trimString( rs.getString( 3 )));
				bean.setClave( Util.trimString( rs.getString( 4 )));
				bean.setRol(  rs.getInt( 5 ) );
				bean.setEstado( rs.getBoolean( 6 ));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public boolean existeUsuario( String user ){
		if( user == null || user.trim().equals( "" )){
			return false;
		}
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID FROM USUARIOS WHERE USUARIO='" + user +"'" );
			if( rs.next() ){
				return true;
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return false;
	}
	
	public UsuarioBean getBlankBean(){
		UsuarioBean bean = new UsuarioBean();
		bean.setUsuario( "" );
		bean.setNombre( "" );
		bean.setClave( "" );
		bean.setRol( -1 );
		bean.setEstado( false );
		return bean;
	}
	public boolean addUsuario( UsuarioBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO USUARIOS " +
					"(USUARIO,NOMBRE,CLAVE,ROL,ESTADO) " +
						"VALUES " +
					"('"+ bean.getUsuario()+"','"+ bean.getNombre()+"','"+ bean.getClave()+"','"+ bean.getRol()+"',"+bean.isEstado()+")";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean modUsuario( UsuarioBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE USUARIOS SET " +
					"USUARIO = " + Util.vs( bean.getUsuario() ) + ", " +
					"NOMBRE = " + Util.vs( bean.getNombre() ) + ", " +
					"CLAVE = " + Util.vs( bean.getClave() ) + ", " +
					"ROL = " +  bean.getRol()  + ", " +
					"ESTADO = " +  bean.isEstado()  + " " +
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
	
	public boolean delUsuario( UsuarioBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM USUARIOS WHERE ID = " + bean.getId();
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
