package com.urbau.beans;

import java.util.Date;

public class OrdenPagoBean {

	private int id;
	private int orden_id;
	private Date fecha;
	private String tipo_pago;
	private String numero_autorizacion;
	private String numero_cheque;
	private int id_banco;
	private String tipo_tarjeta;
	private String numero_tarjeta;
	private double monto;
	private int id_usuario;
	private int punto_de_venta;
	private int caja_punto_de_venta;
	
	public int getPunto_de_venta() {
		return punto_de_venta;
	}
	public void setPunto_de_venta(int punto_de_venta) {
		this.punto_de_venta = punto_de_venta;
	}
	public int getCaja_punto_de_venta() {
		return caja_punto_de_venta;
	}
	public void setCaja_punto_de_venta(int caja_punto_de_venta) {
		this.caja_punto_de_venta = caja_punto_de_venta;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrden_id() {
		return orden_id;
	}
	public void setOrden_id(int orden_id) {
		this.orden_id = orden_id;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getTipo_pago() {
		return tipo_pago;
	}
	public void setTipo_pago(String tipo_pago) {
		this.tipo_pago = tipo_pago;
	}
	public String getNumero_autorizacion() {
		return numero_autorizacion;
	}
	public void setNumero_autorizacion(String numero_autorizacion) {
		this.numero_autorizacion = numero_autorizacion;
	}
	public String getNumero_cheque() {
		return numero_cheque;
	}
	public void setNumero_cheque(String numero_cheque) {
		this.numero_cheque = numero_cheque;
	}
	public int getId_banco() {
		return id_banco;
	}
	public void setId_banco(int id_banco) {
		this.id_banco = id_banco;
	}
	public String getTipo_tarjeta() {
		return tipo_tarjeta;
	}
	public void setTipo_tarjeta(String tipo_tarjeta) {
		this.tipo_tarjeta = tipo_tarjeta;
	}
	public String getNumero_tarjeta() {
		return numero_tarjeta;
	}
	public void setNumero_tarjeta(String numero_tarjeta) {
		this.numero_tarjeta = numero_tarjeta;
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
	
}
