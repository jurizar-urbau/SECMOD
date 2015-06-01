package com.urbau.servlet;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau.db.ConnectionManager;
import com.urbau.db.ORMConnectionManager;

/**
 * Servlet implementation class VidrioMarketConfig
 */
@WebServlet(
		urlPatterns = { "/UrbauConfig" }, 
		initParams = { 
				@WebInitParam(name = "dburl", value = "theurl"), 
				@WebInitParam(name = "dbuser", value = "theuser"), 
				@WebInitParam(name = "dbpassword", value = "thepassword"), 
				@WebInitParam(name = "dbhost", value = "thehost"), 
				@WebInitParam(name = "license", value = "thelicense")
		})
public class UrbauConfig extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UrbauConfig() {
        super();
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		System.out.println( "initializing Data Base Manager.");
		String driver = config.getInitParameter( "dbdriver" );
		String url    = config.getInitParameter( "dburl" );
		String user   = config.getInitParameter( "dbuser" );
		String password   = config.getInitParameter( "dbpassword" );
		ConnectionManager.set(driver, url, user, password);
		ORMConnectionManager.set(driver, url, user, password);
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getOutputStream().write( "configuration...".getBytes() );
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}

}
