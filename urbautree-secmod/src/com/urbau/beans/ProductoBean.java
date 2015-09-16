package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ProductoBean implements Bean {

	private int id;
	private String codigo;
	private String descripcion;
	private int coeficiente_unidad;
	private int proveedor;
	private double precio;
	private double precio_1;
	private double precio_2;
	private double precio_3;
	private double precio_4;
	private String image_path;
	private int stock_minimo;
	
	private int total_regs;
	
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	
	public int getStock_minimo() {
		return stock_minimo;
	}
	public void setStock_minimo(int stock_minimo) {
		this.stock_minimo = stock_minimo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public int getCoeficiente_unidad() {
		return coeficiente_unidad;
	}
	public void setCoeficiente_unidad(int coeficiente_unidad) {
		this.coeficiente_unidad = coeficiente_unidad;
	}
	public int getProveedor() {
		return proveedor;
	}
	public void setProveedor(int proveedor) {
		this.proveedor = proveedor;
	}
	public double getPrecio() {
		return precio;
	}
	public void setPrecio(double precio) {
		this.precio = precio;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	public double getPrecio_1() {
		return precio / .9;
		//return precio_1;
	}
	public void setPrecio_1(double precio_1) {
		this.precio_1 = precio_1;
	}
	public double getPrecio_2() {
		return precio / .8;
		//return precio_2;
	}
	public void setPrecio_2(double precio_2) {
		this.precio_2 = precio_2;
	}
	public double getPrecio_3() {
		return precio / .7;
		//return precio_3;
	}
	public void setPrecio_3(double precio_3) {
		this.precio_3 = precio_3;
	}
	public double getPrecio_4() {
		return precio / .6;
		//return precio_4;
	}
	public void setPrecio_4(double precio_4) {
		this.precio_4 = precio_4;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	
}
