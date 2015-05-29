package com.urbau.beans;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import com.urbau.beans._interface.Bean;

public class ContactBean  implements Bean {
   
	public final static  HashMap<String,String> MAP_FIELDS;
	static{
		Map<String,String> aMap = new HashMap<>();
		aMap.put("NAME","NAME_TAG" );
		MAP_FIELDS = (HashMap<String, String>) Collections.unmodifiableMap(aMap);
	}	
	
	public static String SQL_FIELDS = "NAME, SURNAME, TEL1, TEL2, MOBILE, "
								    + "ASINGMENT, EMAIL, EMAIL2, COMMENT, AREA, FAX, COUNTRY, USER, "
								    + "CLIENT, ADDRR1LINE1, ADDRR1LINE2, MUNICIPALITY1, DEPTO1, "
								    + "ADDRR2LINE1, ADDRR2LINE2, DEPTO2, MUNICIPALITY2";
	
	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "CONTACTS";
	
	
	private int total_regs;
	//mapped fields
	private int id;
	
	private String name;
	private String surname;
	private String tel1;
	private String tel2;
	private String mobile;
	private String asingment;
	private String email;
	private String email2;
	private String comment;
	private String area;
	private String fax;
	private int country;
	private int user;
	private int client;
	private String addrr1line1;
	private String addrr1line2;
	private int municipality1;
	private int depto1;
	private String addrr2line1;
	private String addrr2line2;
	private int depto2;
	private int municipality2;
	
	public static String NAME_TAG = "{name}";
	public static String SURNAME_TAG = "{surname}";
	public static String TEL1_TAG = "{tel1}";
	public static String TEL2_TAG = "{tel2}";
	public static String MOBILE_TAG = "{mobile}";
	public static String ASINGMENT_TAG = "{asingment}";
	public static String EMAIL_TAG = "{email}";
	public static String EMAIL2_TAG = "{email2}";
	public static String COMMENT_TAG = "{comment}";
	public static String AREA_TAG = "{area}";
	public static String FAX_TAG = "{fax}";
	public static String COUNTRY_TAG = "{country}";
	public static String USER_TAG = "{user}";
	public static String CLIENT_TAG = "{client}";
	public static String ADDRR1LINE1_TAG = "{addrr1line1}";
	public static String ADDRR1LINE2_TAG = "{addrr1line2}";
	public static String MUNICIPALITY1_TAG = "{municipality1}";
	public static String DEPTO1_TAG = "{depto1}";
	public static String ADDRR2LINE1_TAG = "{addrr2line1}";
	public static String ADDRR2LINE2_TAG = "{addrr2line2}";
	public static String DEPTO2_TAG = "{depto2}";
	public static String MUNICIPALITY2_TAG = "{municipality2}";
	
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
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getAsingment() {
		return asingment;
	}
	public void setAsingment(String asingment) {
		this.asingment = asingment;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	
	public String getAddrr1line1() {
		return addrr1line1;
	}
	public void setAddrr1line1(String addrr1line1) {
		this.addrr1line1 = addrr1line1;
	}
	public String getAddrr1line2() {
		return addrr1line2;
	}
	public void setAddrr1line2(String addrr1line2) {
		this.addrr1line2 = addrr1line2;
	}
	
	public String getAddrr2line1() {
		return addrr2line1;
	}
	public void setAddrr2line1(String addrr2line1) {
		this.addrr2line1 = addrr2line1;
	}
	public String getAddrr2line2() {
		return addrr2line2;
	}
	public void setAddrr2line2(String addrr2line2) {
		this.addrr2line2 = addrr2line2;
	}
	public int getCountry() {
		return country;
	}
	public void setCountry(int country) {
		this.country = country;
	}
	public int getUser() {
		return user;
	}
	public void setUser(int user) {
		this.user = user;
	}
	public int getClient() {
		return client;
	}
	public void setClient(int client) {
		this.client = client;
	}
	public int getMunicipality1() {
		return municipality1;
	}
	public void setMunicipality1(int municipality1) {
		this.municipality1 = municipality1;
	}
	public int getDepto1() {
		return depto1;
	}
	public void setDepto1(int depto1) {
		this.depto1 = depto1;
	}
	public int getDepto2() {
		return depto2;
	}
	public void setDepto2(int depto2) {
		this.depto2 = depto2;
	}
	public int getMunicipality2() {
		return municipality2;
	}
	public void setMunicipality2(int municipality2) {
		this.municipality2 = municipality2;
	}
	
}
