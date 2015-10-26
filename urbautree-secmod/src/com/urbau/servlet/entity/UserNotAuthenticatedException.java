package com.urbau.servlet.entity;

public class UserNotAuthenticatedException extends Exception {
	
	private static final long serialVersionUID = 8939383614907466950L;

	public UserNotAuthenticatedException( String message ){
		super( message );
	}
	
}
