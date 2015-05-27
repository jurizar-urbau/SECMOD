package com.urbau.beans;

import com.urbau.beans._interface.Bean;

public class ShowBean  implements Bean {

	
	public static String SQL_FIELDS =  "NAME  ,DATE  ,CLIENT  ,PLACE  ,LENGHT  ,SELLER  ,"
			+ "FISCAL_NUM  ,BALANCE  ,STATUS  ,TYPE  ,HOUR  ,CONTACT  ,DESCRIPTION  ,"
			+ "MELODY  ,TOTAL  ,INVOICE_NAME  ,OBSERVATIONS ";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "SHOWS";
	
	public static String NAME_TAG =  "{name}";
	public static String DATE_TAG =  "{date}";
	public static String CLIENT_TAG =  "{client}";
	public static String PLACE_TAG =  "{place}";
	public static String LENGHT_TAG =  "{lenght}";
	public static String SELLER_TAG =  "{seller}";
	public static String FISCAL_NUM_TAG =  "{fiscal_num}";
	public static String BALANCE_TAG =  "{balance}";
	public static String STATUS_TAG =  "{status}";
	public static String TYPE_TAG =  "{type}";
	public static String HOUR_TAG =  "{hour}";
	public static String CONTACT_TAG =  "{contact}";
	public static String DESCRIPTION_TAG =  "{description}";
	public static String MELODY_TAG =  "{melody}";
	public static String TOTAL_TAG =  "{total}";
	public static String INVOICE_NAME_TAG =  "{invoice_name}";
	public static String OBSERVATIONS_TAG =  "{observations}";
	
	
	
	private int total_regs;
	//mapped fields from table 
	private String  name;
	
	private String  date;
	private String  client;
	private String  place;
	private String  lenght;
	private String  seller;
	private String  fiscalNum;
	private String  balance;
	private String  status;
	private String  type;
	private String  hour;
	private String  contact;
	private String  description;
	private String  melody;
	private String  total;
	private String  invoiceName;
	private String  observations;



	private int id;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getLenght() {
		return lenght;
	}
	public void setLenght(String lenght) {
		this.lenght = lenght;
	}
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public String getFiscalNum() {
		return fiscalNum;
	}
	public void setFiscalNum(String fiscalNum) {
		this.fiscalNum = fiscalNum;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getHour() {
		return hour;
	}
	public void setHour(String hour) {
		this.hour = hour;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getMelody() {
		return melody;
	}
	public void setMelody(String melody) {
		this.melody = melody;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getInvoiceName() {
		return invoiceName;
	}
	public void setInvoiceName(String invoiceName) {
		this.invoiceName = invoiceName;
	}
	public String getObservations() {
		return observations;
	}
	public void setObservations(String observations) {
		this.observations = observations;
	}
	
}
