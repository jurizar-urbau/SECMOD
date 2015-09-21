package com.urbau.beans;

import com.urbau.beans._interface.Bean;
import java.util.Date;

public class BancoMovimientoBean implements Bean {
	
	private int id;	
	private int total_regs;
	private int idBanco;
	private Date fecha;
	private int idTipoMovimiento;
	private String descripcion;
	private double monto;
	private String descripcionTipoMovimiento;
		
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
				
	public int getIdBanco() {
		return idBanco;
	}
	public void setIdBanco(int idBanco) {
		this.idBanco = idBanco;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public int getIdTipoMovimiento() {
		return idTipoMovimiento;
	}
	public void setIdTipoMovimiento(int idTipoMovimiento) {
		this.idTipoMovimiento = idTipoMovimiento;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public double getMonto() {
		return monto;
	}
	public void setMonto(double monto) {
		this.monto = monto;
	}	
	public String getDescripcionTipoMovimiento() {
		return descripcionTipoMovimiento;
	}
	public void setDescripcionTipoMovimiento(String descripcionTipoMovimiento) {
		this.descripcionTipoMovimiento = descripcionTipoMovimiento;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	
}
