package com.urbau.feeders;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.FileTypeBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Constants;
import com.urbau.misc.Util;

public class FilesTypeMain {
	
	public ArrayList<FileTypeBean> getFileType( String q, int from ){
		ArrayList<FileTypeBean> list = new ArrayList<FileTypeBean>();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con = ConnectionManager.getConnection();
			stmt = con.createStatement();
			if( q == null || "null".equalsIgnoreCase( q ) || "".equals( q.trim() )){
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPO_ARCHIVOS LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			} else {
				rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPO_ARCHIVOS " + Util.getDescriptionWhere( q ) + " LIMIT " + from + "," + Constants.ITEMS_PER_PAGE );
			}
			while( rs.next() ){
				FileTypeBean bean = new FileTypeBean();
				bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription(  Util.trimString( rs.getString( 2 )));
				list.add( bean );
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return list;
	}
	
	
	
	public FileTypeBean getFile( int id ){
		if( id < 0 ){
			return getBlankBean();
		}
		FileTypeBean bean = null;
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT ID,DESCRIPCION FROM TIPO_ARCHIVOS WHERE ID=" + id );
			while( rs.next() ){
				bean = new FileTypeBean();
			    bean.setId(  rs.getInt   ( 1  ));
				bean.setDescription( Util.trimString( rs.getString( 2 )));
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	public FileTypeBean getBlankBean(){
		FileTypeBean bean = new FileTypeBean();
		bean.setDescription( "" );
		return bean;
	}
	public boolean addFile( FileTypeBean bean ){
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "INSERT INTO TIPO_ARCHIVOS " +
					"(DESCRIPCION) " +
						"VALUES " +
					"('"+ bean.getDescription()+"')";
			int total = stmt.executeUpdate( sql );
			return total>0;
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	public boolean modFile( FileTypeBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "UPDATE TIPO_ARCHIVOS SET " +
					"DESCRIPCION = " + Util.vs( bean.getDescription() ) + " " +
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
	
	public boolean delFile( FileTypeBean bean ){
		if ( bean.getId() <= 0 ){
			return false;
		}
		Connection con = null;
		Statement  stmt= null;
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			String sql = "DELETE FROM TIPO_ARCHIVOS WHERE ID = " + bean.getId();
			int total = stmt.executeUpdate( sql );
			return total>0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}

	public static int getFileId() {
		return 1;
	}
	
	
}
