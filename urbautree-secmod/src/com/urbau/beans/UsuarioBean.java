package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class UsuarioBean implements Bean {

	private int id;
	private String usuario;
	private String nombre;
	private String clave;
	private int rol;
	private boolean estado;
	private String email;
	private String telefono; 
	private int punto_de_venta;
	private String nombre_punto_venta;
	
	private int caja_punto_de_venta;
	private String nombre_caja_punto_venta;
	
	
	public String getNombre_punto_venta() {
		return nombre_punto_venta;
	}
	public void setNombre_punto_venta(String nombre_punto_venta) {
		this.nombre_punto_venta = nombre_punto_venta;
	}
	public int getPunto_de_venta() {
		return punto_de_venta;
	}
	public void setPunto_de_venta(int punto_de_venta) {
		this.punto_de_venta = punto_de_venta;
	}
	private int total_regs;
	
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	private boolean logged = false; 
	 
	public int getRol() {
		return rol;
	}
	public void setRol(int rol) {
		this.rol = rol;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	
	public void setLogged( boolean log){
		logged = log;
	}
	public boolean isLogged(){
		return logged;
	}
	
	public boolean isEstado() {
		return estado;
	}
	public void setEstado(boolean estado) {
		this.estado = estado;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	
	public int getCaja_punto_de_venta() {
		return caja_punto_de_venta;
	}
	public void setCaja_punto_de_venta(int caja_punto_de_venta) {
		this.caja_punto_de_venta = caja_punto_de_venta;
	}
	public String getNombre_caja_punto_venta() {
		return nombre_caja_punto_venta;
	}
	public void setNombre_caja_punto_venta(String nombre_caja_punto_venta) {
		this.nombre_caja_punto_venta = nombre_caja_punto_venta;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	
	
	
	
	
	
}
