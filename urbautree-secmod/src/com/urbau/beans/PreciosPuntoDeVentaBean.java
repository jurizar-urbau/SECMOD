package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class PreciosPuntoDeVentaBean implements Bean {
	
	private int id;
	private int idPuntoDeVenta;
	private int idPrecio;
	int total_regs;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getIdPuntoDeVenta() {
		return idPuntoDeVenta;
	}
	public void setIdPuntoDeVenta(int idPuntoDeVenta) {
		this.idPuntoDeVenta = idPuntoDeVenta;
	}
	public int getIdPrecio() {
		return idPrecio;
	}
	public void setIdPrecio(int idPrecio) {
		this.idPrecio = idPrecio;
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
