package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class PresupuestoProyeccionBean implements Bean {

	private int id;
	private int anio;
	private int mes;
	private int tipoRublo;
	private String rubloDescripcion;
	private double monto;	
	private int total_regs;
	
		
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}		
	public int getAnio() {
		return anio;
	}
	public void setAnio(int anio) {
		this.anio = anio;
	}
	public int getMes() {
		return mes;
	}
	public void setMes(int mes) {
		this.mes = mes;
	}	
	public int getTipoRublo() {
		return tipoRublo;
	}
	public void setTipoRublo(int tipoRublo) {
		this.tipoRublo = tipoRublo;
	}
	public String getRubloDescripcion() {
		return rubloDescripcion;
	}
	public void setRubloDescripcion(String rubloDescripcion) {
		this.rubloDescripcion = rubloDescripcion;
	}
	public double getMonto() {
		return monto;
	}
	public void setMonto(double monto) {
		this.monto = monto;
	}
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	@Override
	public int getProgramId() {
		return 2;
	}
	
}
