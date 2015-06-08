package com.urbau.beans;

import com.eclipsesource.json.JsonObject;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import com.urbau.beans._interface.Bean;
@DatabaseTable(tableName = "COUNTRIES")
public class CountryBean  implements Bean {

	
	public static String SQL_FIELDS = "COUNTRY";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "COUNTRIES";
	
	public static final String  COUNTRY_TAG   = "{country}";

	private static final String COUNTRY_NAME = "countryName";

	private static final String ID = "id";
	
	private int total_regs;
	//mapped fields
	@DatabaseField(generatedId = true)
	private int id;
	
	@DatabaseField(columnName ="COUNTRY")
	private String country; 
	
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
	
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public JsonObject getJsonBean() {
		JsonObject jo  = new JsonObject();
		jo.add(ID, getId());
		jo.add(COUNTRY_NAME, getCountry());
		return jo;
	}
	
	
	
}
