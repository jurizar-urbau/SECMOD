package com.urbau.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.misc.Constants;
import com.urbau.misc.ExtendedFieldsFilter;


/**
 * Servlet implementation class 
 */
@WebServlet(  
		urlPatterns = { "/bin/CheckCupon" } 
		)

@SuppressWarnings("unchecked")
public class CheckCupon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckCupon() {
        super();
    }

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		
		String id_cliente = request.getParameter( "idcliente" );
		
		ExtendedFieldsBaseMain main = new ExtendedFieldsBaseMain( "CUPONES_DE_DESCUENTO", 
				new String[]{"MONTO","DESCRIPCION","ID_USUARIO","FECHA_CREACION","ESTADO","ID_CLIENTE","ID_ORDEN"},
					new int[]{ 
					Constants.EXTENDED_TYPE_DOUBLE, 
					Constants.EXTENDED_TYPE_STRING,
					Constants.EXTENDED_TYPE_INTEGER,
					Constants.EXTENDED_TYPE_DATE,
					Constants.EXTENDED_TYPE_STRING,
					Constants.EXTENDED_TYPE_INTEGER,
					Constants.EXTENDED_TYPE_INTEGER
				} );
		
		ExtendedFieldsFilter filter = new ExtendedFieldsFilter( 
											new String[]{ "ID_CLIENTE" }, 
											new int[]   { ExtendedFieldsFilter.EQUALS }, 
											new int[]   { Constants.EXTENDED_TYPE_INTEGER }, 
											new String[]{ id_cliente } 
									);
		
		ArrayList<ExtendedFieldsBean> beans = main.getAll( filter );
		
		JSONArray jsonArray = new JSONArray();
		System.out.println( "looping cupons" );
		for( ExtendedFieldsBean bean : beans ){
			System.out.println("ID:" + bean.getId() );
			if( bean.getId() != -1 ){
				JSONObject jsonObject = new JSONObject();
				jsonObject.put( "status", "ok");
				jsonObject.put( "id",  bean.getId());
				jsonObject.put( "monto",  bean.getValue( "MONTO" ));
				jsonObject.put( "descripcion",  bean.getValue( "DESCRIPCION" ));
				jsonArray.add( jsonObject );
			}  
		}
		PrintWriter out = response.getWriter();
		out.print(jsonArray);
	}

}
