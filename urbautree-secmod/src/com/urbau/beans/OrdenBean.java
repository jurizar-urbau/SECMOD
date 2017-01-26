package com.urbau.beans;

import java.util.Date;

import com.urbau.beans._interface.Bean;

public class OrdenBean implements Bean {

	private int id;
	private Date fecha;	
	private int id_cliente;
	private int id_bodega;
	private double monto;
	private int id_usuario;
	private String uid;
	
	private int total_regs;
	private String estado;
	private int id_punto_venta;
	
	private String name;
	
	public int getId_punto_venta() {
		return id_punto_venta;
	}

	public void setId_punto_venta(int id_punto_venta) {
		this.id_punto_venta = id_punto_venta;
	}

	public String getEstado() {
		return estado;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
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


	public int getId_cliente() {
		return id_cliente;
	}


	public void setId_cliente(int id_cliente) {
		this.id_cliente = id_cliente;
	}


	public int getId_bodega() {
		return id_bodega;
	}


	public void setId_bodega(int id_bodega) {
		this.id_bodega = id_bodega;
	}


	public double getMonto() {
		return monto;
	}


	public void setMonto(double monto) {
		this.monto = monto;
	}


	public int getId_usuario() {
		return id_usuario;
	}


	public void setId_usuario(int id_usuario) {
		this.id_usuario = id_usuario;
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


	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
