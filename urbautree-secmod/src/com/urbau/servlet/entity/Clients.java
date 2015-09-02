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
import com.urbau.beans.ClientTypeBean;
import com.urbau.beans.CountryBean;
import com.urbau.beans.SellerBean;
import com.urbau.feeders.ClientMain;
import com.urbau.feeders.ClientTypeMain;
import com.urbau.feeders.CountryMain;
import com.urbau.feeders.SellerMain;


@WebServlet("/clients")
public class Clients extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String MODE = "mode";
	private static final String TYPE_FIELD = "type" ;
	private static final String SELLER_FIELD = "seller";
	private static final String CLIENT_TYPE_FIELD = "tipoCliente";
	private static final String COUNTRY_FIELD = "country";

	
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
				bean.setTel(	 request.getParameter("tel"));
				bean.setTelalt(	 request.getParameter("telalt"));
				bean.setFaxalt(	request.getParameter("faxalt"));
				bean.setNumfiscal(request.getParameter("numfiscal"));
				bean.setAddrfiscal(request.getParameter("addrfiscal"));
				bean.setEmail(	request.getParameter("email"));
				
				bean.setRating( 	getIntParameter(request,"rating"));
				
				bean.setAddrship(	request.getParameter("addrship"));
				CountryMain countryMain = new  CountryMain(); 
				CountryBean cbBean = countryMain.getItem(getIntParameter(request,COUNTRY_FIELD ));
				bean.setCountry( 	cbBean);
				ClientTypeMain ctMain = new ClientTypeMain();
				ClientTypeBean ctBean = ctMain.getItem(getIntParameter(request, CLIENT_TYPE_FIELD ));
				bean.setTipo_cliente(ctBean);
				SellerMain sellerMain = new SellerMain();
				SellerBean sellerBean = sellerMain.getItem(getIntParameter(request, SELLER_FIELD));
				bean.setSeller(sellerBean);
					
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode  = request.getParameter("mode");
		ClientMain fieldMain = new ClientMain(); 	
		JsonObject jo = new JsonObject();
		boolean status = false;
	
		if(LIST_MODE.equals(mode)) {
			ArrayList<ClientBean> tcb = fieldMain.getItems();
			JsonObject jsonBeans  = new JsonObject();
			Iterator<ClientBean> iTcb = tcb.iterator();
			while(iTcb.hasNext()) {
				ClientBean itBean = iTcb.next();
				jsonBeans.add(String.valueOf(itBean.getId()), itBean.getJsonBean());
				
			}
			status = true; 
			
			jo.add("data", jsonBeans);
		}else if(VIEW_MODE.equals(mode)){
			String id = request.getParameter("id");
			if(!id.isEmpty()){
				ClientBean cb = fieldMain.getItem(Integer.valueOf(id));
				if(cb != null ) {
					jo = cb.getJsonBean();
					status = true;
				} else {
					status = false;
					jo.add("message", "id didint exist");
				}
				
			}
			
		}
		
		
		processStatus(status,jo,response);
		
	
		
	}
	private int getIntParameter(HttpServletRequest request, String parameter) {
		String strParam = request.getParameter(parameter);
		if(strParam != null && !strParam.isEmpty()){
			return Integer.valueOf(strParam);
		}else {
			return 0;
		}
		
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
			editBean.setTel( request.getParameter("tel"));
			editBean.setTelalt( request.getParameter("telalt"));
			editBean.setFax(		request.getParameter("fax"));
			editBean.setFaxalt(	request.getParameter("faxalt"));
			editBean.setNumfiscal(request.getParameter("numfiscal"));
			editBean.setAddrfiscal(request.getParameter("addrfiscal"));
			editBean.setEmail(	request.getParameter("email"));
			editBean.setRating( 	Integer.valueOf(request.getParameter("rating")) );
			editBean.setAddrship(	request.getParameter("addrship"));
			CountryMain countryMain = new  CountryMain(); 
			CountryBean cbBean = countryMain.getItem(getIntParameter(request,COUNTRY_FIELD ));
			editBean.setCountry( 	cbBean);
			ClientTypeMain ctMain = new ClientTypeMain();
			ClientTypeBean ctBean = ctMain.getItem(getIntParameter(request, CLIENT_TYPE_FIELD ));
			editBean.setTipo_cliente(ctBean);
			SellerMain sellerMain = new SellerMain();
			SellerBean sellerBean = sellerMain.getItem(getIntParameter(request, SELLER_FIELD));
			editBean.setSeller(sellerBean);
			return beanMain.modItem(editBean);
			
			
		}else {
			return false;
			
		}
			
		
		
	}


	
	
}
				
				
				

