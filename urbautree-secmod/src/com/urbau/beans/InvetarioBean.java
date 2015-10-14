package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class InvetarioBean implements Bean {
	
	private int idBodega;
	private int id_product;
	private String estatus;	
	private int amount;
	private int id_orden;
	
	int total_regs;
	
	private String prodCodigo;
	private String prodDescripcion;
	private int prodCoeficienteUnidad;
	private int prodProveedor;
	private double prodPrecio;
	private double prodPrecio1;
	private double prodPrecio2;
	private double prodPrecio3;
	private double prodPrecio4;
	private String prodImagePath;
	private int prodStockMinimo;
		
	public int getIdBodega() {
		return idBodega;
	}
	public void setIdBodega(int idBodega) {
		this.idBodega = idBodega;
	}		
	public int getId_product() {
		return id_product;
	}
	public void setId_product(int id_product) {
		this.id_product = id_product;
	}
	public String getEstatus() {
		return estatus;
	}
	public void setEstatus(String estatus) {
		this.estatus = estatus;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	
	public String getProdCodigo() {
		return prodCodigo;
	}
	public void setProdCodigo(String prodCodigo) {
		this.prodCodigo = prodCodigo;
	}
	public String getProdDescripcion() {
		return prodDescripcion;
	}
	public void setProdDescripcion(String prodDescripcion) {
		this.prodDescripcion = prodDescripcion;
	}
	public int getProdCoeficienteUnidad() {
		return prodCoeficienteUnidad;
	}
	public void setProdCoeficienteUnidad(int prodCoeficienteUnidad) {
		this.prodCoeficienteUnidad = prodCoeficienteUnidad;
	}
	public int getProdProveedor() {
		return prodProveedor;
	}
	public void setProdProveedor(int prodProveedor) {
		this.prodProveedor = prodProveedor;
	}
	public double getProdPrecio() {
		return prodPrecio;
	}
	public void setProdPrecio(double prodPrecio) {
		this.prodPrecio = prodPrecio;
	}
	public double getProdPrecio1() {
		return prodPrecio1;
	}
	public void setProdPrecio1(double prodPrecio1) {
		this.prodPrecio1 = prodPrecio1;
	}
	public double getProdPrecio2() {
		return prodPrecio2;
	}
	public void setProdPrecio2(double prodPrecio2) {
		this.prodPrecio2 = prodPrecio2;
	}
	public double getProdPrecio3() {
		return prodPrecio3;
	}
	public void setProdPrecio3(double prodPrecio3) {
		this.prodPrecio3 = prodPrecio3;
	}
	public double getProdPrecio4() {
		return prodPrecio4;
	}
	public void setProdPrecio4(double prodPrecio4) {
		this.prodPrecio4 = prodPrecio4;
	}
	public String getProdImagePath() {
		return prodImagePath;
	}
	public void setProdImagePath(String prodImagePath) {
		this.prodImagePath = prodImagePath;
	}
	public int getProdStockMinimo() {
		return prodStockMinimo;
	}
	public void setProdStockMinimo(int prodStockMinimo) {
		this.prodStockMinimo = prodStockMinimo;
	}
	
	
	public int getId_orden() {
		return id_orden;
	}
	public void setId_orden(int id_orden) {
		this.id_orden = id_orden;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	@Override
	public int getId() {
		
		return 0;
	}
	@Override
	public void setId(int i) {
		// TODO Auto-generated method stub		
	}
	
}
