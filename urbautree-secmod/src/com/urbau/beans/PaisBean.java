package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class PaisBean implements Bean {
	
	private int id;
	private String nombre;
	private String moneda;	
	private String monedaId;
	private String monedaNombre;
	private String monedaSimbolo;
	private int total_regs;
	
	public String getMoneda() {
		return moneda;
	}
	public void setMoneda(String moneda) {
		this.moneda = moneda;
	}
	public String getMonedaId() {
		return monedaId;
	}
	public void setMonedaId(String monedaId) {
		this.monedaId = monedaId;
	}
	public String getMonedaNombre() {
		return monedaNombre;
	}
	public void setMonedaNombre(String monedaNombre) {
		this.monedaNombre = monedaNombre;
	}
	public String getMonedaSimbolo() {
		return monedaSimbolo;
	}
	public void setMonedaSimbolo(String monedaSimbolo) {
		this.monedaSimbolo = monedaSimbolo;
	}	
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
