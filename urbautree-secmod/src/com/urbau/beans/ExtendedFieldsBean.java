package com.urbau.beans;

import java.util.HashMap;
import java.util.Map;

import com.urbau.misc.Util;

public class ExtendedFieldsBean {

	private int id;
	private int total_regs;
	
	private Map<String, String> values = new HashMap<String, String>();
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	
	public Map<String, String> getValues() {
		return values;
	}
	public void setValues(Map<String, String> values) {
		this.values = values;
	}
	
	public void putValue( String key, String value ){
		values.put(key, value);
	}
	public String getValue( String key ){
		String value = values.get( key );
		if( Util.isEmpty( value )){
			return "";
		} else {
			return value;
		}
	}
	
	
	
}
