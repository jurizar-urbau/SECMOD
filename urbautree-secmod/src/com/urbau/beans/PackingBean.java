package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class PackingBean implements Bean {
	
	private int id;
	private String nombre;
	private int multiplicador;
	private int id_producto;
	
	public int getId_producto() {
		return id_producto;
	}


	public void setId_producto(int id_producto) {
		this.id_producto = id_producto;
	}


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


	public int getMultiplicador() {
		return multiplicador;
	}


	public void setMultiplicador(int multiplicador) {
		this.multiplicador = multiplicador;
	}


	@Override
	public int getProgramId() {
		return 1;
	}
	
}
