package com.urbau.misc;

import java.util.ArrayList;

import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;

public class PlanillaMain {

	
	public boolean process15For( int year, int month ){
		ArrayList<ExtendedFieldsBean> employees = getEmployees();
		
		for( ExtendedFieldsBean employee : employees ){
			
			int daysWorked = 30 - Util.missingDaysOn15( employee.getId() , month, year );
		}
		
		return false;
	}
	
	public ArrayList<ExtendedFieldsBean> getEmployees(){
		ExtendedFieldsBaseMain rm = new ExtendedFieldsBaseMain( "EMPLEADOS", 
  				new String[]{"NOMBRES","APELLIDOS","DIRECCION","TELEFONO","NUMERO_CEDULA","NIT","ESTADO_CIVIL","SEXO","FECHA_DE_NACIMIENTO","HIJOS","MUNICIPIO",
  				"PUESTO","TIPO_DE_PAGO","NUMERO_CUENTA","SUELDO_BASE","BONIFICACION","FECHA_DE_INGRESO",
  				"FECHA_DE_EGRESO","PORCENTAJE_AHORRO","CANTIDAD_DE_AHORRO","AHORRO","PAGA_IGSS","AFILIACION_IGSS","ESTADO","BANCO",
  				"DESCUENTO_FIJO","ES_TEMPORAL","ES_IMPRIMIBLE"
  		},
  				new int[]{ 
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
  		
		return rm.get(null, -1);
	}
	
}
