package com.urbau.servlet.entity;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.OptionsByProgramBean;
import com.urbau.feeders.OptionsByProgramMain;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/OptionsByProgramsList")
public class OptionsByProgramsList extends Entity {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String rolId = request.getParameter("idRol");	
		JSONArray jsonArray = new JSONArray();
		
		if(null != rolId){
			OptionsByProgramMain opbypro_main = new OptionsByProgramMain();
			ArrayList<OptionsByProgramBean>  opbypro_list = opbypro_main.get(rolId);
			
			for(OptionsByProgramBean opbypro_bean: opbypro_list ){
				
				JSONObject jsonObject = new JSONObject();				
				jsonObject.put("id", opbypro_bean.getId());
				jsonObject.put("idOption", opbypro_bean.getId_option());
				jsonObject.put("optionDescription", opbypro_bean.getOption_description());				
				jsonObject.put("idProgram", opbypro_bean.getId_program());
				jsonObject.put("programDescription", opbypro_bean.getProgram_description());
				jsonObject.put("idRol", opbypro_bean.getId_rol());
				
				jsonArray.add(jsonObject);			
			}
		}
		
				
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}
				