package com.urbau.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.urbau.misc.Util;



@WebServlet( 
		urlPatterns = { "/bin/CheckClientPrice" } 
		)

public class CheckClientPrice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckClientPrice() {
        super();
    }

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		String client = request.getParameter( "client" );
		String price  = request.getParameter( "price" );
		String store  = request.getParameter( "store" );
		
		
		int cliente = -1;
		try{
			cliente = Integer.valueOf( client );
		} catch ( NumberFormatException  e ){
			
		}
		int precio  = -1;
		try{
			precio = Integer.valueOf( price );
		} catch ( NumberFormatException e ){
			
		}
	
		int punto  = -1;
		try{
			punto = Integer.valueOf( store );
		} catch ( NumberFormatException e ){
			
		}
		boolean allowed = Util.isAllowedPrice(precio, punto, cliente ) ;
		System.out.println("allowed: " + allowed);
		if(	allowed  ){  
			response.getOutputStream().write( "true".getBytes() );
		}  else {
			response.getOutputStream().write( "false".getBytes() );
		}
			response.getOutputStream().flush();
			response.getOutputStream().close();
		
	}

}
