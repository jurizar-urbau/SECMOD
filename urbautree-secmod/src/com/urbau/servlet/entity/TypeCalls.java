package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eclipsesource.json.JsonArray;
import com.eclipsesource.json.JsonObject;
import com.urbau._abstract.entity.Entity;
import com.urbau.beans.Account;
import com.urbau.beans.TypeCallBean;
import com.urbau.feeders.AccountMain;
import com.urbau.feeders.TypeCallMain;


@WebServlet("/typecall")
public class TypeCalls extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String MODE = "mode";
	private static final String TYPE_FIELD = "type" ;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
		
			System.out.println( "message recieved: " + request.getQueryString() );
			String mode = request.getParameter( MODE );
			System.out.println( "mode: " + mode );
//			System.out.println( "id: " + request.getParameter( "id") );
			TypeCallMain typeCallMain = new TypeCallMain();
				
			JsonObject jo = new JsonObject();
			boolean status = false;
			
			if(ADD_MODE.equals( mode )) {
				System.out.println("add mode");
				//get Parameters 
				TypeCallBean tc = new TypeCallBean();
				tc.setType(request.getParameter( TYPE_FIELD ));
					
			status = typeCallMain.addItem(tc);
				
			}else if(DEL_MODE.equals(mode)) {
				Integer id = Integer.valueOf(   request.getParameter("id") );
				status =typeCallMain.delItemById(id);
				
				
			}else if(EDIT_MODE.equals(mode)) {
				
				status =  editRegister(request, typeCallMain);
				
				
			}else if(LIST_MODE.equals( mode )) {
				ArrayList<TypeCallBean> tcb = typeCallMain.getItems();
				JsonObject jsonBeans  = new JsonObject();
				Iterator<TypeCallBean> iTcb = tcb.iterator();
				while(iTcb.hasNext()) {
					TypeCallBean itBean = iTcb.next();
					jsonBeans.add(String.valueOf(itBean.getId()), itBean.getJsonBean());
					
				}
				status = true; 
				
				jo.add("data", jsonBeans);
			}
			
			
			processStatus(status,jo,response);
			
			
			
			
			
		
	}


	private void processStatus(boolean status, JsonObject jo, HttpServletResponse response) {

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


	private boolean editRegister(HttpServletRequest request,
			TypeCallMain typeCallMain) {
		Integer id = Integer.valueOf(   request.getParameter("id") );
		
		TypeCallBean typeCallBean = typeCallMain.getItem(id);
		if(typeCallBean != null ) {
			typeCallBean.setType(request.getParameter( TYPE_FIELD ));
			
			if(typeCallBean.getType() != null ) {
				return typeCallMain.modItem(typeCallBean);

			}else  {
				return false ;
			}
			
		}else {
			return false;
			
		}
			
		
		
	}


	
	
}
				
				
				

