package com.urbau.servlet.entity;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eclipsesource.json.JsonObject;
import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ClientTypeBean;
import com.urbau.beans._interface.Bean;

public class GenericEntity extends Entity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3589487646484536398L;
	protected static final String MODE = "mode";
	
	

	protected void processStatus(boolean status, JsonObject jo, HttpServletResponse response) {

		if(status) {	
			jo.add("status", "ok");
				jo.add("message", "success!");
				response.setStatus(200);;
				System.out.println("success!");	
			}else {
				jo.add("status","error");
				jo.add("message","error");
				response.setStatus(400);
				System.out.println("error!");
			}				
		
		response.addHeader("content-type", "application/json");
		try {
			response.getOutputStream().write( jo.toString().getBytes());
			response.getOutputStream().flush();
			response.getOutputStream().close();

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	
	
	
}
