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
import com.urbau.beans.ClientBean;
import com.urbau.feeders.ClientMain;


@WebServlet("/clients")
public class Clients extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String MODE = "mode";
	private static final String TYPE_FIELD = "type" ;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    		throws ServletException, IOException {
		
			System.out.println( "message recieved: " + request.getQueryString() );
			String mode = request.getParameter( MODE );
			System.out.println( "mode: " + mode );
//			System.out.println( "id: " + request.getParameter( "id") );
			
			ClientMain fieldMain = new ClientMain(); 	
			JsonObject jo = new JsonObject();
			boolean status = false;
			
			if(ADD_MODE.equals( mode )) {
				System.out.println("add mode");
				//get Parameters 
				ClientBean bean = new ClientBean();
				bean.setRzsocial( request.getParameter("rzsocial") );
				bean.setClient(	request.getParameter("client"));
				bean.setFax(		request.getParameter("fax"));
				bean.setFaxalt(	request.getParameter("faxalt"));
				bean.setNumfiscal(request.getParameter("numfiscal"));
				bean.setAddrfiscal(request.getParameter("addrfiscal"));
				bean.setEmail(	request.getParameter("email"));
				bean.setRating( 	Integer.valueOf(request.getParameter("rating")) );
				bean.setAddrship(	request.getParameter("addrship"));
				bean.setCountry( 	Integer.valueOf(request.getParameter("country")));
				bean.setTipo_cliente( Integer.valueOf(request.getParameter("tipocliente")));
				bean.setSeller(	Integer.valueOf(request.getParameter("seller")));
					
			status = fieldMain.addItem(bean);
				
			}else if(DEL_MODE.equals(mode)) {
				Integer id = Integer.valueOf(   request.getParameter("id") );
				status =fieldMain.delItemById(id);
				
				
			}else if(EDIT_MODE.equals(mode)) {
				
				status =  editRegister(request, fieldMain);
				
				
			}else if(LIST_MODE.equals( mode )) {
				ArrayList<ClientBean> tcb = fieldMain.getItems();
				JsonObject jsonBeans  = new JsonObject();
				Iterator<ClientBean> iTcb = tcb.iterator();
				while(iTcb.hasNext()) {
					ClientBean itBean = iTcb.next();
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
			ClientMain beanMain) {
		Integer id = Integer.valueOf(   request.getParameter("id") );
		
		ClientBean editBean = beanMain.getItem(id);
		if(editBean != null ) {
			
			editBean.setRzsocial( request.getParameter("rzsocial") );
			editBean.setClient(	request.getParameter("client"));
			editBean.setFax(		request.getParameter("fax"));
			editBean.setFaxalt(	request.getParameter("faxalt"));
			editBean.setNumfiscal(request.getParameter("numfiscal"));
			editBean.setAddrfiscal(request.getParameter("addrfiscal"));
			editBean.setEmail(	request.getParameter("email"));
			editBean.setRating( 	Integer.valueOf(request.getParameter("rating")) );
			editBean.setAddrship(	request.getParameter("addrship"));
			editBean.setCountry( 	Integer.valueOf(request.getParameter("country")));
			editBean.setTipo_cliente( Integer.valueOf(request.getParameter("tipocliente")));
			editBean.setSeller(	Integer.valueOf(request.getParameter("seller")));
			
			return beanMain.modItem(editBean);
			
			
		}else {
			return false;
			
		}
			
		
		
	}


	
	
}
				
				
				

