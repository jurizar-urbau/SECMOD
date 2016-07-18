package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.misc.EncryptUtils;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;


@WebServlet("/bin/ExtendedFields")
public class ExtendedFieldsAsTransaction extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
												
			HttpSession session = request.getSession();			
			validateRequest( session );
			
			String modeParameter = request.getParameter( MODE_PARAMETER );
			String idParameter = request.getParameter( ID_PARAMETER );
			String tableName = EncryptUtils.base64decode( request.getParameter( "tablename" ) );
			String[] field_names  = request.getParameterValues( "field_names" );
			String[] data_types_str = request.getParameterValues( "data_types" );
			int[] data_types = new int[ data_types_str.length ];
			for( int n = 0; n < field_names.length; n ++ ){
				System.out.println("enc:fieldname: [ " + field_names[ n ] + "]" );
				field_names[ n ] = EncryptUtils.base64decode( field_names[ n ] );
				System.out.println("dec:fieldname: [ " + field_names[ n ] + "]" );
			}
			for( int n = 0; n < data_types_str.length; n ++ ){
				System.out.println("enc:data_types: [ " + data_types[ n ] + "]" );
				data_types[ n ] = Integer.valueOf( EncryptUtils.base64decode( data_types_str[ n ] ));
				System.out.println("dec:data_types: [ " + data_types[ n ] + "]" );
			}
			
			
			String message = "";					
										
			if( idParameter != null){
				ExtendedFieldsBean bean = new ExtendedFieldsBean();
				for( String parameter : field_names ){
					System.out.println( "putting: " + parameter + "=" + request.getParameter( parameter ));
					bean.putValue( parameter, request.getParameter(  parameter )	);
				}
					
				if( !ADD.equals( modeParameter ) ){
					bean.setId( Integer.parseInt( idParameter));
				}															
				
				ExtendedFieldsBaseMain main = new ExtendedFieldsBaseMain( tableName, field_names, data_types );
				
				if( ADD.equals( modeParameter )){
					
					String transid = main.addForTransaction( bean );
					if ( !"NULL".equals( transid ) ){
							int idtransaction = main.getIdFromTransaction(transid);
							message = idtransaction + "|Registro creado con exito.";
					} else {
						showMessage( "No se pudo crear el registro" , response );
					}
				}else if( EDIT.equals( modeParameter )){
					if ( main.mod(bean)){
						message = bean.getId() + "|Registro modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el Registro", response  );
					}
				} else if( REMOVE.equals( modeParameter )){
					if ( main.del(bean)){
						message = bean.getId() + "|Registro eliminado con exito.";						
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
				
							