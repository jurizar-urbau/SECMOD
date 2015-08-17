package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class BodegaBean implements Bean {

	
	private int id;
	private String nombre;
	private String direccion;
	private String telefono;
	private Boolean estado;
	private Boolean existeBodegaPrincipal;
	private Boolean estadoEsEditable;
	
	
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
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public Boolean getEstado() {
		return estado;
	}
	public void setEstado(Boolean estado) {
		this.estado = estado;
	}
	public Boolean getExisteBodegaPrincipal() {
		return existeBodegaPrincipal;
	}
	public void setExisteBodegaPrincipal(Boolean existeBodegaPrincipal) {
		this.existeBodegaPrincipal = existeBodegaPrincipal;
	}
		
	public Boolean getEstadoEsEditable() {
		return estadoEsEditable;
	}
	public void setEstadoEsEditable(Boolean estadoEsEditable) {
		this.estadoEsEditable = estadoEsEditable;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	
	
	
	
	
	
}
