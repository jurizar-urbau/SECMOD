package com.urbau.json.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.InvetarioBean;
import com.urbau.feeders.InventariosMain;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;


@WebServlet("/ProductosPorBodega")
public class ProductosPorBodega extends Entity {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");    	
    	
    	String idBodegaParameter = request.getParameter("bodega");
    	int idBodega  = -1;
    	try{
    		idBodega = Integer.parseInt(idBodegaParameter);	
    	}catch(NumberFormatException e){
    		System.out.println("Error to parse a string to int for bodega parameter : message : "+ e.getMessage());
    	}
    	
    	String fromParameter = request.getParameter( "from" );    	
    	int from = 0;
		if( !fromParameter.isEmpty() ){			
			from = Integer.parseInt(fromParameter );
		}	
    	
		
		JSONArray jsonArray = new JSONArray();		
		if(idBodega >= 0){
			
			InventariosMain inventario_main = new InventariosMain();
			
			ArrayList<InvetarioBean> inventario_list = inventario_main.get( request.getParameter("q"), from ,idBodega);		
			
			for(InvetarioBean bean: inventario_list ){
				
				JSONObject jsonObject = new JSONObject();	
				
				jsonObject.put("idProduct", bean.getId_product());
				jsonObject.put("status", bean.getEstatus());
				jsonObject.put("amount", bean.getAmount());
				jsonObject.put("prodCodigo", bean.getProdCodigo());
				jsonObject.put("prodDescripcion", bean.getProdDescripcion());
				jsonObject.put("prodCoeficienteUnidad", bean.getProdCoeficienteUnidad());
				jsonObject.put("prodIDProveedor", bean.getProdProveedor());
				jsonObject.put("prodPrecio", bean.getProdPrecio());
				jsonObject.put("prodPrecio1", bean.getProdPrecio1());
				jsonObject.put("prodPrecio2", bean.getProdPrecio2());
				jsonObject.put("prodPrecio3", bean.getProdPrecio3());
				jsonObject.put("prodPrecio4", bean.getProdPrecio4());
				jsonObject.put("prodImagePath", bean.getProdImagePath());
				jsonObject.put("prodStockMinimo", bean.getProdStockMinimo());
																			
				jsonArray.add(jsonObject);			
			}
		}
		
				
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}
				