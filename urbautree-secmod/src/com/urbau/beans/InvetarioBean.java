package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class InvetarioBean implements Bean {
	
	private int idBodega;
	private int id_product;
	private String estatus;
	private int amount;	
	int total_regs;
	
	public int getIdBodega() {
		return idBodega;
	}
	public void setIdBodega(int idBodega) {
		this.idBodega = idBodega;
	}		
	public int getId_product() {
		return id_product;
	}
	public void setId_product(int id_product) {
		this.id_product = id_product;
	}
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
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
	@Override
	public int getId() {
		
		return 0;
	}
	@Override
	public void setId(int i) {
		// TODO Auto-generated method stub		
	}
	
}
