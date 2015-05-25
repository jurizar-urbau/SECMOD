package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ClientTypeBean  implements Bean {

	public static final String TYPE_TAG = "{type}";
	public static String SQL_FIELDS = "TIPO";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "TIPO_CLIENTES";
	
	
private int total_regs;
	private String type; 
	private int id;
	
	public int getTotal_regs() {
		return this.total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	@Override
	public int getId() {
		return this.id;
	}
	@Override
	public void setId(int i) {
		this.id = i;
		
	}
	@Override
	public int getProgramId() {
		// TODO Auto-generated method stub
		return 0;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
