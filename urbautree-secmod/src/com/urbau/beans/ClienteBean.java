package com.urbau.beans;

import java.util.Date;

import com.urbau.beans._interface.Bean;

public class ClienteBean implements Bean {

	private int id;
	private String nit;
	private String nombres;
	private String apellidos;
	private String direccion;
	private String email;
	private String telefono;
	private String celular;
	private Date   fecha_ingreso;
	private String observaciones;
	private String tipoDeCliente;
	private int acepta_credito;
	
	private int total_regs;
	
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNit() {
		return nit;
	}
	public void setNit(String nit) {
		this.nit = nit;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public String getApellidos() {
		return apellidos;
	}
	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public Date getFecha_ingreso() {
		return fecha_ingreso;
	}
	public void setFecha_ingreso(Date fecha_ingreso) {
		this.fecha_ingreso = fecha_ingreso;
	}
		public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setTipoDeCliente(String tipoDeCliente) {
		this.tipoDeCliente = tipoDeCliente;
	}
	public String getTipoDeCliente() {
		return tipoDeCliente;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	
	public int getAcepta_credito() {
		return acepta_credito;
	}
	public void setAcepta_credito(int acepta_credito) {
		this.acepta_credito = acepta_credito;
	}
	@Override
	public int getProgramId() {
		return 2;
	}
	
}
