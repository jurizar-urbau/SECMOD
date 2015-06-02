package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import com.urbau.beans.ProgramBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class ProgramsMain {
			
	public ArrayList<ProgramBean> get( String q, int from ){
		return get( q, from, -1 );
	}
	
	public ArrayList<ProgramBean> get( String q, int from, int limit ){
		
		int items = limit > 0 ? limit : Constants.ITEMS_PER_PAGE;
		ArrayList<ProgramBean> list = new ArrayList<ProgramBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int total_regs = -1;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION,PROGRAM_NAME FROM PROGRAMAS LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				total_regs = Util.getTotalRegs( "PROGRAMAS", "" );
			} else {
				String rem_where = Util.getRolesWhere( q );
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION,PROGRAM_NAME FROM PROGRAMAS " + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
				total_regs = Util.getTotalRegs( "PROGRAMAS", rem_where );
			}
			while( rs.next() ){
				ProgramBean bean = new ProgramBean();
				bean.setId( 						   rs.getInt   ( 1  ));
				bean.setDescription(  Util.trimString( rs.getString( 2  )));
				bean.setProgram_name( Util.trimString( rs.getString( 3 )));
				bean.setTotal_regs( total_regs );
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
		
	public ProgramBean get( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		ProgramBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION,PROGRAM_NAME FROM PROGRAMAS WHERE ID=" + id );
			
			while( rs.next() ){
				bean = new ProgramBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription( Util.trimString( rs.getString( 2 )));
				bean.setProgram_name( Util.trimString( rs.getString( 3 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public ProgramBean getBlankBean(){
		ProgramBean bean = new ProgramBean();
		bean.setDescription( "" );
		bean.setProgram_name( "" );
		return bean;
	}
	public boolean add( ProgramBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO PROGRAMAS " +
					"(DESCRIPCION,PROGRAM_NAME) " +
						"VALUES " +
					"('"+ bean.getDescription()+"','" + bean.getProgram_name() + "')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean mod( ProgramBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE PROGRAMAS SET " +
					"DESCRIPCION = " + Util.vs( bean.getDescription() ) + ", " +
					"PROGRAM_NAME= " + Util.vs( bean.getProgram_name() ) + " " +
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
	
	public boolean del( ProgramBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM PROGRAMAS WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}

	public static int getId() {
		return 1;
	}

	
	
}
