package com.urbau.beans;

import com.urbau.misc.Constants;

public class CuentaBean {

	int id;
	String description;
	String type;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	} 
	public String getTypeAsString(  ){
		if( Constants.ACCOUNTS_ADDS.equals( this.type ) ){
			return "Credito";
		} else if( Constants.ACCOUNTS_SUBSTRACT.equals( this.type ) ){
			return "Debito";
		} else {
			return "Debito/Credito";
		}
	}
	
	public String getTypeAsString( String type ){
		if( Constants.ACCOUNTS_ADDS.equals( type ) ){
			return "Credito";
		} else if( Constants.ACCOUNTS_SUBSTRACT.equals(  type ) ){
			return "Debito";
		} else {
			return "Debito/Credito";
		}
	}
	
	
	
	
	
}
