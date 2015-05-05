package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class CajaBean implements Bean {

	int id;
	double monto;
	double saldo;
	String descripcion;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getMonto() {
		return monto;
	}
	public void setMonto(double monto) {
		this.monto = monto;
	}
	public double getSaldo() {
		return saldo;
	}
	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	@Override
	public int getProgramId() {
		// TODO Auto-generated method stub
		return 0;
	}
}
