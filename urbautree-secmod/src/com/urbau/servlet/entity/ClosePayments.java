package com.urbau.servlet.entity;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.UsuarioBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.CorrelativosUtil;

@WebServlet("/bin/ClosePayments")
public class ClosePayments extends Entity {
	
	private static final long serialVersionUID = 1L;
	
	
	private boolean closeCaja( String id_punto_venta, int loggedUserId , int id_caja_abierta, int id_caja ){
		System.out.println( "CLOSING: punto de venta: "  + id_punto_venta + ", userId:" + loggedUserId + ", id_caja_abierta:" + id_caja_abierta + ", id_caja:" + id_caja );
		
		Connection con  = null;
		Statement  stmt = null;
		Statement  stmt_p = null;
		ResultSet  rs   = null;
		
		String sql ="SELECT ID,MONTO,TIPO_PAGO FROM PAGOS_ORDENES WHERE CERRADO IS NULL AND ID_CAJA_PUNTO_VENTA=" + id_caja;
		
		Map<String, Double> pagos = new HashMap<String,Double>();
		pagos.put("credito", 0.00 );
		pagos.put("tarjeta", 0.00 );
		pagos.put("efectivo", 0.00 );
		pagos.put("cheque", 0.00 );
		try{
			con = ConnectionManager.getConnection();
			con.setAutoCommit( false );
			System.out.println( "TRANSACTION STARTED" );
			stmt   = con.createStatement();
			stmt_p = con.createStatement();
			rs = stmt.executeQuery( sql );
			while( rs.next() ){
				int    id = rs.getInt( 1 );
				double monto = rs.getDouble( 2 );
				String tipo_pago = rs.getString( 3 );
				
				//get the last value. 
				double preval = pagos.get( tipo_pago );
				pagos.put( tipo_pago, preval + monto );
				
				String pagoUpdate = "UPDATE PAGOS_ORDENES SET CERRADO=1, ID_CIERRE=" + id_caja_abierta + " WHERE ID=" + id;
 				int updated = stmt_p.executeUpdate( pagoUpdate );
 				if( updated <= 0 ){
 					ConnectionManager.close(null, stmt_p, null);
 					ConnectionManager.close(con, stmt, rs);
 					throw new Exception ( "No se pudo completar la transaccion." );
 				}
			}
			CorrelativosUtil correlativosUtil = new CorrelativosUtil();
			String close_reg = "UPDATE CAJA_DETALLE SET "
					+ "FECHA_CIERRE=NOW(),"
					+ "USUARIO_CIERRE  =" + loggedUserId + ","
					+ "EFECTIVO_CIERRE ="+pagos.get( "efectivo" )+","
					+ "TARJETA_CIERRE  ="+pagos.get( "tarjeta" )+","
					+ "CREDITO_CIERRE  ="+pagos.get( "credito" )+","
					+ "CHEQUE_CIERRE   ="+pagos.get( "cheque" )+", "
					+ "CORRELATIVO_CIERRE   ="+correlativosUtil.getNextAndAdvance( "CIERRE_CAJA_" + id_caja ) +" "
					+ "WHERE ID=" + id_caja_abierta;
			int updated_caja = stmt_p.executeUpdate( close_reg );
			if( updated_caja  > 0 ){
			
				String sql_toggle = "UPDATE CAJA_PUNTO_VENTA SET ESTADO=0 WHERE ID = " + id_caja;
				int updated_closed = stmt_p.executeUpdate(sql_toggle);
				if( updated_closed <= 0 ){
					ConnectionManager.close(null, stmt_p, null);
					ConnectionManager.close(con, stmt, rs);
					throw new Exception( "No se pudo actualizar detalle de caja." );
				}
			}
			
			
			con.commit();
			System.out.println( "TRANSACTION FINISHED" );
			return true;
		} catch ( Exception e ){
			e.printStackTrace();
			try {
				con.rollback();	
			} catch(Exception ee ){
				ee.printStackTrace( );
			}
			System.out.println( "TRANSACTION FAILED" );
			return false;
		} finally {
			ConnectionManager.close( null, stmt_p, null );
			ConnectionManager.close( con, stmt, null );	
		}
		
	}

	protected boolean openCaja(int id_caja, int loggedUserId){
		Connection con = null;
		Statement  stmt= null;
		String sql = "NOT SET";
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			sql = "INSERT INTO CAJA_DETALLE "
					+ "("
					+ "ID_CAJA,"
					+ "FECHA_APERTURA,"
					+ "USUARIO_APERTURA,"
					+ "EFECTIVO_APERTURA,"
					+ "TARJETA_APERTURA,"
					+ "CREDITO_APERTURA,"
					+ "CHEQUE_APERTURA) VALUE "
					+ "("+id_caja+",NOW(),"+loggedUserId+",0,0,0,0)";
			
			String sql_toggle = "UPDATE CAJA_PUNTO_VENTA SET ESTADO=1 WHERE ID = " + id_caja ;
			int toggle = stmt.executeUpdate( sql_toggle );
			if( toggle > 0 ){
				int total = stmt.executeUpdate( sql );
				return total>0;
			}
			
		} catch (Exception e) {
			System.out.println( sql );
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
		return false;
	}
	
	private int getOpenedDetail( int id_caja ){
		String sql = "SELECT ID FROM CAJA_DETALLE WHERE FECHA_CIERRE IS NULL AND  ID_CAJA=" + id_caja;
		Connection c = null;
		Statement  s = null;
		ResultSet  r = null;
		int id = -1;
		try {
			c = ConnectionManager.getConnection();
			s = c.createStatement();
			r = s.executeQuery( sql );
			if( r.next() ){
				id = r.getInt( 1 );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close( c, s, r );
		}
		return id;
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling close payments from caja...");
			HttpSession session = request.getSession();
			UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			
			String id_punto_venta = request.getParameter( "id_punto_venta" );
			String id_caja        = request.getParameter( "id_caja" );
			String action         = request.getParameter( "action" );
			
			boolean succed = false;
			
			if(  "close".equals( action ) ){
				int id_caja_abierta = getOpenedDetail( Integer.valueOf( id_caja ));
				
				succed = closeCaja(id_punto_venta, loggedUser.getId(), Integer.valueOf( id_caja_abierta ), Integer.valueOf( id_caja ) ) ;
			} else if( "open".equals( action ) ) {
				succed = openCaja(Integer.valueOf( id_caja ), loggedUser.getId() );
			}
			String message = "false";
			if( succed ){
				message = "true";
			}
			response.getOutputStream().write( message.getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
			
		} catch( Exception exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}  
}
				
							