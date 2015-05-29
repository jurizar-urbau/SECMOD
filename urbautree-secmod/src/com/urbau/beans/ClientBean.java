	package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ClientBean  implements Bean {

	private int total_regs;
	//mapped fields
	private int id;
	
	private String rzsocial;
	private String client;
	private String fax;
	private String faxalt;
	private String tel;
	private String telalt;
	private String numfiscal;
	private String addrfiscal;
	private String email;
	private int rating;
	private String addrship;
	private int country;
	private int tipo_cliente;
	private int seller;
	
	
	
	public static String SQL_FIELDS = " RZSOCIAL, CLIENT, FAX, FAXALT, TEL, "+
			  "TELALT, NUMFISCAL, ADDRFISCAL, EMAIL, " +
			    "RATING, ADDRSHIP, COUNTRY, TIPO_CLIENTE, SELLER";
	
		public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
		public static String TABLE = "CLIENTS";
		public static final String  RZSOCIAL_TAG =  "{rzsocial}"; 
		public static final String  CLIENT_TAG =  "{client}"; 
		public static final String  FAX_TAG =  "{fax}"; 
		public static final String  FAXALT_TAG =  "{faxalt}"; 
		public static final String  TEL_TAG =  "{tel}"; 
		public static final String  TELALT_TAG =  "{telalt}"; 
		public static final String  NUMFISCAL_TAG =  "{numfiscal}"; 
		public static final String  ADDRFISCAL_TAG =  "{addrfiscal}"; 
		public static final String  EMAIL_TAG =  "{email}"; 
		public static final String  RATING_TAG =  "{rating}";
		public static final String  ADDRSHIP_TAG =  "{addrship}"; 
		public static final String  COUNTRY_TAG =  "{country}"; 
		public static final String  TIPO_CLIENTE_TAG =  "{tipo_cliente}"; 
		public static final String  SELLER_TAG =  "{seller}";    
		
	

	public int getTotal_regs() {
		return this.total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
	}
	@Override
	public int getId() {
		return this.id;
	}
	@Override
	public void setId(int i) {
		this.id = i;
		
	}
	@Override
	public int getProgramId() {
		// TODO Auto-generated method stub
		return 0;
	}
	public String getRzsocial() {
		return rzsocial;
	}
	public void setRzsocial(String rzsocial) {
		this.rzsocial = rzsocial;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getFaxalt() {
		return faxalt;
	}
	public void setFaxalt(String faxalt) {
		this.faxalt = faxalt;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTelalt() {
		return telalt;
	}
	public void setTelalt(String telalt) {
		this.telalt = telalt;
	}
	public String getNumfiscal() {
		return numfiscal;
	}
	public void setNumfiscal(String numfiscal) {
		this.numfiscal = numfiscal;
	}
	public String getAddrfiscal() {
		return addrfiscal;
	}
	public void setAddrfiscal(String addrfiscal) {
		this.addrfiscal = addrfiscal;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getAddrship() {
		return addrship;
	}
	public void setAddrship(String addrship) {
		this.addrship = addrship;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getCountry() {
		return country;
	}
	public void setCountry(int country) {
		this.country = country;
	}
	public int getTipo_cliente() {
		return tipo_cliente;
	}
	public void setTipo_cliente(int tipo_cliente) {
		this.tipo_cliente = tipo_cliente;
	}
	public int getSeller() {
		return seller;
	}
	public void setSeller(int seller) {
		this.seller = seller;
	}
	
	
}
