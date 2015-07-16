package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class PrecioBean implements Bean {

	private int id;
	private String nombre;
	private double coeficiente;
	int total_regs;
	
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public double getCoeficiente() {
		return coeficiente;
	}
	public void setCoeficiente(double coeficiente) {
		this.coeficiente = coeficiente;
	}	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
