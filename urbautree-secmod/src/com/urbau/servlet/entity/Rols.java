package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.RolBean;
import com.urbau.feeders.RolesMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.ROL_NAME_PARAMETER;


@WebServlet("/Rols")
public class Rols extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
						
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String modeParameter = request.getParameter( MODE_PARAMETER );
			String idParameter = request.getParameter( ID_PARAMETER );
			String message = "";					
										
			if( idParameter != null){
				RolBean rolBean = new RolBean();
								
				String rolName = request.getParameter(ROL_NAME_PARAMETER);
				rolBean.setDescription(rolName);													
					
				if( !ADD.equals( modeParameter ) ){
					rolBean.setId( Integer.parseInt( idParameter));
				}											
				
				RolesMain rolesMain = new RolesMain();
				
				if( ADD.equals( modeParameter )){					
					if(rolesMain.duplicate(rolBean)){
						message = "Registro ya existe!";
					}else{
						if ( rolesMain.add( rolBean ) ){
							message = "Registro creado con exito.";
						} else {
							showMessage( "No se pudo crear el registro" , response );
						}
					}														
				}else if( EDIT.equals( modeParameter )){
					if ( rolesMain.mod(rolBean)){
						message = "Registro modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el Registro", response  );
					}
				} else if( REMOVE.equals( modeParameter )){
					if ( rolesMain.del(rolBean)){
						message = "Registro eliminado con exito.";					
					} else {
						showMessage( "No se pudo eliminar el Registro" , response );
					}
				}
											
				
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
				
			}
			
		} catch( Exception exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();						
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();			
		}
	}
	
}
				
							