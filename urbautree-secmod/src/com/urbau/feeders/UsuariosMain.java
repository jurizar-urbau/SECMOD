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
	
	public ArrayList<UsuarioBean> get( String q, int from ){
		ArrayList<UsuarioBean> list = new ArrayList<UsuarioBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			int total_regs = 0;
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT ID,USUARIO,NOMBRE,CLAVE,ROL,ESTADO,CORREO,TELEFONO FROM USUARIOS  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( "USUARIOS", "" );
				 
			} else {
				sql = "SELECT ID,USUARIO,NOMBRE,CLAVE,ROL,ESTADO,CORREO,TELEFONO FROM USUARIOS " + Util.getUsuariosWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE + " ORDER BY ID DESC";
				rs = stmt.executeQuery(  sql );
				total_regs = Util.getTotalRegs( "USUARIOS", Util.getUsuariosWhere( q ) );
			}
			System.out.println( "sql: " + sql );
			while( rs.next() ){
				UsuarioBean bean = new UsuarioBean();
				bean.setTotal_regs( total_regs );
				bean.setId(  rs.getInt   ( 1  ));
				bean.setUsuario( Util.trimString( rs.getString( 2 )));
				bean.setNombre(  Util.trimString( rs.getString( 3 )));
				bean.setClave( Util.trimString( rs.getString( 4 )));
				bean.setRol(rs.getInt( 5 ) );
				bean.setEstado( rs.getBoolean( 6 ));
				bean.setEmail( Util.trimString( rs.getString( 7 )));
				bean.setTelefono( Util.trimString( rs.getString( 8 )));
				
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
			System.out.println( "sql: [" + sql + "]");
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
				return get( rs.getInt( 1 ) );
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
	
	public UsuarioBean get( int id ){
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
			rs = stmt.executeQuery( "SELECT ID,USUARIO,NOMBRE,CLAVE,ROL,ESTADO,CORREO,TELEFONO FROM USUARIOS WHERE ID=" + id );
			while( rs.next() ){
				bean = new UsuarioBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setUsuario( Util.trimString( rs.getString( 2 )));
				bean.setNombre(  Util.trimString( rs.getString( 3 )));
				bean.setClave( Util.trimString( rs.getString( 4 )));
				bean.setRol(  rs.getInt( 5 ) );
				bean.setEstado( rs.getBoolean( 6 ));
				bean.setEmail( Util.trimString( rs.getString( 7 )));
				bean.setTelefono( Util.trimString( rs.getString( 8 )));
				
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
		bean.setEmail( "" );
		bean.setTelefono( "" );
		return bean;
	}
	public boolean add( UsuarioBean bean ){
		
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO USUARIOS " +
					"(USUARIO,NOMBRE,CLAVE,ROL,ESTADO,CORREO,TELEFONO) " +
						"VALUES " +
					"('"+ bean.getUsuario()+"','"+ bean.getNombre()+"','"+ bean.getClave()+"','"+ bean.getRol()+"',"+bean.isEstado()+",'"+bean.getEmail()+"','"+bean.getTelefono()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( UsuarioBean bean ){
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
					"ESTADO = " +  bean.isEstado()  + ", " +
					"CORREO = " + Util.vs( bean.getEmail() )+ ", " +
				    "TELEFONO = " + Util.vs( bean.getTelefono() ) + " "+
					"WHERE ID = " + bean.getId();
			System.out.println("sql:"+sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	public boolean del( UsuarioBean bean ){
		
		System.out.println("bean.getId()>>>> " + bean.getId());
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
