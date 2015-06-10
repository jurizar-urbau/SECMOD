package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.PaisBean;
import com.urbau.beans.ProveedorBean;
import com.urbau.feeders.ProveedoresMain;
import com.urbau.feeders.PaisesMain;

@WebServlet("/Proveedores")
public class Proveedores extends Entity {
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
				ProveedorBean bean = new ProveedorBean();
					
					bean.setNit( request.getParameter("nit") );
					bean.setCodigo( request.getParameter("codigo") );
					bean.setNombre( request.getParameter("nombre") );
					bean.setRazonSocial( request.getParameter( "razonsocial" ));
					bean.setContacto( request.getParameter("contacto") );
					bean.setDireccion( request.getParameter( "direccion" ));
					bean.setTelefono( request.getParameter( "telefono" ));
					bean.setEmail( request.getParameter( "correo" ));
					
					String pais =request.getParameter( "pais" );					
					String limiteCredito =request.getParameter( "limitecredito" );
					String saldo =request.getParameter( "saldo" );
					
					
					if(pais != null){
						int paisId =  Integer.parseInt(pais);												
						bean.setPais( paisId);
						
						PaisesMain paises_main = new PaisesMain();
						PaisBean paisBean = paises_main.get(paisId);																		
						bean.setMoneda( Integer.parseInt(paisBean.getMoneda()));
						
					}
					
					if(limiteCredito != null){
						bean.setLimiteCredito( Double.parseDouble(limiteCredito));	
					}
					if(saldo != null){
						bean.setSaldo( Double.parseDouble(saldo));	
					}																	
												
					if( !"add".equals( request.getParameter( "mode" ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					
					ProveedoresMain main = new ProveedoresMain();
					
					if( "add".equals( mode )){
						if ( main.add( bean ) ){
							message = "Usuario creado con exito.";
						} else {
							showMessage( "No se pudo crear el usuario" , response );
						}
					} else if( "edit".equals( mode )){
						if ( main.mod( bean ) ){
							message = "Usuario modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el usuario", response  );
						}
					} else if( "remove".equals( mode )){
						if ( main.del( bean ) ){
							message = "Usuario eliminado con exito.";
						} else {
							showMessage( "No se pudo eliminar el usuario" , response );
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
				
				
				

