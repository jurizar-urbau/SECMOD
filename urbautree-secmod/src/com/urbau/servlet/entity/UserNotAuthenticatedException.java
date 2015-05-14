package com.urbau.servlet.entity;

public class UserNotAuthenticatedException extends Exception {
	
	public UserNotAuthenticatedException( String message ){
		super( message );
	}

}
