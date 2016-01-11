package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.OrdenExtendedBean;
import com.urbau.db.ConnectionManager;

public class OrdenesExtendedMain extends AbstractMain {
	
	public static int getProgramId(){
		return -2;
	}
	
	
	public ArrayList<OrdenExtendedBean> get( String q, int punto_de_venta ){
		
		ArrayList<OrdenExtendedBean> list = new ArrayList<OrdenExtendedBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT " +
							"ORDEN.ID," +
							"ORDEN.FECHA," +
							"ORDEN.ID_CLIENTE," +
							"ORDEN.ID_BODEGA," +
							"ORDEN.MONTO," +
							"CLIENTE.NIT," +
							"CLIENTE.NOMBRES," +
							"CLIENTE.APELLIDOS," +
							"ORDEN.ID_USUARIO," +
							"US.NOMBRE USNAME, " +
							"CLIENTE.ACEPTA_CREDITO " +
						"FROM " +
							"ORDENES ORDEN, CLIENTES CLIENTE,USUARIOS US " +
						"WHERE " +
							"CLIENTE.ID = ORDEN.ID_CLIENTE AND " +
							"US.ID = ORDEN.ID_USUARIO AND " +
							"ORDEN.ESTADO='I' AND " +
							"ORDEN.ID_PUNTO_VENTA="+punto_de_venta + "  ORDER BY ID ASC";
			        
			rs = stmt.executeQuery( sql );
			System.out.println( sql );
			while( rs.next() ){
				OrdenExtendedBean bean = new OrdenExtendedBean();
				bean.setId        ( rs.getInt ( 1 ));
				bean.setFecha     ( rs.getTimestamp( 2 ));
				bean.setCliente_id( rs.getInt ( 3 ));
				bean.setBodega_id ( rs.getInt ( 4 ));
				bean.setMonto     ( rs.getDouble(5));
				bean.setCliente_nit( rs.getString( 6 ));
				bean.setCliente_nombres( rs.getString( 7));
				bean.setCliente_apellidos( rs.getString( 8));
				bean.setUsuario_id( rs.getInt( 9 ));
				bean.setUsuario_nombre( rs.getString( 10 ));
				bean.setAcepta_credito( rs.getBoolean( 11 ));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
		
	public OrdenExtendedBean get( int id ){
		if( id < 0 ){
			return null;
		}
		OrdenExtendedBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			String sql = "SELECT " +
					"ORDEN.ID," +
					"ORDEN.FECHA," +
					"ORDEN.ID_CLIENTE," +
					"ORDEN.ID_BODEGA," +
					"ORDEN.MONTO," +
					"CLIENTE.NIT," +
					"CLIENTE.NOMBRES," +
					"CLIENTE.APELLIDOS," +
					"ORDEN.ID_USUARIO," +
					"US.NOMBRE USNAME " +
				"FROM " +
					"ORDENES ORDEN, CLIENTES CLIENTE,USUARIOS US " +
				"WHERE " +
					"CLIENTE.ID = ORDEN.ID_CLIENTE AND " +
					"US.ID = ORDEN.ID_USUARIO AND " +
					"ORDEN.ESTADO='I' AND " +
					"ORDEN.ID="+id;
			rs = stmt.executeQuery( sql );
			if( rs.next() ){
			    bean = new OrdenExtendedBean();
				bean.setId        ( rs.getInt ( 1 ));
				bean.setFecha     ( rs.getDate( 2 ));
				bean.setCliente_id( rs.getInt ( 3 ));
				bean.setBodega_id ( rs.getInt ( 4 ));
				bean.setMonto     ( rs.getDouble(5));
				bean.setCliente_nit( rs.getString( 6 ));
				bean.setCliente_apellidos( rs.getString( 7));
				bean.setUsuario_id( rs.getInt( 8 ));
				bean.setUsuario_nombre( rs.getString( 9 ));
												
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	
	
	/*
	public boolean mod( OrdenBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE ORDENES SET " +
					" ULTIMA_MODIFICACION=NOW()," +
					" ID_CLIENTE="+bean.getId_cliente()+"," +
					" ID_BODEGA="+bean.getId_bodega()+"," +
					" MONTO="+bean.getMonto()+"," +
					" ID_USUARIO="+bean.getId_usuario()+", " +
					" ESTADO='"+bean.getId_usuario()+"', " +
					" UID='"+bean.getId_usuario()+"' " +
					" WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	*/
	
	
	
	
}
