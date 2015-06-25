package com.urbau.servlet;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

@WebServlet("/RenderImage")
public class RenderImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RenderImage() {
        super();
    }

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String imagePath = request.getParameter("imagePath");
		
		System.out.println("Render Image imagePath:: "+ imagePath);		
		
		if(null != imagePath && !imagePath.isEmpty()){
			
			byte[] bytesData = null;
			try{
				FileInputStream is = new FileInputStream(imagePath);
				bytesData = IOUtils.toByteArray(is);
				
			}catch(FileNotFoundException e){
				
				System.out.println("Error in File Inpur Stream for a image :: "+ e);
				FileInputStream is = new FileInputStream(request.getSession().getServletContext().getRealPath("/assets/img/placeholder_default.png"));
				bytesData = IOUtils.toByteArray(is);
			}
			
			if(null != bytesData){
				ServletOutputStream sos = response.getOutputStream();
				sos.write(bytesData);
				sos.flush();
				sos.close();
			}
						
		}			
	}

}
