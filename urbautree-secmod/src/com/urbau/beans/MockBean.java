package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class MockBean  implements Bean {

	
	public static String SQL_FIELDS = "FIELDS, FIELDS2,";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "TABLE_NAME";
	
	public static final String  TAG_FIELDS = "{tagfields}";
	
	
	private int total_regs;
	//mapped fields from table 
	
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
	
	
}
