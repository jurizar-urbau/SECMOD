package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ClasificacionRubroBean;
import com.urbau.feeders.ClasificacionRubrosMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.NAME_PARAMETER;;


@WebServlet("/ClasificacionRubros")
public class ClasificacionRubros extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
												
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String modeParameter = request.getParameter( MODE_PARAMETER );
			String idParameter = request.getParameter( ID_PARAMETER );
			String message = "";					
										
			if( idParameter != null){
				ClasificacionRubroBean bean = new ClasificacionRubroBean();
								
				String descripcion = request.getParameter(NAME_PARAMETER);
				bean.setDescription(descripcion);													
					
				if( !ADD.equals( modeParameter ) ){
					bean.setId( Integer.parseInt( idParameter));
				}															
				
				ClasificacionRubrosMain main = new ClasificacionRubrosMain();
				
				if( ADD.equals( modeParameter )){
					
					if(main.duplicate(bean)){
						message = "Registro ya existe!";
					}else{
						if ( main.add( bean ) ){
							message = "Registro creado con exito.";
						} else {
							showMessage( "No se pudo crear el registro" , response );
						}
					}
										
				}else if( EDIT.equals( modeParameter )){
					if ( main.mod(bean)){
						message = "Registro modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el Registro", response  );
					}
				} else if( REMOVE.equals( modeParameter )){
					if ( main.del(bean)){
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
				
							