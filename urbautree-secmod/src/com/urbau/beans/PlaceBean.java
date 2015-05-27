package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class PlaceBean  implements Bean {

	
	public static String SQL_FIELDS = "NAME, DESCRIPTION, ADDRESS_LINE1, ADDRESS_LINE2, "
									+ "DEPARTMENT, MUNICIPALITY, COUNTRY";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "PLACES";
	
	public static final String  NAME_TAG = "{name}";
	public static final String  DESCRIPTION_TAG   = "{description}";
	public static final String  ADDRESS_LINE1_TAG   = "{address1}";
	public static final String  ADDRESS_LINE2_TAG   = "{address2}";
	public static final String  DEPARTMENT_TAG   = "{deppartment}";
	public static final String  MUNICIPALITY_TAG   = "{municipality}";
	public static final String  COUNTRY_TAG   = "{country}";
	
	private int total_regs;
	//mapped fields
	private int id;
	private String name; 
	private String description; 
	private String addressLine1; 
	private String addressLine2;
	private int department; 
	private int municipality; 
	private int country; 
	
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

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAddressLine1() {
		return addressLine1;
	}
	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}
	public String getAddressLine2() {
		return addressLine2;
	}
	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}
	public int getDepartment() {
		return department;
	}
	public void setDepartment(int department) {
		this.department = department;
	}
	public int getMunicipality() {
		return municipality;
	}
	public void setMunicipality(int municipality) {
		this.municipality = municipality;
	}
	public int getCountry() {
		return country;
	}
	public void setCountry(int country) {
		this.country = country;
	}
	
	
	public String getFullAddress() {
		return this.addressLine1  + "\n" +
			   this.addressLine2  + "\n" +
			   this.department    + "\n" +
			   this.municipality  + "\n" +
			   this.country;
		
	}
}
