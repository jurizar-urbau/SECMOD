package com.urbau.beans;
import java.util.Calendar;

import com.urbau.beans._interface.Bean;

public class CallsBean  implements Bean {
	
	private int id;
	private String topic; 
	

	private Calendar callDate;
	private String reason;
	private String client;
	private String description;
	private String type;
	private String status;
	private String seller;
	private String contact;
	
	
	public static String SQL_FIELDS = "TOPIC, DATE_CALL, REASON, CLIENT "
			+ "DESCRIPTION, TYPE, STATUS, SELLER, CONTACT";

	public static String SQL_STATMENT = "SELECT ID,"+SQL_FIELDS+"  FROM ";
	public static String TABLE = "CALLS";
	
	public static final String TOPIC_TAG = "{topic}";
	public static final String DATE_CALL_TAG = "{date_call}";
	public static final String REASON_TAG = "{reason}";
	public static final String CLIENT_TAG = "{client}";  
	public static final String DESCRIPTION_TAG = "{description}";
	public static final String TYPE_TAG = "{type}";
	public static final String STATUS_TAG = "{status}"; 
	public static final String SELLER_TAG = "{seller}";
	public static final String CONTACT_TAG = "{contact}";
	
	private int total_regs;

	
	public int getTotal_regs() {
		return this.total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
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
	
	
	public String getTopic() {
		return topic;
	}
	public void setTopic(String topic) {
		this.topic = topic;
	}
	public Calendar getCallDate() {
		return callDate;
	}
	public void setCallDate(Calendar callDate) {
		this.callDate = callDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSeller() {
		return seller;
	}
	public void setSeller(String seller) {
		this.seller = seller;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}

}
