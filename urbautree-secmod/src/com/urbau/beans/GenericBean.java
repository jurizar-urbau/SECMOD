package com.urbau.beans;

import java.util.ArrayList;

import com.urbau.beans._interface.Bean;

public class GenericBean implements Bean {

	private int id;
	
	private String tableName;
	private String[] fieldsList;
	
	public GenericBean( String tableName, String[] fieldsList){
		this.tableName = tableName;
		this.fieldsList = fieldsList;
	}

	public GenericBean( String tableName ){
		this.tableName = tableName;
	}
	public GenericBean( ){
	
	}
	public String getTableName( ){
		return tableName;
	}
	public String[] getFieldsList(){
		return fieldsList;
	}
	
	private ArrayList<String> list;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public ArrayList<String> getList() {
		return list;
	}

	public void setList(ArrayList<String> list) {
		this.list = list;
	}
	
	@Override
	public int getProgramId() {
		return -100;
	}
}
