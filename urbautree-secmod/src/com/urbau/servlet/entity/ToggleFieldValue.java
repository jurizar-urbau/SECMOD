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

import static com.urbau.misc.Constants.ID_PARAMETER;


@WebServlet("/bin/ToggleFieldValue")
public class ToggleFieldValue extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
												
			HttpSession session = request.getSession();			
			validateRequest( session );
			
			String id           = EncryptUtils.base64decode( request.getParameter( ID_PARAMETER ) );
			String tableName    = EncryptUtils.base64decode( request.getParameter( "tablename"  ) );
			String fieldName    = EncryptUtils.base64decode( request.getParameter( "fieldname"  ) );
			String fieldValue   = EncryptUtils.base64decode( request.getParameter( "fieldvalue" ) );
			String data_typeStr = EncryptUtils.base64decode( request.getParameter( "datatype"   ) );
			
			int data_type = Integer.valueOf( data_typeStr );
			
			String message = "";					
										
			if( id != null){
				ExtendedFieldsBean bean = new ExtendedFieldsBean();
				bean.putValue( fieldName, fieldValue );
				bean.setId( Integer.parseInt(  id ));
				
				ExtendedFieldsBaseMain main = new ExtendedFieldsBaseMain( tableName, new String[]{fieldName}, new int[]{data_type} );
				
			
				if ( main.mod(bean)){
					message = "true";
				} else {
					message = "false";
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
				
							