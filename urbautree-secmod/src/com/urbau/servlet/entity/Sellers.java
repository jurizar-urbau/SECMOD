package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.eclipsesource.json.JsonObject;
import com.urbau._abstract.entity.Entity;
import com.urbau.beans.SellerBean;
import com.urbau.beans._interface.Bean;
import com.urbau.feeders.SellerMain;


@WebServlet("/sellers")
public class Sellers extends GenericEntity {
	
	private static final String FIELD_NAME = "name" ;
	private static final String FIELD_SURNAME = "surname" ;
	private static final String FIELD_USER = "user" ;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
		
			System.out.println( "message recieved: " + request.getQueryString() );
			String mode = request.getParameter( MODE );
			System.out.println( "mode: " + mode );
//			System.out.println( "id: " + request.getParameter( "id") );
			JsonObject jo = new JsonObject();
			boolean status = false;
			
			if(ADD_MODE.equals( mode )) {
				System.out.println("add mode");
				SellerBean bean = (SellerBean) populateBean(request);
				status = addItem(bean);
				
			}else if(DEL_MODE.equals(mode)) {
				status =delItem(request);
				
			}else if(EDIT_MODE.equals(mode)) {
				status =  editRegister(request);
				
				
			}else if(LIST_MODE.equals( mode )) {
				
				JsonObject jsonBeans = getListBeans();
				
				status = true; 
				
				jo.add("data", jsonBeans);
			}
			
			
			processStatus(status,jo,response);
			
			
			
			
			
		
	}


  private JsonObject getListBeans() {
	  SellerMain fieldMain = new SellerMain(); 
	  ArrayList<SellerBean> tcb = fieldMain.getItems();
	JsonObject jsonBeans  = new JsonObject();
	Iterator<SellerBean> iTcb = tcb.iterator();
	while(iTcb.hasNext()) {
			SellerBean itBean = iTcb.next();
			jsonBeans.add(String.valueOf(itBean.getId()), itBean.getJsonBean());
			
		}
		return jsonBeans;
	}


private boolean delItem(HttpServletRequest request) {
	  SellerMain fieldMain = new SellerMain(); 
	  Integer id = Integer.valueOf(   request.getParameter("id") );
	  return  fieldMain.delItemById(id);
		 
	}


private Boolean addItem(Bean bean ) {
      SellerMain fieldMain = new SellerMain(); 
	  return fieldMain.addItem((SellerBean) bean);
  }

  private Bean populateBean( HttpServletRequest request ) {
	  SellerBean bean = new SellerBean();
	  
	  bean.setName( request.getParameter(FIELD_NAME));
	  bean.setSurname( request.getParameter(FIELD_SURNAME));
	  bean.setUser( request.getParameter(FIELD_USER));
	  
	  return bean;
  }

	private boolean editRegister(HttpServletRequest request) {
		 SellerMain fieldMain = new SellerMain(); 
		Integer id = Integer.valueOf(   request.getParameter("id") );
		SellerBean editBean = fieldMain.getItem(id);
		if(editBean != null ) {
			editBean.setName( request.getParameter(FIELD_NAME));
			editBean.setSurname( request.getParameter(FIELD_SURNAME));
			editBean.setUser( request.getParameter(FIELD_USER));
			  
			  return fieldMain.modItem(editBean);
						
		}else {
			return false;
			
		}
			
		
		
	}
}
				
				
				
