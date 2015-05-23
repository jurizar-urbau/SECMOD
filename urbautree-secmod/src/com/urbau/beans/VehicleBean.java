package com.urbau.beans;
import com.urbau.beans._interface.Bean;

public class VehicleBean  implements Bean {
	
	private int id;
	private String marca;
	private String modelo;
	private String noPlaca;
	private String noChasis;
	private String estado; 
	private String licPirotecnia;
	private String licVencimiento;
	
	private int total_regs;

	
	public int getTotal_regs() {
		return this.total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	
	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public String getNoPlaca() {
		return noPlaca;
	}

	public void setNoPlaca(String noPlaca) {
		this.noPlaca = noPlaca;
	}

	public String getNoChasis() {
		return noChasis;
	}

	public void setNoChasis(String noChasis) {
		this.noChasis = noChasis;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getLicPirotecnia() {
		return licPirotecnia;
	}

	public void setLicPirotecnia(String licPirotecnia) {
		this.licPirotecnia = licPirotecnia;
	}

	public String getLicVencimiento() {
		return licVencimiento;
	}

	public void setLicVencimiento(String licVencimiento) {
		this.licVencimiento = licVencimiento;
	}

	@Override
	public int getId() {
		return id;
	}

	@Override
	public void setId(int i) {
		this.id = i;
	}

	@Override
	public int getProgramId() {
		return 0;
	}

}
