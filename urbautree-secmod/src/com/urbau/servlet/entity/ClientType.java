package com.urbau.servlet.entity;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ClientTypeBean;
import com.urbau.feeders.ClientTypeMain;


@WebServlet("/clientType")
public class ClientType extends Entity {
	private static final long serialVersionUID = 1L;
	private static final String ADD_MODE = "add";
	private static final String ITEM = "Tipo de Cliente";
	private static final String MESSAGE_ADD_SUCCESS = ITEM+" creado con exito.";
	private static final String MESSAGE_MOD_SUCCESS = ITEM+" modificado con exito.";
	private static final String MESSAGE_DEL_SUCESS =  ITEM + "eliminado con exito.";
	private static final String MESSAGE_ADD_ERROR = "No se pudo crear el"+ITEM ;
	private static final String MESSAGE_MOD_ERROR = "No se pudo modificar el "+ITEM;
	private static final String MESSAGE_DEL_ERROR = "No se pudo eliminar el "+ITEM;
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			String mode = request.getParameter( "mode" );
			System.out.println( "mode: " + mode );
			System.out.println( "id: " + request.getParameter( "id") );
			
			String message = "";
			if( request.getParameter( "id" ) != null || ADD_MODE.equals( request.getParameter( "mode" ))  ){
					ClientTypeBean rm = new ClientTypeBean();
					rm.setType( request.getParameter("type") );
					if( !ADD_MODE.equals( request.getParameter( "mode" ) ) ){
						rm.setId( Integer.parseInt( request.getParameter( "id" )));
					}
					ClientTypeMain rmain = new ClientTypeMain();
					
					if( ADD_MODE.equals( mode )){
						if ( rmain.addItem(rm) ){
							message = MESSAGE_ADD_SUCCESS;
						} else {
							showMessage( MESSAGE_ADD_ERROR, response );
						}
					} else if( "edit".equals( mode )){
						if ( rmain.modItem(rm) ){
							message = MESSAGE_MOD_SUCCESS;
						} else {	
							showMessage( MESSAGE_MOD_ERROR, response  );
						}
					} else if( "remove".equals( mode )){
						if ( rmain.delItem( rm ) ){
							message = MESSAGE_DEL_SUCESS;
						} else {
							showMessage( MESSAGE_DEL_ERROR, response );
						}
					}
					System.out.println(message);
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
				
				
				

