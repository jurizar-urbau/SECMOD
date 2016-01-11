package com.urbau.beans;

import java.util.Date;

import com.urbau.beans._interface.Bean;

public class OrdenExtendedBean implements Bean {

	
	private int id;
	private Date fecha;
	private int cliente_id;
	private int bodega_id;
	private double monto;
	private String cliente_nit;
	private String cliente_nombres;
	private String cliente_apellidos;
	private int usuario_id;
	private String usuario_nombre;
	private boolean acepta_credito;
	
	
	
	public boolean isAcepta_credito() {
		return acepta_credito;
	}



	public void setAcepta_credito(boolean acepta_credito) {
		this.acepta_credito = acepta_credito;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public Date getFecha() {
		return fecha;
	}



	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}



	public int getCliente_id() {
		return cliente_id;
	}



	public void setCliente_id(int cliente_id) {
		this.cliente_id = cliente_id;
	}



	public int getBodega_id() {
		return bodega_id;
	}



	public void setBodega_id(int bodega_id) {
		this.bodega_id = bodega_id;
	}



	public double getMonto() {
		return monto;
	}



	public void setMonto(double monto) {
		this.monto = monto;
	}



	public String getCliente_nit() {
		return cliente_nit;
	}



	public void setCliente_nit(String cliente_nit) {
		this.cliente_nit = cliente_nit;
	}



	public String getCliente_nombres() {
		return cliente_nombres;
	}



	public void setCliente_nombres(String cliente_nombres) {
		this.cliente_nombres = cliente_nombres;
	}



	public String getCliente_apellidos() {
		return cliente_apellidos;
	}



	public void setCliente_apellidos(String cliente_apellidos) {
		this.cliente_apellidos = cliente_apellidos;
	}



	public int getUsuario_id() {
		return usuario_id;
	}



	public void setUsuario_id(int usuario_id) {
		this.usuario_id = usuario_id;
	}



	public String getUsuario_nombre() {
		return usuario_nombre;
	}



	public void setUsuario_nombre(String usuario_nombre) {
		this.usuario_nombre = usuario_nombre;
	}



	@Override
	public int getProgramId() {
		return 2;
	}

	
	
}
