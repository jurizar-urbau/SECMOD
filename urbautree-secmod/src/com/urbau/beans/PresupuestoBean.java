package com.urbau.beans;

import java.util.Date;

import com.urbau.beans._interface.Bean;

public class PresupuestoBean implements Bean {

	private int id;
	private int anio;
	private int mes;
	private double proyectado;
	private double ejecutado;
	private Date fecha;	
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
	public double getProyectado() {
		return proyectado;
	}
	public void setProyectado(double proyectado) {
		this.proyectado = proyectado;
	}
	public double getEjecutado() {
		return ejecutado;
	}
	public void setEjecutado(double ejecutado) {
		this.ejecutado = ejecutado;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
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
