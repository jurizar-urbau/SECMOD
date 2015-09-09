package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class BodegaUsuarioBean implements Bean {
	
	private int id;
	private int idBodega;
	private int idUsuario;
	int total_regs;
	
	public int getIdBodega() {
		return idBodega;
	}
	public void setIdBodega(int idBodega) {
		this.idBodega = idBodega;
	}		
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
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
