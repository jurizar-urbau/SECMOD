package com.urbau.misc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.urbau.db.ConnectionManager;

public class ProveedoresHelper {
	
	
	public double getProveedorBalance( int id_proveedor ){
		String compras = "SELECT SUM(TOTAL_CON_GASTOS) FROM COMPRAS           WHERE ID_PROVEEDOR = "+ id_proveedor;
		String pagos   = "SELECT SUM( MONTO )          FROM PROVEEDORES_PAGOS WHERE ID_PROVEEDOR = " + id_proveedor;

		Connection c  = null;
		Statement  s  = null;
		ResultSet  r  = null;
		ResultSet  r2 = null;
		double totalCompras = 0;
		double totalPagos   = 0;
		try {
			c = ConnectionManager.getConnection();
			s = c.createStatement();
			r = s.executeQuery( compras );
			if( r.next() ){
				totalCompras = r.getDouble( 1 );
			}
			r2 = s.executeQuery( pagos );
			if( r2.next() ){
				totalPagos = r2.getDouble( 1 );
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally { 
			ConnectionManager.close(null, null, r2 );
			ConnectionManager.close(c, s, r );
		}
		return totalCompras - totalPagos;
		
		
	}
	

}
