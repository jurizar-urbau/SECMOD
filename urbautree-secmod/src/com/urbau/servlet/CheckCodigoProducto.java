package com.urbau.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau.feeders.ClientesMain;
import com.urbau.feeders.ProductosMain;


/**
 * Servlet implementation class VidrioMarketConfig
 */
@WebServlet( 
		urlPatterns = { "/bin/CheckNit" } 
		)

public class CheckCodigoProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckCodigoProducto() {
        super();
    }

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		String codigo = request.getParameter( "codigo" );
		String id     = request.getParameter( "id" );
		
		System.out.println( "id: " + id ); 
		System.out.println( "codigo: " + codigo );
		ProductosMain pm = new ProductosMain();
		 
		if(	pm.existeCodigo( id, codigo ) ){  
			
			response.getOutputStream().write( "false".getBytes() );
			
		}  else {
			//response.getOutputStream().write( "success".getBytes() );
			response.getOutputStream().write( "true".getBytes() );
		}
			response.getOutputStream().flush();
			response.getOutputStream().close();
		
	}

}
