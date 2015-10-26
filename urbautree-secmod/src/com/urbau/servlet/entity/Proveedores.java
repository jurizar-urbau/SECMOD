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

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.NIT_PARAMETER;
import static com.urbau.misc.Constants.CODIGO_PARAMETER;
import static com.urbau.misc.Constants.NOMBRE_PARAMETER;
import static com.urbau.misc.Constants.RAZON_SOCIAL_PARAMETER;
import static com.urbau.misc.Constants.CONTACTO_PARAMETER;
import static com.urbau.misc.Constants.DIRECCION_PARAMETER;
import static com.urbau.misc.Constants.TELEFONO_PARAMETER;
import static com.urbau.misc.Constants.CORREO_PARAMETER;
import static com.urbau.misc.Constants.PAIS_PARAMETER;
import static com.urbau.misc.Constants.LIMITE_CREDITO_PARAMETER;
import static com.urbau.misc.Constants.SALDO_PARAMETER;

@WebServlet("/Proveedores")
public class Proveedores extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{					
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String mode = request.getParameter( MODE_PARAMETER );						
			String message = "";
			if( request.getParameter( ID_PARAMETER ) != null || ADD.equals( request.getParameter( MODE_PARAMETER ))  ){
				ProveedorBean bean = new ProveedorBean();
					
					bean.setNit( request.getParameter( NIT_PARAMETER) );
					bean.setCodigo( request.getParameter( CODIGO_PARAMETER ) );
					bean.setNombre( request.getParameter( NOMBRE_PARAMETER) );
					bean.setRazonSocial( request.getParameter( RAZON_SOCIAL_PARAMETER ));
					bean.setContacto( request.getParameter( CONTACTO_PARAMETER ) );
					bean.setDireccion( request.getParameter( DIRECCION_PARAMETER ));
					bean.setTelefono( request.getParameter( TELEFONO_PARAMETER ));
					bean.setEmail( request.getParameter( CORREO_PARAMETER ));
					
					String pais =request.getParameter( PAIS_PARAMETER );					
					String limiteCredito =request.getParameter( LIMITE_CREDITO_PARAMETER );
					String saldo =request.getParameter( SALDO_PARAMETER );
					
					
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
												
					if( !ADD.equals( request.getParameter( MODE_PARAMETER ) ) ){
						bean.setId( Integer.parseInt( request.getParameter( ID_PARAMETER )));
					}
					
					ProveedoresMain main = new ProveedoresMain();
					
					if( ADD.equals( mode )){
						if ( main.add( bean ) ){
							message = "Usuario creado con exito.";
						} else {
							showMessage( "No se pudo crear el usuario" , response );
						}
					} else if( EDIT.equals( mode )){
						if ( main.mod( bean ) ){
							message = "Usuario modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el usuario", response  );
						}
					} else if( REMOVE.equals( mode )){
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
				
				
				

