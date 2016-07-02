package com.urbau.feeders;

public class ExtendedFieldsOrderBy {

	private String[] orderFields;
	private boolean  desc;
	
	public ExtendedFieldsOrderBy( String[] fields, boolean desc ){
		this.orderFields = fields;
		this.desc        = desc;
	}
	
	public String toString(){
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append( "ORDER BY " );
		for( String field: orderFields ){
			stringBuffer.append( field ).append( "," );
		}
		stringBuffer.deleteCharAt( stringBuffer.length() - 1 );
		
		if( desc ){
			stringBuffer.append( " DESC" );
		} else {
			stringBuffer.append( " ASC" );
		}
		return stringBuffer.toString();
	}
}
