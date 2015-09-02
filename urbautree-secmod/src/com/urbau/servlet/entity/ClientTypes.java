package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eclipsesource.json.JsonObject;
import com.urbau.beans.ClientTypeBean;
import com.urbau.beans._interface.Bean;
import com.urbau.feeders.ClientTypeMain;;
@WebServlet("/clienttype")
public class ClientTypes extends GenericEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5085293567931702126L;
	
	private static final String CLIENT_TYPE_FIELD = "type" ;

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
				ClientTypeBean bean = (ClientTypeBean) populateBean(request);
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
	  ClientTypeMain fieldMain = new ClientTypeMain(); 
	  ArrayList<ClientTypeBean> tcb = fieldMain.getItems();
	JsonObject jsonBeans  = new JsonObject();
	Iterator<ClientTypeBean> iTcb = tcb.iterator();
	while(iTcb.hasNext()) {
			ClientTypeBean itBean = iTcb.next();
			jsonBeans.add(String.valueOf(itBean.getId()), itBean.getJsonBean());
			
		}
		return jsonBeans;
	}


private boolean delItem(HttpServletRequest request) {
	  ClientTypeMain fieldMain = new ClientTypeMain(); 
	  Integer id = Integer.valueOf(   request.getParameter("id") );
	  return  fieldMain.delItemById(id);
		 
	}


private Boolean addItem(Bean bean ) {
      ClientTypeMain fieldMain = new ClientTypeMain(); 
	  return fieldMain.addItem((ClientTypeBean) bean);
  }

  private Bean populateBean( HttpServletRequest request ) {
	  ClientTypeBean bean = new ClientTypeBean();
	  bean.setType( request.getParameter(CLIENT_TYPE_FIELD));
	  return bean;
  }

	private boolean editRegister(HttpServletRequest request) {
		 ClientTypeMain fieldMain = new ClientTypeMain(); 
		Integer id = Integer.valueOf(   request.getParameter("id") );
		ClientTypeBean editBean = fieldMain.getItem(id);
		if(editBean != null ) {
			editBean.setType(	request.getParameter(CLIENT_TYPE_FIELD));
			return fieldMain.modItem(editBean);
						
		}else {
			return false;
			
		}
			
		
		
	}
	
}
