package com.urbau.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.misc.RevertionsUtil;
import com.urbau.misc.Util;

/**
 * Servlet implementation class VidrioMarketConfig
 */
@WebServlet(
		urlPatterns = { "/bin/RevertLoad" } 
		)

public class RevertLoadServlet extends Entity {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			HttpSession session = request.getSession();			
			validateRequest( session );
			String correlativo = request.getParameter("correlativo");
			String bodega      = request.getParameter("bodega");
			String codigo_producto = request.getParameter("codigo_producto");
			String cantidad = request.getParameter("cantidad");
			
			RevertionsUtil revertionsUtil = new RevertionsUtil();
			    
			
			    
			String message = "{message: \"Datos incorrectos\", found: false}";
			
			if( !Util.isEmpty( correlativo ) &&  !Util.isEmpty( bodega ) && !Util.isEmpty( codigo_producto ) &&  !Util.isEmpty( cantidad ) ){
				message = revertionsUtil.revertLoad( Integer.valueOf( correlativo ), Integer.valueOf( bodega ), codigo_producto, Integer.valueOf( cantidad )); 
			}
			response.getOutputStream().write( message.getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
			
		} catch( Exception exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
		
		
	}

}
