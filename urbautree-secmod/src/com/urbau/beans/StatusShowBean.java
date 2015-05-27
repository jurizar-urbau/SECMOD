package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class StatusShowBean  implements Bean {

	
	public static String SQL_FIELDS = "STATUS";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "STATUS_SHOWS";
	
	public static final String  STATUS_TAG   = "{status}";
	
	private int total_regs;
	//mapped fields
	private int id;

	private String status; 
	
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	

	
	
	
	
}
