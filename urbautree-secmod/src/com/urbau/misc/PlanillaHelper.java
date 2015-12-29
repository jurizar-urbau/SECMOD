package com.urbau.misc;

import java.util.ArrayList;

import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;

public class PlanillaHelper {

	public ArrayList<ExtendedFieldsBean> getEmpleados(){
		ExtendedFieldsBaseMain em = new ExtendedFieldsBaseMain( "EMPLEADOS", 
				new String[]{"NOMBRES","APELLIDOS","DIRECCION","TELEFONO","NUMERO_CEDULA","NIT","ESTADO_CIVIL","SEXO","FECHA_DE_NACIMIENTO","HIJOS","MUNICIPIO","ESTADO"},
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
					Constants.EXTENDED_TYPE_INTEGER
				} );
		
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter(
					new String[]{"ESTADO"}, 
					new int[]{ExtendedFieldsFilter.EQUALS}, 
					new int[]{Constants.EXTENDED_TYPE_INTEGER}, 
					new String[]{"1"}
				);
		
		return em.getAll( filter );
	}
	
	
	
}
