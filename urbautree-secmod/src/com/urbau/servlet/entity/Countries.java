package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eclipsesource.json.JsonObject;
import com.urbau._abstract.entity.Entity;
import com.urbau.beans.CountryBean;
import com.urbau.feeders.CountryMain;


@WebServlet("/countries")
public class Countries extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String MODE = "mode";
	private static final String COUNTRY_FIELD = "countryName" ;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
		
			System.out.println( "message recieved: " + request.getQueryString() );
			String mode = request.getParameter( MODE );
			System.out.println( "mode: " + mode );
//			System.out.println( "id: " + request.getParameter( "id") );
			
			CountryMain fieldMain = new CountryMain(); 	
			JsonObject jo = new JsonObject();
			boolean status = false;
			
			if(ADD_MODE.equals( mode )) {
				System.out.println("add mode");
				//get Parameters 
				CountryBean bean = new CountryBean();
				bean.setCountry(  request.getParameter(COUNTRY_FIELD));
					
			status = fieldMain.addItem(bean);
				
			}else if(DEL_MODE.equals(mode)) {
				Integer id = Integer.valueOf(   request.getParameter("id") );
				status =fieldMain.delItemById(id);
				
				
			}else if(EDIT_MODE.equals(mode)) {
				
				status =  editRegister(request, fieldMain);
				
				
			}else if(LIST_MODE.equals( mode )) {
				ArrayList<CountryBean> tcb = fieldMain.getItems();
				JsonObject jsonBeans  = new JsonObject();
				Iterator<CountryBean> iTcb = tcb.iterator();
				while(iTcb.hasNext()) {
					CountryBean itBean = iTcb.next();
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
			CountryMain beanMain) {
		Integer id = Integer.valueOf(   request.getParameter("id") );
		
		CountryBean editBean = beanMain.getItem(id);
		if(editBean != null ) {
			
			editBean.setCountry(	request.getParameter(COUNTRY_FIELD));
			
			return beanMain.modItem(editBean);
			
			
		}else {
			return false;
			
		}
			
		
		
	}


	
	
}
				
				
				

