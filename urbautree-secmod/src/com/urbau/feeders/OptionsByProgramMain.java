package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.OptionsByProgramBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Util;

public class OptionsByProgramMain {
	
	public ArrayList<OptionsByProgramBean> getOption( String rol ){
		ArrayList<OptionsByProgramBean> list = new ArrayList<OptionsByProgramBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "select opprog.id, id_programa, prg.descripcion, id_opcion, op.descripcion   from opcionesxprograma opprog , programas prg, opciones op where prg.id = id_programa and op.id = id_opcion and id_rol=" + rol + " order by id_programa, id_opcion" );
			
			while( rs.next() ){
				OptionsByProgramBean bean = new OptionsByProgramBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setId_program( Util.trimString( rs.getString( 2 )));
				bean.setProgram_description(Util.trimString( rs.getString( 3 )) );
				bean.setId_option( Util.trimString( rs.getString( 4 )) );
				bean.setOption_description( Util.trimString( rs.getString( 5 )) );
				bean.setId_rol( rol );
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	public boolean addOption(OptionsByProgramBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO OPCIONESXPROGRAMA (ID_PROGRAMA,ID_OPCION,ID_ROL) VALUE (" + bean.getId_program() + "," + bean.getId_option() + "," + bean.getId_rol() + ")";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	
	public boolean delOption( OptionsByProgramBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM OPCIONESXPROGRAMA WHERE ID = " + bean.getId();
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
