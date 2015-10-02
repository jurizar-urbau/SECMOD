package com.urbau.misc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.urbau.db.ConnectionManager;

public class Util {

	public static String getGenericWhere( String template, String q ){
		return template.replaceAll( "${q}", q );
	}
	public static String trimString( String str ){
		if( str == null || "null".equalsIgnoreCase( str ) ){
			return "-";
		} else {
			return str.trim();
		}
	}
	
	public static String getDate( Calendar cal ){
		if( cal == null ){
			return "-";
		}
		SimpleDateFormat sdf = new SimpleDateFormat( "MM-dd-yyyy HH:mm:ss");
		return sdf.format( cal.getTime() );
	}
	public static String getDate( long timemillis ){
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis( timemillis );
		return getDate( cal );
	}
	public static String vs( String str ){
		if( str == null || "null".equalsIgnoreCase( str ) || str.trim().length() == 0 ){
			return "null";
		} else {
			return "'" + str.trim() + "'";
		}		
	}
	
	public static String split( String str, String separator ){
		if ( str == null ) return "";
		String[] strsplitted = str.split( separator );
		String strret = "";
		for( String st : strsplitted ){
			if( strret.length() > 0 ){
				strret += ",";
			}
			strret += "'" + st + "'";
		}
		return strret;
	}
	
	public static String getRemitentesWhere( String q ){
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRE1", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "NOMBRE2", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "APELLIDO1", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "APELLIDO2", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "APELLIDO3", q) );
			sb.append( " OR " ); 
			sb.append( getFieldLikes( "TELEFONO", q) );
			
			return sb.toString();
		}
	}
	public static String getFieldLikes( String field, String q ){
		String[] grupos = q.split( " " );
		StringBuffer sb = new StringBuffer();
		
		for( String s: grupos ){
			sb.append( " " + field + " LIKE '%" + s +"%'  OR" );
		}
		if( sb.length() > 0 ){
			return sb.toString().substring( 0, sb.toString().length() - 2 );
		} else {
			return "";
		}
	}
	public static String getOrdenesWhere( String q_remitente_id, String q_receptor_id, String q_remitente, String q_receptor, String q_fecha ){
		String sql = "";
		if( isEmpty( q_remitente ) && isEmpty(q_receptor) && isEmpty(q_fecha) && isEmpty(q_remitente_id) && isEmpty(q_receptor_id) ){
			return sql;
		} else {
			
			String whereRemitenteId = "";
			if( !isEmpty( q_remitente_id )){
				whereRemitenteId = "ID_REMITENTE = " + q_remitente_id;
			}
			String whereReceptorId = "";
			if( !isEmpty( q_receptor_id )){
				whereReceptorId = "ID_RECEPTOR = " + q_receptor_id;
			}
			String whereRemitente = "";
			if( !isEmpty( q_remitente ) ){
				whereRemitente = "ID_REMITENTE IN ( " +
							"SELECT " + 
							"ID " + 
						"FROM " + 
							"REMITENTE " + 
						"WHERE " + 
							"NOMBRE1 LIKE '%" + q_remitente + "%' OR " + 
							"NOMBRE2 LIKE '%" + q_remitente + "%' OR " +
							"APELLIDO1 LIKE '%" + q_remitente + "%' OR " +
							"APELLIDO2 LIKE '%" + q_remitente + "%' OR " +
							"APELLIDO3 LIKE '%" + q_remitente + "%' OR " + 
							"TELEFONO LIKE '%" + q_remitente + "%' ) ";
			}
			String whereReceptor = "";
			if( !isEmpty( q_receptor ) ){
				whereRemitente = "ID_RECEPTOR IN ( " +
									"SELECT " + 
									"ID " + 
								"FROM " + 
									"RECEPTOR " + 
								"WHERE " + 
									"NOMBRE1 LIKE '%" + q_receptor + "%' OR " + 
									"NOMBRE2 LIKE '%" + q_receptor + "%' OR " +
									"APELLIDO1 LIKE '%" + q_receptor + "%' OR " +
									"APELLIDO2 LIKE '%" + q_receptor + "%' OR " +
									"APELLIDO3 LIKE '%" + q_receptor + "%' OR " + 
									"TELEFONO LIKE '%" + q_receptor + "%' ) ";
			}
			String whereFecha = "";
			if( !isEmpty( q_fecha ) ){
				whereFecha = "DATE_FORMAT(FECHA_ENVIO,'%Y-%m-%d')  = '" + q_fecha + "'";
			}
			
			if( !isEmpty( whereReceptor ) || !isEmpty( whereFecha ) || !isEmpty( whereRemitente ) || !isEmpty( whereRemitenteId ) || !isEmpty( whereReceptorId )  ){
				sql += " WHERE ";
				if( !isEmpty( whereRemitente ) ){
					sql += whereRemitente;
				}
				if( !isEmpty( whereReceptor ) ){
					if( !isEmpty( whereRemitente )){
						sql += " AND ";
					}
					sql += whereReceptor;
				}
				if( !isEmpty( whereFecha )){
					if( !isEmpty( whereRemitente ) || !isEmpty( whereReceptor )){
						sql += " AND ";
					}
					sql += whereFecha;
				}
				if( !isEmpty( whereRemitenteId )){
					if( !isEmpty( whereRemitente ) || !isEmpty( whereReceptor ) || !isEmpty( whereFecha ) ){
						sql += " AND ";
					}
					sql += whereRemitenteId;
				}
				if( !isEmpty( whereReceptorId )){
					if( !isEmpty( whereRemitente ) || !isEmpty( whereReceptor ) || !isEmpty( whereFecha ) || !isEmpty( whereRemitenteId ) ){
						sql += " AND ";
					}
					sql += whereReceptorId;
				}
			}
			
		}
		return sql;
	}
	
	public static boolean isEmpty( String str ){
		return ( str == null || str.trim().length() == 0 || "null".equals( str ));
	}
	public static String getReceptoresWhere( String q ){
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			String group = split( q, " " );
			return " WHERE " +
					"NOMBRE1 IN ( " + group + " ) OR " + 
					"NOMBRE2 IN ( " + group + " ) OR " +
					"APELLIDO1 IN ( " + group + " ) OR " +
					"APELLIDO2 IN ( " + group + " ) OR " +
					"APELLIDO3 IN ( " + group + " ) OR " +
					"TELEFONO LIKE '%" + q + "%' ";
		}
	}
	public static String getUsuariosWhere( String q ){
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			return " WHERE " +
				getFieldLikes( "NOMBRE", q ) + " OR " + getFieldLikes( "USUARIO", q );					
		}
	}
	public static String getProveedoresWhere( String q ){
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			return " WHERE " +
				getFieldLikes( "NOMBRE", q ) + " OR " + getFieldLikes( "RAZON_SOCIAL", q )+ " OR " + getFieldLikes( "NIT", q )+ " OR " + getFieldLikes( "CONTACTO", q )+ " OR " + getFieldLikes( "TELEFONO", q )+ " OR " + getFieldLikes( "CORREO", q );					
		}
	}
	public static int getNextId( String table ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int id = 1;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT MAX( ID ) FROM " + table );
			if( rs.next() ){
				id = rs.getInt( 1 ) + 1;
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return id;
	}
	public static int getTotalRegs( String table, String where ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		String sql = "SELECT COUNT( * ) FROM " + table + " " + where ;		
		int total_regs = -1;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( sql );
			if( rs.next() ){
				total_regs = rs.getInt( 1 );
			}
		} catch( Exception e ){
			System.out.println( sql );
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return total_regs;
	}

	public static String getNextGuia( ){
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		int guia = -1;
		String prefix = "";
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT PREFIX, CURRENT FROM GUIA" );
			if( rs.next() ){
				prefix = rs.getString( 1 );
				guia = rs.getInt( 2 );
			}
			stmt.executeUpdate( "UPDATE GUIA SET CURRENT=" + ( guia + 1 ) );
			
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return prefix + " " + guia;
	}

	public static String getRolesWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			return " WHERE DESCRIPCION LIKE '%" + q + "%' ";
		}
	
	}
	public static String getDescriptionWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			return " WHERE DESCRIPCION LIKE '%" + q + "%' ";
		}
	
	}
	public static String getPresupuestoWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "ANIO", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "MES", q) );											
			return sb.toString();
		}
	}

	public static String getClientesWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRES", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "APELLIDOS", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "NIT", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "DIRECCION", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "CORREO", q) );
			sb.append( " OR " ); 			
			sb.append( getFieldLikes( "TELEFONO", q) );
					
			return sb.toString();
		}
	}
	public static String getBodegasWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRE", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "DIRECCION", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "TELEFONO", q) );
			
			return sb.toString();
		}
	}
	
	public static String getBancosWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRE", q) );											
			return sb.toString();
		}
	}
	public static String getBancosMovimientosWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "DESCRIPCION", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "MONTO", q) );
			return sb.toString();
		}
	}
	public static String getBancosMovimientosWithPrefixWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "BM.DESCRIPCION", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "BM.MONTO", q) );
			return sb.toString();
		}
	}
	public static String getMonedasWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRE", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "SIMBOLO", q) );
			return sb.toString();
		}
	}
	public static String getBodegaPorClienteWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRE", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "SIMBOLO", q) );
			return sb.toString();
		}
	}
	public static String getBodegaPorUsuarioWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRE", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "DIRECCION", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "TELEFONO", q) );
			return sb.toString();
		}
	}
	
	public static String getPaisesWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "NOMBRE", q) );			
			return sb.toString();
		}
	}
	public static String getColumNameGenericWhere(String columnName , String q) {
		if ( (q == null || q.trim().length() == 0) && (columnName == null || columnName.trim().length() == 0) ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( columnName, q) );			
			return sb.toString();
		}
	}
	
	public static String getProductosWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " WHERE " );
			sb.append( getFieldLikes( "CODIGO", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "DESCRIPCION", q) );
			return sb.toString();
		}
	}
	
	public static String getAttachmentWhere(String q) {
		if ( q == null || q.trim().length() == 0 ){ 
			return "";
		} else {
			StringBuffer sb = new StringBuffer();
			sb.append( " AND ( " );
			sb.append( getFieldLikes( "ATTACHMENTDESCRIPTION", q) );
			sb.append( " OR " );
			sb.append( getFieldLikes( "ATTACHMENTTYPE", q) );
			sb.append( ")" );
			return sb.toString();
		}
	}
	public static String getDateString( Date date ){
		if( date == null ){
			return "";
		}
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis( date.getTime() );
		String str = cal.get(Calendar.YEAR ) + "-" + ns( cal.get( Calendar.MONTH ) + 1 ) + "-" + ns( cal.get( Calendar.DAY_OF_MONTH ));
		return str;
	}
	public static String getDateStringMDY( Date date ){
		Calendar cal = Calendar.getInstance();
		String str = ( cal.get( Calendar.MONTH ) + 1 ) + "/" + cal.get( Calendar.DAY_OF_MONTH ) + "/" + cal.get(Calendar.YEAR );
		return str;
	}
	public static String ns( int n ){
		return ( n < 10 ? "0" + n : "" + n );
	}	
	
	public static String getAbsoluteParent( String path, int level ){
		System.out.println( "recieved: " + path );
		String[] patStrings = path.split( "/" );
		if ( patStrings.length >= level+1){
			return "/" + patStrings[ level+1 ];
		} else {
			return path;
		}	
	}
	
}
