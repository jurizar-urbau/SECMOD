package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class TipoRubroBean implements Bean {

	private int id;
	private String descripcion;
	private String tipo;
	private int tipo_clasificacion;
	
	
	int total_regs;
		
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public int getTipo_clasificacion() {
		return tipo_clasificacion;
	}
	public void setTipo_clasificacion(int tipo_clasificacion) {
		this.tipo_clasificacion = tipo_clasificacion;
	}
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
