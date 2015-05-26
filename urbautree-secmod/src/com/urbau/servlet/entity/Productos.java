package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ProductoBean;
import com.urbau.feeders.ProductosMain;

@WebServlet("/Productos")
public class Productos extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( "mode" );
			System.out.println( "mode: " + mode );
			
			
			String message = "";
			if( request.getParameter( "id" ) != null || "add".equals( request.getParameter( "mode" ))  ){
					ProductoBean rm = new ProductoBean();
					
					rm.setCodigo( request.getParameter("codigo") );
					rm.setDescripcion( request.getParameter("descripcion") );
					rm.setCoeficiente_unidad( Integer.valueOf( request.getParameter( "coeficiente_unidad" ) ));
					rm.setProveedor(Integer.valueOf( request.getParameter( "proveedor" ) ));
					rm.setPrecio( Double.valueOf( request.getParameter( "precio" )  ));
					rm.setPrecio_importacion( Double.valueOf( request.getParameter( "precio_importacion" )  ));
					rm.setImage_path( request.getParameter("image_path")  );
					
												
					if( !"add".equals( request.getParameter( "mode" ) ) ){
						rm.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					ProductosMain rmain = new ProductosMain();
					
					if( "add".equals( mode )){
						if ( rmain.addProducto( rm ) ){
							message = "Producto creado con exito.";
						} else {
							showMessage( "No se pudo crear el producto" , response );
						}
					} else if( "edit".equals( mode )){
						if ( rmain.modProducto( rm ) ){
							message = "Producto modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el producto", response  );
						}
					} else if( "remove".equals( mode )){
						if ( rmain.delProducto( rm ) ){
							message = "Producto eliminado con exito.";
						} else {
							showMessage( "No se pudo eliminar el producto" , response );
						}
					}
					response.getOutputStream().write( message.getBytes() );
					response.getOutputStream().flush();
					response.getOutputStream().close();
				}
			
		} catch( UserNotAuthenticatedException exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
	
}
				
				
				

