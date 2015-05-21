package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.OptionBean;
import com.urbau.feeders.OptionsMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.OPTION_NAME_PARAMETER;


@WebServlet("/Options")
public class Options extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
						
			System.out.println( ">>>>>>>>>>>>>> Options >>>>>>>>>>>>>>>>>>: " );						
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String modeParameter = request.getParameter( MODE_PARAMETER );
			String idParameter = request.getParameter( ID_PARAMETER );
			String message = "";
			
			System.out.println( "mode: " + modeParameter );
			System.out.println( "\tid: " + idParameter );
										
			if( idParameter != null){
				OptionBean optionBean = new OptionBean();
								
				String optionName = request.getParameter(OPTION_NAME_PARAMETER);
				optionBean.setDescription(optionName);													
					
				if( !ADD.equals( modeParameter ) ){
					optionBean.setId( Integer.parseInt( idParameter));
				}
								
				
				System.out.println( "\toptionName: " + optionName );
				
				OptionsMain optionsMain = new OptionsMain();
				
				if( ADD.equals( modeParameter )){
					if ( optionsMain.addOption(optionBean)){
						message = "Opcion creado con exito.";
					} else {
						showMessage( "No se pudo crear la Opcion" , response );
					}
				}else if( EDIT.equals( modeParameter )){
					if ( optionsMain.modOption(optionBean)){
						message = "Opcion modificado con exito.";
					} else {
						showMessage( "No se pudo modificar la Opcion", response  );
					}
				} else if( REMOVE.equals( modeParameter )){
					if ( optionsMain.delOption(optionBean)){
						message = "Opcion eliminado con exito.";
						System.out.println("message>> " + message);
					} else {
						showMessage( "No se pudo eliminar la Opcion" , response );
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
				
							