package com.urbau.servlet.entity;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ClienteBean;
import com.urbau.beans.PrecioBean;
import com.urbau.beans.ProductoBean;
import com.urbau.feeders.ClientesMain;
import com.urbau.feeders.PreciosMain;
import com.urbau.feeders.ProductosMain;
import com.urbau.misc.Util;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;

@WebServlet("/ProductsFiltered")
public class ProductsFiltered extends Entity {
	
	private static final long serialVersionUID = 1L;
	
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
    	response.setContentType("application/json");
    	
    	String clientid = request.getParameter( "client_id");
    	ClienteBean cliente = null;
    	PreciosMain precios = new PreciosMain();
    	if( !Util.isEmpty( clientid ) ) {
    		ClientesMain cm = new ClientesMain();
    		cliente = cm.get(Integer.valueOf( clientid ));
    	}
    	String q = request.getParameter( "q" );
    	
		JSONArray jsonArray = new JSONArray();
		
			ProductosMain pm = new ProductosMain();
			
			ArrayList<ProductoBean> productos = pm.get(q, -1 );
			
			for( ProductoBean producto : productos ){
				JSONObject jsonObject = new JSONObject();				
				jsonObject.put("id", producto.getId() );
				jsonObject.put( "codigo", producto.getCodigo() );
				jsonObject.put( "descripcion", producto.getDescripcion() );
				jsonObject.put( "image_path", producto.getImage_path() );
				jsonObject.put( "precio", producto.getPrecio() );
				fillPrices(jsonObject, producto, cliente);
//				jsonObject.put( "precio_1", pb.getPrecio_1() );
//				jsonObject.put( "precio_2", pb.getPrecio_2() );
//				jsonObject.put( "precio_3", pb.getPrecio_3() );
//				jsonObject.put( "precio_4", pb.getPrecio_4() );
				jsonArray.add(jsonObject);
			}
		PrintWriter out = response.getWriter();
		out.print(jsonArray);			
			
	}
    private void fillPrices(JSONObject jsonObject, ProductoBean producto, ClienteBean cliente){
    	double precio_1 = producto.getPrecio_1();
    	double precio_2 = producto.getPrecio_2();
    	double precio_3 = producto.getPrecio_3();
    	double precio_4 = producto.getPrecio_4();
    	PreciosMain pm = new PreciosMain();
    	PrecioBean precio_1_list = pm.get( 1 );
    	PrecioBean precio_2_list = pm.get( 2 );
    	PrecioBean precio_3_list = pm.get( 3 );
    	PrecioBean precio_4_list = pm.get( 4 );
    
    	
    	if( cliente == null ){
    		if( producto.getPrecio_1() <= 0 ){
    			jsonObject.put( "precio_1", String.valueOf( producto.getPrecio() / precio_1_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_1", String.valueOf( precio_1 ));
    		}
    		if( producto.getPrecio_2() <= 0 ){
    			jsonObject.put( "precio_2", String.valueOf( producto.getPrecio() / precio_2_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_2", String.valueOf( precio_2 ));
    		}
    		if( producto.getPrecio_3() <= 0 ){
    			jsonObject.put( "precio_3", String.valueOf( producto.getPrecio() / precio_3_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_3", String.valueOf( precio_3 ));
    		}
    		if( producto.getPrecio_4() <= 0 ){
    			jsonObject.put( "precio_4", String.valueOf( producto.getPrecio() / precio_4_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_4", String.valueOf( precio_4 ));
    		}
    	} else {
    		if( producto.getPrecio_1() <= 0 ){
    			jsonObject.put( "precio_1", String.valueOf( producto.getPrecio() / precio_1_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_1", String.valueOf( precio_1 ));
    		}
    		if( producto.getPrecio_2() <= 0 ){
    			jsonObject.put( "precio_2", String.valueOf( producto.getPrecio() / precio_2_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_2", String.valueOf( precio_2 ));
    		}
    		if( producto.getPrecio_3() <= 0 ){
    			jsonObject.put( "precio_3", String.valueOf( producto.getPrecio() / precio_3_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_3", String.valueOf( precio_3 ));
    		}
    		if( producto.getPrecio_4() <= 0 ){
    			jsonObject.put( "precio_4", String.valueOf( producto.getPrecio() / precio_4_list.getCoeficiente() ) );
    		} else {
    			jsonObject.put( "precio_4", String.valueOf( precio_4 ));
    		}
    	}
    		
    }
    public double roundPrice( double price ){
    	Double doublep = price;
    	if( doublep.floatValue() <= 25 ){
    		doublep = doublep.intValue() + .25;
    	} else if( doublep.floatValue() <= 50 ){
    		doublep = doublep.intValue() + .50;
    	} else if( doublep.floatValue() <= 75 ){
    		doublep = doublep.intValue() + .75;
    	} else if( doublep.floatValue() < 100 ){
    		doublep = doublep.intValue() + 1.0;
    	}
    	return doublep;
    }
}
				