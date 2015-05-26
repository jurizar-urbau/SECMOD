package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class BancoBean implements Bean {
	
	private int id;
	private String nombre;	
	private int total_regs;
	
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
		
	@Override
	public int getProgramId() {
		return 1;
	}
	
}
