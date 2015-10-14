package com.urbau.beans.reports.beans;

public class PresupuestoReportBean {

	int mes;
	int anio;
	double proyectado;
	double ejecutado;
	
	public Double getProyectado() {
		return proyectado;
	}
	
	public void setProyectado(double proyectado) {
		this.proyectado = proyectado;
	}
	
	public Double getEjecutado() {
		return ejecutado;
	}
	
	public void setEjecutado(double ejecutado) {
		this.ejecutado = ejecutado;
	}
	public Double getPercentage(){
		return this.ejecutado * 100 / this.proyectado;
	}

	public int getMes() {
		return mes;
	}

	public void setMes(int mes) {
		this.mes = mes;
	}

	public int getAnio() {
		return anio;
	}

	public void setAnio(int anio) {
		this.anio = anio;
	}
	
	public String getMes( int mes ){
		String[] meses = new String[]{"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"};
		return meses[ mes ];
	}
}
