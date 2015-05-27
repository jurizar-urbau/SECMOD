package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class DeptoBean  implements Bean {

	
	public static String SQL_FIELDS = "DEPTO, COUNTRY";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "DEPTOS";
	
	public static final String  COUNTRY_TAG   = "{country}";
	public static final String  DEPTO_TAG   = "{depto}";
	
	private int total_regs;
	//mapped fields
	private int id;
	private String name; 
	private String country; 
	private String depto; 
	
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
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getDepto() {
		return depto;
	}
	public void setDepto(String depto) {
		this.depto = depto;
	}
	
	
	
}
