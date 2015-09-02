	package com.urbau.beans;

import com.eclipsesource.json.JsonObject;
import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;
import com.urbau.beans._interface.Bean;
@DatabaseTable(tableName = "CLIENTS")
public class ClientBean  implements Bean {

	private int total_regs;
	//mapped fields
	@DatabaseField(generatedId = true )
	private int id;
	
	@DatabaseField(columnName ="RZSOCIAL" )
	private String rzsocial;
	
	@DatabaseField(columnName = "CLIENT")
	private String client;
	
	@DatabaseField(columnName = "FAX")
	private String fax;
	
	@DatabaseField(columnName = "FAXALT")
	private String faxalt;
	
	@DatabaseField(columnName = "TEL")
	private String tel;
	@DatabaseField(columnName = "TELALT")
	private String telalt;
	
	@DatabaseField(columnName = "NUMFISCAL"	)
	private String numfiscal;
	
	@DatabaseField(columnName = "ADDRFISCAL")
	private String addrfiscal;
	
	@DatabaseField(columnName = "EMAIL")
	private String email;
	
	@DatabaseField(columnName = "RATING")
	private int rating;
	
	@DatabaseField(columnName = "ADDRSHIP")
	private String addrship;
	
	@DatabaseField( columnName = "COUNTRY_ID",
				    foreign = true,
				    foreignAutoRefresh = true
					)
	private CountryBean country;
	
	@DatabaseField(columnName = "TIPO_CLIENTE",
					foreign = true,
					foreignAutoRefresh = true
					)
	private ClientTypeBean tipo_cliente;
	
	@DatabaseField(
			columnName = "SELLER",
			foreign = true,
			foreignAutoRefresh = true)
	private SellerBean seller;
	
	

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
	public CountryBean getCountry() {
		return country;
	}
	public void setCountry(CountryBean country) {
		this.country = country;
	}
	public ClientTypeBean getTipo_cliente() {
		return tipo_cliente;
	}
	public void setTipo_cliente(ClientTypeBean tipo_cliente) {
		this.tipo_cliente = tipo_cliente;
	}
	public SellerBean getSeller() {
		return seller;
	}
	public void setSeller(SellerBean seller) {
		this.seller = seller;
	}
	public JsonObject getJsonBean() {
		
		JsonObject jo  = new JsonObject();
		jo.add("id", this.getId());
		jo.add("rzsocial", 	this.getRzsocial());
		jo.add("client",	this.getClient());
		jo.add("fax", 		this.getFax());
		jo.add("faxalt",	this.getFaxalt());
		jo.add("tel", 		this.getTel());
		jo.add("telalt", 	this.getTelalt());
		jo.add("numfiscal", this.getNumfiscal());
		jo.add("addrfiscal", this.getAddrfiscal());
		jo.add("email", this.getEmail());
		jo.add("rating", this.getRating());
		jo.add("addrship", this.getAddrship());
		jo.add("country", this.getCountry().getId());
		jo.add("countryObj", this.getCountry().getJsonBean());

		if(this.getTipo_cliente() != null) {
			jo.add("tipoCliente", this.getTipo_cliente().getId());
			jo.add("tipoClientObj", this.getTipo_cliente().getJsonBean());
			
		}
		
		if(this.getSeller() != null) {
			jo.add("seller", this.getSeller().getId());
			jo.add("sellerObj", this.getSeller().getJsonBean());
			
		}
		
		
		
		return  jo;
	}
	
	
}
