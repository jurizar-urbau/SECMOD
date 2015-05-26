package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ProgramBean;
import com.urbau.feeders.ProgramsMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.PROGRAM_DESCRIPTION_PARAMETER;
import static com.urbau.misc.Constants.PROGRAM_NAME_PARAMETER;



@WebServlet("/Programs")
public class Programs extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
						
			System.out.println( ">>>>>>>>>>>>>> Programs >>>>>>>>>>>>>>>>>>: " );						
			System.out.println( "message recieved: " + request.getQueryString() );
			
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String modeParameter = request.getParameter( MODE_PARAMETER );
			String idParameter = request.getParameter( ID_PARAMETER );
			String message = "";
			
			System.out.println( "mode: " + modeParameter );
			System.out.println( "\tid: " + idParameter );
										
			if( idParameter != null){
				ProgramBean programBean = new ProgramBean();
								
				String programDes = request.getParameter(PROGRAM_DESCRIPTION_PARAMETER);
				programBean.setDescription(programDes);
				
				String programName = request.getParameter(PROGRAM_NAME_PARAMETER);
				programBean.setProgram_name(programName);	
				
									
				if( !ADD.equals( modeParameter ) ){
					programBean.setId( Integer.parseInt( idParameter));
				}
								
				
				System.out.println( "\tProgramDes: " + programDes );
				
				ProgramsMain programsMain = new ProgramsMain();
				
				if( ADD.equals( modeParameter )){
					if ( programsMain.addPrograma(programBean) ){
						message = "Programa creado con exito.";
					} else {
						showMessage( "No se pudo crear el Programa" , response );
					}
				}else if( EDIT.equals( modeParameter )){
					if ( programsMain.modPrograma(programBean)){
						message = "Programa modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el Programa", response  );
					}
				} else if( REMOVE.equals( modeParameter )){
					if ( programsMain.delPrograma(programBean)){
						message = "Programa eliminado con exito.";					
					} else {
						showMessage( "No se pudo eliminar el Programa" , response );
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
				
							