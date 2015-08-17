package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class BodegaClienteBean implements Bean {
	
	private int id;
	private int idBodega;
	private int idCliente;
	int total_regs;
	
	public int getIdBodega() {
		return idBodega;
	}
	public void setIdBodega(int idBodega) {
		this.idBodega = idBodega;
	}
	public int getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
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
