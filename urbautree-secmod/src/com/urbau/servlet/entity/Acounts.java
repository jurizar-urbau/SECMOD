package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eclipsesource.json.JsonArray;
import com.eclipsesource.json.JsonObject;
import com.urbau._abstract.entity.Entity;
import com.urbau.beans.Account;
import com.urbau.feeders.AccountMain;


@WebServlet("/account")
public class Acounts extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String ADD_MODE = "add";
	private static final String DEL_MODE = "remove";
	private static final String EDIT_MODE = "edits";
	private static final String USER_PAR = "user";
	private static final String PASS_PAR = "password";
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			System.out.println( "message recieved: " + request.getQueryString() );
			String mode = request.getParameter( "mode" );
			System.out.println( "mode: " + mode );
			System.out.println( "id: " + request.getParameter( "id") );
			AccountMain acm = new AccountMain();
				
			
			if(mode.equals(ADD_MODE)) {
				System.out.println("add mode");
				String user =request.getParameter(USER_PAR);
				String pass =request.getParameter(PASS_PAR);
				if(user != null && pass != null ) {
					System.out.println("user is :" +user +"\n" + "pass is" + pass);
					Account addAccount = new Account(user);
					addAccount.setPassword(pass);
					try {
						acm.addItem(addAccount);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			
			
			String message = "";
			if( request.getParameter( "id" ) != null  ){
			try {
				ArrayList<Account> acl =  acm.getItems();
			
				String id = request.getParameter( "id" );
					response.addHeader("content-type", "application/json");
					JsonObject jsonObject = new JsonObject();
							Iterator<Account> it = acl.iterator();
							while(it.hasNext()) {
								JsonObject jo = new JsonObject();
								Account acc = it.next();
								jo.add("name",  acc.getName());
								jo.add("pass",  acc.getPassword());
								jsonObject.add(String.valueOf(acc.getId()), jo);
							}
							
					response.getOutputStream().write( jsonObject.toString().getBytes());
					response.getOutputStream().flush();
					response.getOutputStream().close();
			
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
			
			
		
	}
	
}
				
				
				

