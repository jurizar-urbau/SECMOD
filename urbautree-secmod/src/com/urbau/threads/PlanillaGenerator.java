package com.urbau.threads;

import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;

import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.TwoFieldsBean;
import com.urbau.db.ConnectionManager;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.TwoFieldsBaseMain;
import com.urbau.misc.Constants;
import com.urbau.misc.ExtendedFieldsFilter;


public class PlanillaGenerator extends Thread {

	
	public int current_status;
	
	public final static int STATUS_STOPPED = 0;
	public final static int STATUS_WORKING = 1;
	public final static int STATUS_IDLE = 2;
	public final static int STATUS_ERROR = 3;

	private int period;
	private int month;
	private int year; 
	
	private int id_planilla;
	
	private int total_steps;
	private int current_step;
	
	ExtendedFieldsBaseMain planillaDetailMain = new ExtendedFieldsBaseMain( "PLANILLA_DETAIL", 
			new String[]{
			"ID_PLANILLA","ID_EMPLEADO","CLASIFICACION","DEPARTAMENTO","FORMA_DE_PAGO",
			"CUENTA","BANCO","DIAS_LABORADOS","FECHA_INGRESO","SUELDO_BASE","POR_DIA",
			"SUELDO_DEVENGADO","BONIFICACION","INCENTIVO","TOTAL_INGRESOS","IGSS","ANTICIPO_SUELDO",
			"PRESTAMO","TOTAL_DEDUCCIONES","LIQUIDO"},
				new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER, 
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_STRING,
				Constants.EXTENDED_TYPE_INTEGER,
				Constants.EXTENDED_TYPE_DATE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE,
				Constants.EXTENDED_TYPE_DOUBLE
			} );
	
	
	public void run(){
		if( current_status == STATUS_IDLE ){
			processGeneration();
		} else {
			System.out.println( "PLANILLA ALREADY RUNNING..." );
		}
		
	}
	
	public boolean deleteDetail( int id_planilla ){
		Connection c = null;
		Statement  s = null;
		try {
 			c = ConnectionManager.getConnection();
 			s = c.createStatement();
 			int n = s.executeUpdate( "DELETE FROM PLANILLA_DETAIL WHERE ID_PLANILLA = " + id_planilla );
 			return n > 0;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionManager.close(c, s, null);
		}
		return false;
	}
	
	public boolean processGeneration(){
		current_status = STATUS_WORKING;
		
		
		ArrayList<ExtendedFieldsBean> empleados = getEmpleados();
		setTotalSteps( empleados.size() );
		TwoFieldsBaseMain puestosMain = new TwoFieldsBaseMain("PUESTOS");
		TwoFieldsBaseMain tipoPagoMain = new TwoFieldsBaseMain("TIPOS_DE_PAGO");
		TwoFieldsBaseMain bancosMain = new TwoFieldsBaseMain("BANCOS");
		
		System.out.println( "Period: " + period );
		deleteDetail( this.id_planilla );
		if( period == 15 ){
			for( ExtendedFieldsBean empleado: empleados ){
				System.out.println( "Processing [" + empleado.getValue( "NOMBRES" ) + " " + empleado.getValue( "NOMBRES" ) + "]" );
				TwoFieldsBean puesto = puestosMain.get( Integer.valueOf( empleado.getValue( "PUESTO" )));
				TwoFieldsBean tipoPago = tipoPagoMain.get( Integer.valueOf( empleado.getValue( "TIPO_DE_PAGO" )));
				TwoFieldsBean bancoBean = bancosMain.get( Integer.valueOf( empleado.getValue( "BANCO" )));
				
				int id_planilla = this.id_planilla;
				int id_empleado = Integer.valueOf( empleado.getValue( "ID" ));
				String clasificacion = empleado.getValue( "ES_TEMPORAL" );
				
				String departamento = puesto.getDescripcion();
				
				String formaDePago = tipoPago.getDescripcion();
				String cuenta = empleado.getValue( "NUMERO_CUENTA" );
				String banco = bancoBean.getDescripcion();
				
				int diasLaborados = 15 - getDiasLaborados( id_empleado );
						
				print( "Empleado [" + empleado.getValue( "NOMBRES" ) + "]", id_planilla,id_empleado, clasificacion,departamento,formaDePago,cuenta, banco, diasLaborados );

				ExtendedFieldsBean planillaDetailBean = new ExtendedFieldsBean();
				planillaDetailBean.putValue("ID_PLANILLA", String.valueOf( id_planilla ));
				planillaDetailBean.putValue("ID_EMPLEADO", String.valueOf( id_empleado ));
				planillaDetailBean.putValue("CLASIFICACION",clasificacion );
				planillaDetailBean.putValue("DEPARTAMENTO", departamento );
				planillaDetailBean.putValue("FORMA_DE_PAGO", formaDePago );
				planillaDetailBean.putValue("CUENTA", cuenta );
				planillaDetailBean.putValue("BANCO", banco );
				planillaDetailBean.putValue("DIAS_LABORADOS", String.valueOf( diasLaborados ));
				planillaDetailBean.putValue( "FECHA_INGRESO" , empleado.getValue( "FECHA_DE_INGRESO" ));
				planillaDetailBean.putValue( "SUELDO_BASE" , empleado.getValue( "SUELDO_BASE","0" ));
				planillaDetailBean.putValue( "POR_DIA" , String.valueOf( ( Double.valueOf( empleado.getValue( "SUELDO_BASE","0" ) ) / 30 )));
				planillaDetailBean.putValue( "SUELDO_DEVENGADO" , String.valueOf( diasLaborados * ( Double.valueOf( empleado.getValue( "SUELDO_BASE","0" ) ) / 30 ) ) );
				planillaDetailBean.putValue( "BONIFICACION" , empleado.getValue( "BONIFICACION","0" ));
				planillaDetailBean.putValue( "INCENTIVO" , String.valueOf( Double.valueOf( empleado.getValue( "INCENTIVO","0" ) ) / 30 * diasLaborados ));  //TODO TBD
				planillaDetailBean.putValue( "TOTAL_INGRESOS" ,  String.valueOf( 
						Double.valueOf( planillaDetailBean.getValue( "SUELDO_DEVENGADO","0" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "BONIFICACION","0" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "INCENTIVO","0" ) )
						)
						);
				
				planillaDetailBean.putValue( "IGSS" ,  "0" );
				
//				if( "1".equals( empleado.getValue( "PAGA_IGSS" ))){
//					planillaDetailBean.putValue( "IGSS" ,  String.valueOf( 
//						Double.valueOf( planillaDetailBean.getValue( "POR_DIA" ) ) *
//						diasLaborados * ( 4.83 / 100 )
//						));
//				} else {
//					planillaDetailBean.putValue( "IGSS" ,  "0" );
//				}
				
				planillaDetailBean.putValue( "ANTICIPO_SUELDO" , String.valueOf( getAticipos(id_empleado) ));  //TODO TBD
				planillaDetailBean.putValue( "PRESTAMO" , "0");  //TODO TBD
				
				planillaDetailBean.putValue( "TOTAL_DEDUCCIONES" ,  String.valueOf( 
						Double.valueOf( planillaDetailBean.getValue( "IGSS" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "ANTICIPO_SUELDO" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "PRESTAMO" ) )
						)
						);
				
				planillaDetailBean.putValue( "LIQUIDO" ,  String.valueOf( 
						Double.valueOf( planillaDetailBean.getValue( "TOTAL_INGRESOS" ) ) -
						Double.valueOf( planillaDetailBean.getValue( "TOTAL_DEDUCCIONES" ) )
						)
						);
				
				planillaDetailMain.add( planillaDetailBean );
				
				print( "Status:", "tota: " + total_steps, "current: " + current_step );
				
				incrementStep();
				print( "AFTER AFFECT: " , getProgress() + "%" );
			}
			current_status = STATUS_IDLE;
		} else if( period == 30 ){

			for( ExtendedFieldsBean empleado: empleados ){
				System.out.println( "Processing [" + empleado.getValue( "NOMBRES" ) + " " + empleado.getValue( "NOMBRES" ) + "]" );
				TwoFieldsBean puesto = puestosMain.get( Integer.valueOf( empleado.getValue( "PUESTO" )));
				TwoFieldsBean tipoPago = tipoPagoMain.get( Integer.valueOf( empleado.getValue( "TIPO_DE_PAGO" )));
				TwoFieldsBean bancoBean = bancosMain.get( Integer.valueOf( empleado.getValue( "BANCO" )));
				
				int id_planilla = this.id_planilla;
				int id_empleado = Integer.valueOf( empleado.getValue( "ID" ));
				String clasificacion = empleado.getValue( "ES_TEMPORAL" );
				
				String departamento = puesto.getDescripcion();
				
				String formaDePago = tipoPago.getDescripcion();
				String cuenta = empleado.getValue( "NUMERO_CUENTA" );
				String banco = bancoBean.getDescripcion();
				
				int diasLaborados = 15 - getDiasLaborados( id_empleado );
				int diasLaboradosMes = 30 - getDiasLaboradosMes( id_empleado );
						
				print( "Empleado [" + empleado.getValue( "NOMBRES" ) + "]", id_planilla,id_empleado, clasificacion,departamento,formaDePago,cuenta, banco, diasLaborados );

				ExtendedFieldsBean planillaDetailBean = new ExtendedFieldsBean();
				planillaDetailBean.putValue("ID_PLANILLA", String.valueOf( id_planilla ));
				planillaDetailBean.putValue("ID_EMPLEADO", String.valueOf( id_empleado ));
				planillaDetailBean.putValue("CLASIFICACION",clasificacion );
				planillaDetailBean.putValue("DEPARTAMENTO", departamento );
				planillaDetailBean.putValue("FORMA_DE_PAGO", formaDePago );
				planillaDetailBean.putValue("CUENTA", cuenta );
				planillaDetailBean.putValue("BANCO", banco );
				planillaDetailBean.putValue("DIAS_LABORADOS", String.valueOf( diasLaborados ));
				planillaDetailBean.putValue( "FECHA_INGRESO" , empleado.getValue( "FECHA_DE_INGRESO" ));
				planillaDetailBean.putValue( "SUELDO_BASE" , empleado.getValue( "SUELDO_BASE","0" ));
				planillaDetailBean.putValue( "POR_DIA" , String.valueOf( ( Double.valueOf( empleado.getValue( "SUELDO_BASE","0" ) ) / 30 )));
				planillaDetailBean.putValue( "SUELDO_DEVENGADO" , String.valueOf( diasLaborados * ( Double.valueOf( empleado.getValue( "SUELDO_BASE","0" ) ) / 30 ) ) );
				planillaDetailBean.putValue( "BONIFICACION" , empleado.getValue( "BONIFICACION","0" ));
				planillaDetailBean.putValue( "INCENTIVO" , String.valueOf( Double.valueOf( empleado.getValue( "INCENTIVO","0" ) ) / 30 * diasLaborados ));  //TODO TBD
				planillaDetailBean.putValue( "TOTAL_INGRESOS" ,  String.valueOf( 
						Double.valueOf( planillaDetailBean.getValue( "SUELDO_DEVENGADO","0" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "BONIFICACION","0" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "INCENTIVO","0" ) )
						)
						);
				
				if( "1".equals( empleado.getValue( "PAGA_IGSS" ))){
					planillaDetailBean.putValue( "IGSS" ,  String.valueOf( 
						Double.valueOf( planillaDetailBean.getValue( "SUELDO_BASE" ) ) *  ( 4.83 / 100 )
						));
				} else {
					planillaDetailBean.putValue( "IGSS" ,  "0" );
				}
				planillaDetailBean.putValue( "ANTICIPO_SUELDO" , String.valueOf( getAticipos(id_empleado) ));  //TODO TBD
				planillaDetailBean.putValue( "PRESTAMO" , "0");  //TODO TBD
				
				planillaDetailBean.putValue( "TOTAL_DEDUCCIONES" ,  String.valueOf( 
						Double.valueOf( planillaDetailBean.getValue( "IGSS" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "ANTICIPO_SUELDO" ) ) +
						Double.valueOf( planillaDetailBean.getValue( "PRESTAMO" ) )
						)
						);
				
				planillaDetailBean.putValue( "LIQUIDO" ,  String.valueOf( 
						Double.valueOf( planillaDetailBean.getValue( "TOTAL_INGRESOS" ) ) -
						Double.valueOf( planillaDetailBean.getValue( "TOTAL_DEDUCCIONES" ) )
						)
						);
				
				planillaDetailMain.add( planillaDetailBean );
				
				print( "Status:", "tota: " + total_steps, "current: " + current_step );
				
				incrementStep();
				print( "AFTER AFFECT: " , getProgress() + "%" );
			}
			current_status = STATUS_IDLE;
		
		}

		
		return true;
	}
	private void print( String title, Object... list ){
		StringBuffer sb = new StringBuffer();
		for( Object o : list){
			sb.append( "," ).append( o );
		}
		System.out.println( "object: [ " + sb.toString().substring( 1 ) + "]" );
	}
	
	private int getDiasLaborados( int id_empleado ){
		ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "PERMISOS", 
				new String[]{"FECHA"},
					new int[]{ 
					Constants.EXTENDED_TYPE_INTEGER 
				} );
		
		String range = "";
		if( period == 15 ){
			range = "'" + year + "-" + month + "-01' AND ' " + year + "-" + month + "-15'";
		} else if( period == 30 ){
			range = "'" + year + "-" + month + "-16' AND ' " + year + "-" + month + "-30'";
		}
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter(new String[]{"FECHA","EMPLEADO"}, new int[]{ExtendedFieldsFilter.BETWEEN, ExtendedFieldsFilter.EQUALS}, 
				new int[]{Constants.EXTENDED_TYPE_DATE,Constants.EXTENDED_TYPE_INTEGER}, new String[]{range,String.valueOf( id_empleado ) } );
		ArrayList<ExtendedFieldsBean> list = um.getAll(filter);
		return list.size();

	}
	
	private int getDiasLaboradosMes( int id_empleado ){
		ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "PERMISOS", 
				new String[]{"FECHA"},
					new int[]{ 
					Constants.EXTENDED_TYPE_INTEGER 
				} );
		
		String range = "'" + year + "-" + month + "-01' AND ' " + year + "-" + month + "-31'";
		
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter(new String[]{"FECHA","EMPLEADO"}, new int[]{ExtendedFieldsFilter.BETWEEN, ExtendedFieldsFilter.EQUALS}, 
				new int[]{Constants.EXTENDED_TYPE_DATE,Constants.EXTENDED_TYPE_INTEGER}, new String[]{range,String.valueOf( id_empleado ) } );
		ArrayList<ExtendedFieldsBean> list = um.getAll(filter);
		return list.size();

	}
	
	
	
	private double getAticipos( int id_empleado){
		ExtendedFieldsBaseMain um = new ExtendedFieldsBaseMain( "ADELANTOS", 
				new String[]{"MONTO"},
					new int[]{ 
					Constants.EXTENDED_TYPE_DOUBLE 
				} );
		
		String range = "";
		if( period == 15 ){
			range = "'" + year + "-" + month + "-01' AND ' " + year + "-" + month + "-15'";
		} else if( period == 30 ){
			range = "'" + year + "-" + month + "-16' AND ' " + year + "-" + month + "-30'";
		}
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter(new String[]{"FECHA","EMPLEADO"}, new int[]{ExtendedFieldsFilter.BETWEEN, ExtendedFieldsFilter.EQUALS}, 
				new int[]{Constants.EXTENDED_TYPE_DATE,Constants.EXTENDED_TYPE_INTEGER}, new String[]{range,String.valueOf( id_empleado) } );
		ArrayList<ExtendedFieldsBean> list = um.getAll(filter);
		double anticipos = 0;
		for( ExtendedFieldsBean anticipo: list ){
			anticipos += Double.parseDouble( anticipo.getValue( "MONTO" ));
		}
		return anticipos;

	}
	
	public int getProgress( ){
		return ( current_step * 100 / total_steps );
	}
	
	public void setTotalSteps( int total_steps ){
		this.total_steps = total_steps;
	}
	public void setPeriod( int period, int month, int year ){
		this.period = period;
		this.month  = month;
		this.year   = year;
	}
	
	public void setIdPlanilla( int id_planilla ){
		this.id_planilla = id_planilla;
	}
	
	public void incrementStep(){
		if( current_step >= total_steps ){
			current_step = total_steps;
		} else {
			current_step++;
		}
		System.out.println( "incremented step [ " + current_step + "]" );
	}
	
	public ArrayList<ExtendedFieldsBean> getEmpleados(){
		ExtendedFieldsBaseMain em = new ExtendedFieldsBaseMain( "EMPLEADOS", 
  				new String[]{"ID","NOMBRES","APELLIDOS","DIRECCION","TELEFONO","NUMERO_CEDULA","NIT","ESTADO_CIVIL","SEXO","FECHA_DE_NACIMIENTO","HIJOS","MUNICIPIO",
  				"PUESTO","TIPO_DE_PAGO","NUMERO_CUENTA","SUELDO_BASE","BONIFICACION","FECHA_DE_INGRESO",
  				"FECHA_DE_EGRESO","PORCENTAJE_AHORRO","CANTIDAD_DE_AHORRO","AHORRO","PAGA_IGSS","AFILIACION_IGSS","ESTADO","BANCO",
  				"DESCUENTO_FIJO","ES_TEMPORAL","ES_IMPRIMIBLE"
  		},
  				new int[]{ 
				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_STRING, 
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_DATE,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_DOUBLE,
  				Constants.EXTENDED_TYPE_DOUBLE,
  				Constants.EXTENDED_TYPE_DATE,
  				Constants.EXTENDED_TYPE_DATE,
  				Constants.EXTENDED_TYPE_DOUBLE,
  				Constants.EXTENDED_TYPE_DOUBLE,
  				Constants.EXTENDED_TYPE_DOUBLE,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_STRING,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_DOUBLE,
  				Constants.EXTENDED_TYPE_INTEGER,
  				Constants.EXTENDED_TYPE_INTEGER
  				} );
  		
		
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter(
					new String[]{"ESTADO","ES_IMPRIMIBLE"}, 
					new int[]{ExtendedFieldsFilter.EQUALS,ExtendedFieldsFilter.EQUALS}, 
					new int[]{Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER}, 
					new String[]{"1","1"}
				);
		
		return em.getAll( filter );
	}
	
}
