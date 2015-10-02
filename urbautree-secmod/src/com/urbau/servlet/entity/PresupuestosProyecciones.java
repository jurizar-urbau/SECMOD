package com.urbau.servlet.entity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.PresupuestoProyeccionBean;
import com.urbau.feeders.PresupuestosProyeccionesMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.ANIO_PARAMETER;
import static com.urbau.misc.Constants.MES_PARAMETER;


@WebServlet("/PresupuestosProyecciones")
public class PresupuestosProyecciones extends Entity {
	private static final long serialVersionUID = 1L;
       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
						
			HttpSession session = request.getSession();
			validateRequest( session );
			
			String modeParameter = request.getParameter( MODE_PARAMETER );
			String idParameter = request.getParameter( ID_PARAMETER );
			String anio = request.getParameter(ANIO_PARAMETER);
			String mes = request.getParameter(MES_PARAMETER);
			String rubroParameter = request.getParameter("rubro");
			String montoParameter = request.getParameter("monto");
			
			String message = "";					
			
			System.out.println("Id: " + idParameter);
			System.out.println("anio" + anio);
			System.out.println("mes: " + mes);
			System.out.println("rubro: " + rubroParameter);
			System.out.println("montoParameter: " + montoParameter);
										
			
			
			PresupuestoProyeccionBean bean = new PresupuestoProyeccionBean();
							
			if(null != idParameter){
				bean.setId( Integer.parseInt( idParameter));	
			}
			
			if(null != anio){
				bean.setAnio(Integer.parseInt(anio));	
			}
			if(null != mes){
				bean.setMes(Integer.parseInt(mes));	
			}
			if(null != rubroParameter){
				bean.setTipoRublo(Integer.parseInt(rubroParameter));	
			}
			if(null != montoParameter){
				bean.setMonto(Double.parseDouble(montoParameter));	
			}
																								
			
			if(null != anio && null !=  mes){
																
				PresupuestosProyeccionesMain main = new PresupuestosProyeccionesMain();
				
				if( ADD.equals( modeParameter )){					
					
					if ( main.add( bean ) ){
						message = "Registro creado con exito.";
					} else {
						showMessage( "No se pudo crear el registro" , response );
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
				
							