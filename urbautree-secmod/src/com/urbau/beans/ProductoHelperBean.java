package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ProductoHelperBean implements Bean {

	private String mode;
	private String idString;
	private int id;
	private String codigo;
	private String descripcion;
	private String coeficiente_unidad;
	private String proveedor;
	private String precio;
	private String precio_1;
	private String precio_2;
	private String precio_3;
	private String precio_4;
	private String image_path;
	private String image_path_modified;
	private String stock_minimo;
	private int familia;
	
	private int total_regs;
	
	public int getTotal_regs() {
		return total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
		
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getStock_minimo() {
		return stock_minimo;
	}
	public void setStock_minimo(String stock_minimo) {
		this.stock_minimo = stock_minimo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}	
	public String getIdString() {
		return idString;
	}
	public void setIdString(String idString) {
		this.idString = idString;
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
	public String getCoeficiente_unidad() {
		return coeficiente_unidad;
	}
	public void setCoeficiente_unidad(String coeficiente_unidad) {
		this.coeficiente_unidad = coeficiente_unidad;
	}
	public String getProveedor() {
		return proveedor;
	}
	public void setProveedor(String proveedor) {
		this.proveedor = proveedor;
	}
	public String getPrecio() {		
		return precio;
	}
	public void setPrecio(String precio) {		
		this.precio = precio;
	}
	public String getImage_path() {
		return image_path;
	}
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}				
	public String getImage_path_modified() {
		return image_path_modified;
	}
	public void setImage_path_modified(String image_path_modified) {
		this.image_path_modified = image_path_modified;
	}
	public String getPrecio_1() {		
		return this.precio_1;
	}
	public void setPrecio_1(String precio_1) {
		this.precio_1 = precio_1;
	}
	public String getPrecio_2() {
		return precio_2;
	}
	public void setPrecio_2(String precio_2) {
		this.precio_2 = precio_2;
	}
	public String getPrecio_3() {
		return precio_3;
	}
	public void setPrecio_3(String precio_3) {
		this.precio_3 = precio_3;
	}
	public String getPrecio_4() {
		return precio_4;
	}
	public void setPrecio_4(String precio_4) {
		this.precio_4 = precio_4;
	}
	
	public int getFamilia() {
		return familia;
	}
	public void setFamilia(int familia) {
		this.familia = familia;
	}
	@Override
	public int getProgramId() {
		return 1;
	}
	
}
