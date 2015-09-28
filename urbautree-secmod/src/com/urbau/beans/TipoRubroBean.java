package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class TipoRubroBean implements Bean {

	private int id;
	private String descripcion;
	int total_regs;
		
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}	
		
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
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
