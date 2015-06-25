package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ProductoBean implements Bean {

	private int id;
	private String codigo;
	private String descripcion;
	private int coeficiente_unidad;
	private int proveedor;
	private double precio;
	private double precio_importacion;
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
	public double getPrecio_importacion() {
		return precio_importacion;
	}
	public void setPrecio_importacion(double precio_importacion) {
		this.precio_importacion = precio_importacion;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	
}
