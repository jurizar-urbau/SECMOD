package com.urbau.beans;

import com.eclipsesource.json.JsonObject;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import com.urbau.beans._interface.Bean;

@DatabaseTable(tableName= "TYPES_CALL")
public class TypeCallBean  implements Bean {

	
	public static String SQL_FIELDS = "TYPE";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "TYPES_CALL";
	
	public static final String  TYPE_TAG   = "{type}";
	
	private int total_regs;
	//mapped fields
	public TypeCallBean() {
		
	}
	@DatabaseField(
			generatedId = true)
	private int id;
	
	@DatabaseField(columnName="TYPE")
	private String type; 
	
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
	
	public JsonObject getJsonBean() {
		JsonObject jo = new JsonObject();
		jo.add("TYPE", this.getType());
		return jo;
		
	}
	
}
