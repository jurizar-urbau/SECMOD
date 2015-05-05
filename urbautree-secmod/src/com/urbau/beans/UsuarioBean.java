package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class UsuarioBean implements Bean {

	private int id;
	private String usuario;
	private String nombre;
	private String clave;
	private int rol;
	private boolean estado;
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
	@Override
	public int getProgramId() {
		return 1;
	}
	
	
	
	
	
}
