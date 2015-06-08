package com.urbau.servlet.entity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.VehicleBean;
import com.urbau.feeders.VehicleMain;


@WebServlet("/vehicles")
public class Vehicles extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String ADD_MODE = "add";
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		try{
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
//			validateRequest( session );
			String mode = request.getParameter( "mode" );
			System.out.println( "mode: " + mode );
			System.out.println( "id: " + request.getParameter( "id") );
			
			String message = "";
			if( request.getParameter( "id" ) != null || ADD_MODE.equals( request.getParameter( "mode" ))  ){
					VehicleBean rm = new VehicleBean();
					rm.setMarca( request.getParameter("marca") );
					rm.setModelo( request.getParameter("modelo") );
					rm.setNoPlaca( request.getParameter("noPlaca") );
					rm.setNoChasis( request.getParameter( "noChasis" ));
					rm.setEstado( request.getParameter("estado")  );
					rm.setLicPirotecnia( request.getParameter( "licPirotecnia" ));
					rm.setLicVencimiento(request.getParameter("licVencimiento"));
					if( !ADD_MODE.equals( request.getParameter( "mode" ) ) ){
						rm.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					VehicleMain rmain = new VehicleMain();
					message = "listado ";
					if( ADD_MODE.equals( mode )){
						if ( rmain.addVehicle(rm) ){
							message = "Vehiculo creado con exito.";
						} else {
							showMessage( "No se pudo crear el Vehiculo" , response );
						}
					} else if( "edit".equals( mode )){
						if ( rmain.modVehicle(rm) ){
							message = "Usuario modificado con exito.";
						} else {
							showMessage( "No se pudo modificar el usuario", response  );
						}
					} else if( "remove".equals( mode )){
						if ( rmain.delVehicle( rm ) ){
							message = "Vehiculo eliminado con exito.";
						} else {
							showMessage( "No se pudo eliminar el vehiculo" , response );
						}
					} else if("list".equals( mode )) {
						message = "listado ";
					}
					response.getOutputStream().write( message.getBytes() );
					response.getOutputStream().flush();
					response.getOutputStream().close();
				}
			
//		} catch( UserNotAuthenticatedException exception ){
//			System.out.println( "Error: " + exception.getMessage() );
//			exception.printStackTrace();
//			response.getOutputStream().write( exception.getMessage().getBytes() );
//			response.getOutputStream().flush();
//			response.getOutputStream().close();
//		}
	}
	
}
				
				
				

