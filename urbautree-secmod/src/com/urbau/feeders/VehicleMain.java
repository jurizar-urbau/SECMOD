package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.VehicleBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class VehicleMain extends AbstractMain {
	private static String SQL_STATMENT = "SELECT ID,MARCA , MODELO, NOPLACA, NOCHASIS, ESTADO, LICPIROTECNIA, LICVENCIMIENTO FROM ";
	private static String TABLE = "VEHICLES";
	
	public ArrayList<VehicleBean> getVehicles( String q, int from ){
		ArrayList<VehicleBean> list = new ArrayList<VehicleBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( SQL_STATMENT
						 				+TABLE+" LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );

			} else {
				rs = stmt.executeQuery( SQL_STATMENT + TABLE + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			while( rs.next() ){
				VehicleBean bean = new VehicleBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setMarca(  Util.trimString( rs.getString( 2 )));
				bean.setModelo(   Util.trimString( rs.getString( 3 )));
				bean.setNoPlaca(Util.trimString( rs.getString( 4 )));
				bean.setNoChasis(Util.trimString( rs.getString( 5 )));
				bean.setLicPirotecnia(Util.trimString( rs.getString( 6 )));
				bean.setLicVencimiento(Util.trimString( rs.getString( 7 )));
				
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public VehicleBean getVehicle( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		VehicleBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( SQL_STATMENT
					+ "FROM "+TABLE +" WHERE ID=" + id );
			while( rs.next() ){
				bean = new VehicleBean();
			    bean.setId(  rs.getInt   ( 1  ));
			    bean.setMarca(  Util.trimString( rs.getString( 2 )));
				bean.setModelo(   Util.trimString( rs.getString( 3 )));
				bean.setNoPlaca(Util.trimString( rs.getString( 4 )));
				bean.setNoChasis(Util.trimString( rs.getString( 5 )));
				bean.setLicPirotecnia(Util.trimString( rs.getString( 6 )));
				bean.setLicVencimiento(Util.trimString( rs.getString( 7 )));
				
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public VehicleBean getBlankBean(){
		VehicleBean bean = new VehicleBean();
		bean.setMarca("");
		bean.setModelo( "");
		bean.setNoPlaca("");
		bean.setNoChasis("");
		bean.setLicPirotecnia("");
		bean.setLicVencimiento("");
		bean.setEstado("");
		return bean;
	}
	public boolean addVehicle( VehicleBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO "+TABLE+" " +
					"(MARCA , MODELO, NOPLACA, NOCHASIS, ESTADO, LICPIROTECNIA, LICVENCIMIENTO) " +
						"VALUES " +
					"('"+ bean.getMarca()+"','" + bean.getModelo() +"','" + bean.getNoPlaca() +"','" + bean.getNoChasis()  
						+"','" + bean.getEstado() +"','" +bean.getLicPirotecnia() +"','" +bean.getLicVencimiento()+  "')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean modVehicle( VehicleBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE "+TABLE+" SET " +
					"MARCA = " + Util.vs( bean.getMarca() ) + 
					",MODELO=" + Util.vs( bean.getModelo() ) + " " +
					",NOPLACA=" + Util.vs( bean.getNoPlaca() ) + " " +
					",ESTADO=" + Util.vs( bean.getEstado() ) + " " +
					",LICPIROTECNIA=" + Util.vs( bean.getLicPirotecnia() ) + " " +
					",LICVENCIMIENTO=" + Util.vs( bean.getLicVencimiento() ) + " " +
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
	
	public boolean delVehicle( VehicleBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM "+TABLE+" WHERE ID = " + bean.getId();
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
