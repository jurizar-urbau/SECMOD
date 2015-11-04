package com.urbau.beans.reports;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;

import com.urbau.beans.reports.beans.PresupuestoReportBean;
import com.urbau.db.ConnectionManager;

/**
 * 
 * @author jurizar
 *
 */
public class StatusPresupuesto {
	
	public PresupuestoReportBean get(){
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis( System.currentTimeMillis() );
		return get( calendar.get( Calendar.MONTH ) +1, calendar.get( Calendar.YEAR ));
	}
	
	public PresupuestoReportBean get( int mes, int anio ){
		if( mes < 0 || anio <= 0 ){
			return blankBean(anio, mes);
		}
		PresupuestoReportBean bean = new PresupuestoReportBean();
		Connection con  = null;
		Statement  stmt = null;
		ResultSet  rs   = null;
		try{
			con  = ConnectionManager.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery( "SELECT PROYECTADO, EJECUTADO  FROM PRESUPUESTO WHERE MES=" + mes + " AND ANIO=" + anio );
			if( rs.next() ){
				bean = new PresupuestoReportBean();
				bean.setMes(mes);
				bean.setAnio(anio);
			    bean.setProyectado( rs.getDouble( 1 ));
			    bean.setEjecutado ( rs.getDouble( 2 ));
			} else {
				return blankBean(anio,mes);
			}
		} catch( Exception e ){
			e.printStackTrace();
		} finally {
			ConnectionManager.close( con, stmt, rs );
		}
		return bean;
	}
	
	private PresupuestoReportBean blankBean( int anio, int mes){
		PresupuestoReportBean b = new PresupuestoReportBean();
		b.setAnio( anio );
		b.setMes( mes );
		b.setEjecutado( 0.00 );
		b.setProyectado( 0.00 );
		return b;
	}
	
}
