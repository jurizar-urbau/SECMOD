package com.urbau.servlet.entity;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import com.urbau.threads.PlanillaGenerator;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/bin/generateplanilla")
public class GeneratePlanilla extends Entity {
	private static final long serialVersionUID = 1L;
       
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String periodo = request.getParameter( "PERIODO" );
		String mes = request.getParameter( "MES" );
		String anio = request.getParameter( "ANIO" );
		String id_planilla = request.getParameter( "ID_PLANILLA" );
		
		JSONArray jsonArray = new JSONArray();
		
		System.out.println(  "periodo: " + periodo + ", mes: " + mes + ", anio:" + anio );
		
		if(null != periodo && null != mes && null != anio && null != id_planilla ){		
			
			PlanillaGenerator pg = new PlanillaGenerator();
			pg.setIdPlanilla( Integer.parseInt( id_planilla ));
			pg.setPeriod( Integer.valueOf( periodo), Integer.valueOf( mes), Integer.parseInt( anio ));
			boolean generated = pg.processGeneration();
			JSONObject jsonObject = new JSONObject();				
			jsonObject.put("generated", "" + generated );
			jsonArray.add(jsonObject);
		} else {
			JSONObject jsonObject = new JSONObject();				
			jsonObject.put("generated", "false" );
			jsonObject.put("message", "No se pudo generar la planilla, parametros incompletos" );
			jsonArray.add(jsonObject);
		}
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}