package com.urbau.misc;

public class ExtendedFieldsFilter {
	
	
	public final static int EQUALS 		= 1;
	public final static int NOT_EQUALS 	= 2;
	public final static int GT 			= 3;
	public final static int LT 			= 4;
	public final static int GET 		= 5;
	public final static int LET 		= 6;
	public final static int LIKE		= 7;
	public final static int IN			= 8;
	public final static int BETWEEN     = 9;
	
	private String[] fields;
	private int[] comparators;
	private int[] data_types;
	private String[] data_values;
	
	public ExtendedFieldsFilter( String[] fields, int[] comparators, int[] data_types, String[] data_values  ){
		this.fields			= fields;
		this.comparators 	= comparators;
		this.data_types 	= data_types;
		this.data_values 	= data_values;
	}
	
	public String getWhereClause(){
		StringBuffer sb = new StringBuffer();
		if( fields.length != comparators.length 
				|| comparators.length != data_types.length 
				|| Util.isEmpty( fields.length )
				|| Util.isEmpty( comparators.length )
				|| Util.isEmpty( data_types.length )
				){
			return "";
		}
		for( int n = 0; n < fields.length ; n ++ ){
			sb.append( " AND " ).append( fields[ n ] ).append( " " );
				switch ( comparators[ n ] ) {
					case EQUALS:
						sb.append( "=" ).append( dataValue( data_values[n],data_types[n] ));
						break;
					case NOT_EQUALS:
						sb.append( "<>" ).append( dataValue( data_values[n],data_types[n] ));
						break;
					case GT:
						sb.append( ">" ).append( dataValue( data_values[n],data_types[n] ));
						break;
					case GET:
						sb.append( ">=" ).append( dataValue( data_values[n],data_types[n] ));
						break;
					case LT:
						sb.append( "<" ).append( dataValue( data_values[n],data_types[n] ));
						break;
					case LET:
						sb.append( "<=" ).append( dataValue( data_values[n],data_types[n] ));
						break;
					case LIKE:
						sb.append( "LIKE '%" ).append( dataValue( data_values[n],data_types[n] )).append( "%'" );
						break;
					case IN:
						sb.append( "IN (" ).append( dataValue( data_values[n],data_types[n] )).append( ")" );
						break;
					case BETWEEN:
						sb.append( "BETWEEN ").append( dataValue( data_values[ n ], Constants.EXTENDED_TYPE_INTEGER ));
					default:
						break;
				}
		}
		return sb.toString().substring( 5 );
	}

	private String dataValue( String dataValue, int dataType ){
		String value = dataValue;
		switch (dataType) {
			case Constants.EXTENDED_TYPE_STRING:
				value = "'" + dataValue + "'";
				break;
			case Constants.EXTENDED_TYPE_DATE:
				value = "'" + dataValue + "'";
				break;
			default:
				break;
		}
		return value;
	}
}
