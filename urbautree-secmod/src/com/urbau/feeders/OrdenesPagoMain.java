package com.urbau.feeders;

import java.sql.Connection;
import java.sql.Statement;

import com.urbau._abstract.AbstractMain;
import com.urbau.beans.OrdenPagoBean;
import com.urbau.db.ConnectionManager;
import com.urbau.misc.Util;

public class OrdenesPagoMain extends AbstractMain {
	
	private String allColumnNamesNoId = " ID_ORDEN,FECHA,MONTO,TIPO_PAGO,NO_AUTORIZACION,NO_CHEQUE,ID_BANCO,TIPO_TARJETA,NO_TARJETA,ID_USUARIO,ID_PUNTO_VENTA,ID_CAJA_PUNTO_VENTA,ID_CUPON ";
	
	public static int getProgramId(){
		return -2;
	}
	
	public boolean add( OrdenPagoBean bean ){
		Connection con = null;
		Statement  stmt= null;
		String sql = "INSERT INTO PAGOS_ORDENES " +
				"(" + allColumnNamesNoId + ") " +
					"VALUES " +
				"( " +
				bean.getOrden_id() + ", " +
				"NOW(), " +
				bean.getMonto() + ", " +
				Util.vs( bean.getTipo_pago() ) + ", " +
				Util.vs( bean.getNumero_autorizacion() ) + ", " +
				Util.vs( bean.getNumero_cheque() ) + ", " +
				bean.getId_banco() + ", " +
				Util.vs( bean.getTipo_tarjeta() ) + ", " +
				Util.vs( bean.getNumero_tarjeta() ) + ", " +
				bean.getId_usuario() +  ", " +
				bean.getPunto_de_venta() + ", " +
				bean.getCaja_punto_de_venta() + ", " +
				bean.getId_cupon() +
				
				")";
		String sql_cupon = "UPDATE CUPONES_DE_DESCUENTO SET ESTADO='U', ID_ORDEN="+bean.getOrden_id()+" WHERE ID=" + bean.getId_cupon();
		
		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			
			int total = stmt.executeUpdate( sql );
			if( bean.getId_cupon() > 0 ){
				stmt.executeUpdate( sql_cupon );
			}
			return total>0;
			 
		} catch (Exception e) {
			System.out.println( sql );
			e.printStackTrace();
			return false;
		} finally {
			ConnectionManager.close( con, stmt, null );
		}
	}
	
	
	
	
}
