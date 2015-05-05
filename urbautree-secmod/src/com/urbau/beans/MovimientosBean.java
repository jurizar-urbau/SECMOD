package com.urbau.beans;

import java.util.Date;

import com.urbau.beans._interface.Bean;

public class MovimientosBean implements Bean {

	int id;
	int caja_id;
	int id_cuenta;
	public int getId_cuenta() {
		return id_cuenta;
	}
	public void setId_cuenta(int id_cuenta) {
		this.id_cuenta = id_cuenta;
	}
	String tipo_movimiento;
	double valor;
	String descripcion;
	Date fecha;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCaja_id() {
		return caja_id;
	}
	public void setCaja_id(int caja_id) {
		this.caja_id = caja_id;
	}
	public String getTipo_movimiento() {
		return tipo_movimiento;
	}
	public void setTipo_movimiento(String tipo_movimiento) {
		this.tipo_movimiento = tipo_movimiento;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	@Override
	public int getProgramId() {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
}
