package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class AliasBean implements Bean {

	private int id;
	private String description;
	private int idproducto;
	
	int total_regs;
		
	public int getIdproducto() {
		return idproducto;
	}
	public void setIdproducto(int idproducto) {
		this.idproducto = idproducto;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	
	@Override
	public int getProgramId() {
		return 1;
	}
	
}
