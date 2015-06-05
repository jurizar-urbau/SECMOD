package com.urbau.servlet.entity;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.MonedaBean;
import com.urbau.feeders.MonedasMain;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/MonedasList")
public class MonedasList extends Entity {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		JSONArray jsonArray = new JSONArray();
		
		MonedasMain main = new MonedasMain();		
		ArrayList<MonedaBean>  list = main.get(null, 0);
		
		for(MonedaBean bean: list ){
			
			JSONObject jsonObject = new JSONObject();				
			jsonObject.put("id", bean.getId());
			jsonObject.put("name", bean.getNombre());
			jsonObject.put("symbol", bean.getSimbolo());															
			jsonArray.add(jsonObject);			
		}
						
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}
				