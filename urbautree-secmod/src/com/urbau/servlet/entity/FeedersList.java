package com.urbau.servlet.entity;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

import static com.urbau.misc.Constants.PACKAGE_NAME_PARAMETER;

@WebServlet("/FeedersList")
public class FeedersList extends Entity {
	
	private static final long serialVersionUID = 1L;
	
	private final char DOT = '.';
    private final char SLASH = '/';
    private final String CLASS_SUFFIX = ".class";
    private final String BAD_PACKAGE_ERROR = "Unable to get resources from path '%s'. Are you sure the package '%s' exists?";
       
    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
		String packageName = request.getParameter(PACKAGE_NAME_PARAMETER);	
		JSONArray jsonArray = new JSONArray();
		
		if(null != packageName){
			
			String scannedPath = packageName.replace(DOT, SLASH);
			URL scannedUrl = Thread.currentThread().getContextClassLoader().getResource(scannedPath);
			
			if (scannedUrl == null) {
	            throw new IllegalArgumentException(String.format(BAD_PACKAGE_ERROR, scannedPath, "com.urbau.feeders"));
	        }
			
			File scannedDir = new File(scannedUrl.getFile());			
	        final String[] files = scannedDir.list();
	        for (final String file : files) {
	        	
	        	 if (file.endsWith(CLASS_SUFFIX)) {	        		 
	        		 String name = packageName + '.'+ file.substring(0, file.length() - 6);
	        		 
	        		 JSONObject jsonObject = new JSONObject();				
	 				 jsonObject.put("name", name);	 				 	 				
	 				 jsonArray.add(jsonObject);
	        	 }	        	
	        }
						
		}
        
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
	
}
				