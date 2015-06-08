package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ProveedorBean implements Bean {

	private int id;
	private String nit;
	private String codigo;
	private String nombre;
	private String razonSocial;
	private String contacto;
	private String direccion;
	private String telefono;	
	private String email;
	private int pais;
	private int moneda;
	private double limiteCredito;
	private double saldo;		
	private int total_regs;
	
	public String getNit() {
		return nit;
	}
	public void setNit(String nit) {
		this.nit = nit;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getRazonSocial() {
		return razonSocial;
	}
	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}
	public String getContacto() {
		return contacto;
	}
	public void setContacto(String contacto) {
		this.contacto = contacto;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPais() {
		return pais;
	}
	public void setPais(int pais) {
		this.pais = pais;
	}
	public int getMoneda() {
		if(moneda == 0){
			moneda = 1;
		}
		return moneda;
	}
	public void setMoneda(int moneda) {
		this.moneda = moneda;
	}
	public double getLimiteCredito() {
		return limiteCredito;
	}
	public void setLimiteCredito(double limiteCredito) {
		this.limiteCredito = limiteCredito;
	}
	public double getSaldo() {
		return saldo;
	}
	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}
	public boolean isLogged() {
		return logged;
	}
	public void setLogged(boolean logged) {
		this.logged = logged;
	}
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	private boolean logged = false; 
	 	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
							
	@Override
	public int getProgramId() {
		return 1;
	}	
}
