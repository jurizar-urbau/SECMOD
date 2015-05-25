package com.urbau.beans;
import com.urbau.beans._interface.Bean;

public class SellerBean  implements Bean {
	
	private int id;
	private String name;
	private String surname;
	private String user;
	
	private int total_regs;

	
	public int getTotal_regs() {
		return this.total_regs;
	}
	public void setTotal_regs(int total_regs) {
		this.total_regs = total_regs;
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

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
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

}
