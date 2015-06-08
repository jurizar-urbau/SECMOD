package com.urbau.beans;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import com.urbau.beans._interface.Bean;
@DatabaseTable(tableName= "accounts")
public class Account implements Bean {

	@DatabaseField(
				  generatedId = true 
				   )
	private int id;
	
	@DatabaseField
	private String name;
	
	@DatabaseField 
	private String password;
	
	 Account(){
		
	}
	


		public Account(String name) {
			this.name = name;
		}
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
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
