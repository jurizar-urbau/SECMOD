package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ProveedorBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class ProveedoresMain extends AbstractMain {
	
	public ArrayList<ProveedorBean> get( String q, int from ){
		ArrayList<ProveedorBean> list = new ArrayList<ProveedorBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "";
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			int total_regs = 0;
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				sql = "SELECT ID,NIT,CODIGO,NOMBRE,RAZON_SOCIAL,CONTACTO,DIRECCION,TELEFONO,CORREO,PAIS,MONEDA,LIMITE_CREDITO,SALDO FROM PROVEEDORES  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery( sql );
				total_regs = Util.getTotalRegs( "PROVEEDORES", "" );
				 
			} else {
				//sql = "SELECT ID,NIT,CODIGO,NOMBRE,RAZON_SOCIAL,CONTACTO,DIRECCION,TELEFONO,CORREO,PAIS,MONEDA,LIMITE_CREDITO,SALDO FROM PROVEEDORES " + Util.getUsuariosWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE + " ORDER BY ID DESC";
				sql = "SELECT ID,NIT,CODIGO,NOMBRE,RAZON_SOCIAL,CONTACTO,DIRECCION,TELEFONO,CORREO,PAIS,MONEDA,LIMITE_CREDITO,SALDO FROM PROVEEDORES " + Util.getProveedoresWhere( q ) + "  ORDER BY ID DESC  LIMIT " + from + "," + Constants.ITEMS_PER_PAGE;
				rs = stmt.executeQuery(  sql );
				//total_regs = Util.getTotalRegs( "PROVEEDORES", Util.getUsuariosWhere( q ) );
			}
			System.out.println( "sql: " + sql );
			while( rs.next() ){
				ProveedorBean bean = new ProveedorBean();
				bean.setTotal_regs( total_regs );
				bean.setId(  rs.getInt   ( 1  ));
				bean.setNit( Util.trimString( rs.getString( 2 )));
				bean.setCodigo(  Util.trimString( rs.getString( 3 )));
				bean.setNombre( Util.trimString( rs.getString( 4 )));
				bean.setRazonSocial(Util.trimString( rs.getString( 5 )));
				bean.setContacto( Util.trimString( rs.getString( 6 )));
				bean.setDireccion( Util.trimString( rs.getString( 7 )));				
				bean.setTelefono( Util.trimString( rs.getString( 8 )));
				bean.setEmail( Util.trimString( rs.getString( 9 )));
				bean.setPais(  rs.getInt   ( 10  ));
				bean.setMoneda(  rs.getInt   ( 11  ));
				bean.setLimiteCredito(  rs.getDouble(12));
				bean.setSaldo(  rs.getDouble(13));							
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
		
	
	public ProveedorBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ProveedorBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String query  = "SELECT ID,NIT,CODIGO,NOMBRE,RAZON_SOCIAL,CONTACTO,DIRECCION,TELEFONO,CORREO,PAIS,MONEDA,LIMITE_CREDITO,SALDO FROM PROVEEDORES WHERE ID=" + id ;
			System.out.println("query:"+ query);
			rs = stmt.executeQuery( query);
			while( rs.next() ){
				bean = new ProveedorBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setNit( Util.trimString( rs.getString( 2 )));
				bean.setCodigo(  Util.trimString( rs.getString( 3 )));
				bean.setNombre( Util.trimString( rs.getString( 4 )));
				bean.setRazonSocial(Util.trimString( rs.getString( 5 )));
				bean.setContacto( Util.trimString( rs.getString( 6 )));
				bean.setDireccion( Util.trimString( rs.getString( 7 )));				
				bean.setTelefono( Util.trimString( rs.getString( 8 )));
				bean.setEmail( Util.trimString( rs.getString( 9 )));
				bean.setPais(  rs.getInt   ( 10  ));
				bean.setMoneda(  rs.getInt   ( 11  ));
				bean.setLimiteCredito(  rs.getDouble(12));
				bean.setSaldo(  rs.getDouble(13));			
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
		
	
	public ProveedorBean getBlankBean(){
		ProveedorBean bean = new ProveedorBean();
			bean.setId(0);
			bean.setNit("");
			bean.setCodigo("");
			bean.setNombre("");
			bean.setRazonSocial("");
			bean.setContacto("");
			bean.setDireccion("");				
			bean.setTelefono("");
			bean.setEmail("");
			bean.setPais(0);
			bean.setMoneda(0);
			bean.setLimiteCredito(0);
			bean.setSaldo(0);			
		return bean;
	}
	public boolean add( ProveedorBean bean ){
		
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO PROVEEDORES " +
					"(NIT,CODIGO,NOMBRE,RAZON_SOCIAL,CONTACTO,DIRECCION,TELEFONO,CORREO,PAIS,MONEDA,LIMITE_CREDITO,SALDO) " +
						"VALUES " +
					"('"+ bean.getNit()+"','"+ bean.getCodigo()+"','"+ bean.getNombre()+"','"+ bean.getRazonSocial()+"','"+bean.getContacto()+"','"+bean.getDireccion()+"','"+bean.getTelefono()+"','"+bean.getEmail()+"','"+bean.getPais()+"','"+bean.getMoneda()+"','"+bean.getLimiteCredito()+"','"+bean.getSaldo()+"')";
			
			System.out.print("sql:" +sql);
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( ProveedorBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE PROVEEDORES SET " +
					"NIT = " + Util.vs( bean.getNit() ) + ", " +
					"CODIGO = " + Util.vs( bean.getCodigo() ) + ", " +
					"NOMBRE = " + Util.vs( bean.getNombre() ) + ", " +
					"RAZON_SOCIAL = " + Util.vs( bean.getRazonSocial() ) + ", " +
					"CONTACTO = " +  Util.vs( bean.getContacto() )  + ", " +
					"DIRECCION = " +  Util.vs( bean.getDireccion() )  + ", " +
					"TELEFONO = " + Util.vs( bean.getTelefono() )+ ", " +
				    "CORREO = " + Util.vs( bean.getEmail() ) + ", "+
				    "PAIS = " + bean.getPais() + ", "+
				    "MONEDA = " + bean.getMoneda()+ ", "+
				    "LIMITE_CREDITO = " +  bean.getLimiteCredito() + ", "+
				    "SALDO = " + bean.getSaldo() + " "+
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
	
	public boolean del( ProveedorBean bean ){
				
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM PROVEEDORES WHERE ID = " + bean.getId();
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
