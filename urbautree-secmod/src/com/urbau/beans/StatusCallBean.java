package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class StatusCallBean  implements Bean {

	
	public static String SQL_FIELDS = "REASON";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "REASONS_CALL";
	
	public static final String  REASON_TAG   = "{reason}";
	
	private int total_regs;
	//mapped fields
	private int id;

	private String reason; 
	
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
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}

	
	
	
	
}
