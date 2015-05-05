package com.urbau.feeders;

import java.sql.Date;

public abstract class Main {
	
	abstract Object[] getFieldTypes();
	abstract String[] getFields();
	
	
	protected String getFieldsAsString(String[] fields){
		
		Object[] fieldTypes = getFieldTypes();
		StringBuffer sb = new StringBuffer();
		
		for(int n = 0; n < fields.length; n++ ){
			if( fieldTypes[ n ] instanceof String ){
				sb.append(",").append( "'" ).append( fields[ n ] ).append( "'" );
			} else if( fieldTypes[n] instanceof Double || fieldTypes[n] instanceof Integer  ){
				sb.append(",").append( fields[ n ] );
			} else if( fieldTypes[n] instanceof Date  ){
				sb.append(",").append( fields[ n ] );
			}
		}
		if( sb.length() > 0 ){
			return sb.substring( 1 );
		} else {
			return "";
		}
	}
	protected String getFieldNames(){
		String[] fieldNames = getFields();
		StringBuffer sb = new StringBuffer();
		
		
		for(String field: fieldNames ){
				sb.append(",").append( field );
		}
		if( sb.length() > 0 ){
			return sb.substring( 1 );
		} else {
			return "";
		}
	}
}
