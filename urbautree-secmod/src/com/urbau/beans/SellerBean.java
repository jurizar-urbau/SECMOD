package com.urbau.beans;
import com.eclipsesource.json.JsonObject;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import com.urbau.beans._interface.Bean;
@DatabaseTable(tableName = "SELLERS")
public class SellerBean  implements Bean {
	
	@DatabaseField(generatedId = true)
	private int id;
	
	@DatabaseField(columnName = "NAME")
	private String name;
	
	@DatabaseField(columnName = "SURNAME")
	private String surname;
	
	@DatabaseField(columnName = "USER")
	private String user;
	
	private int total_regs;

	
	public int getTotal_regs() {
		return this.total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	

	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	@Override
	public int getId() {
		return id;
	}

	@Override
	public void setId(int i) {
		this.id = i;
	}

	@Override
	public int getProgramId() {
		return 0;
	}
	
	public JsonObject getJsonBean() {
		JsonObject jo = new JsonObject();
		jo.add("name", this.getName());
		jo.add("surName", this.getSurname());
		jo.add("id", this.getId());
		jo.add("user", this.getUser());
		
		return jo;
	}

}
