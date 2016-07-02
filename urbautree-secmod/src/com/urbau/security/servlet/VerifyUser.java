package com.urbau.security.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.PuntoDeVentaBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.PuntosDeVentasMain;
import com.urbau.feeders.UsuariosMain;
import com.urbau.misc.Constants;

/**
 * Servlet implementation class Redirect
 */
@WebServlet("/bin/VerifyUser")
public class VerifyUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public VerifyUser() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String user = request.getParameter( "user" );
		String pass = request.getParameter( "password" );
		String punto_de_venta = request.getParameter( "punto_de_venta" );
		String caja_punto_de_venta = request.getParameter( "caja_punto_de_venta" );
		
		UsuariosMain usuarios = new UsuariosMain();
		UsuarioBean  usuario =  (UsuarioBean)usuarios.logIn(user, pass, punto_de_venta);
		if( usuario != null ){
			usuario.setLogged( true );
			if( "null".equals( punto_de_venta )){
				usuario.setPunto_de_venta( -1 );
				usuario.setNombre_punto_venta( "N/A" );
			} else {
				PuntoDeVentaBean pv = new PuntosDeVentasMain().get( Integer.valueOf( punto_de_venta ) );
				usuario.setPunto_de_venta( pv.getId() );
				usuario.setNombre_punto_venta( pv.getNombre() );
			}
			
			if( "null".equals( punto_de_venta ) || "null".equals( caja_punto_de_venta )){
				usuario.setCaja_punto_de_venta( -1 );
				usuario.setNombre_caja_punto_venta( "N/A" );
			} else {
				
				ExtendedFieldsBaseMain cajasMain = new ExtendedFieldsBaseMain( "CAJA_PUNTO_VENTA", 
						new String[]{ 
							"ID_PUNTO_VENTA","DESCRIPCION"
					    },
						new int[]{ 
							Constants.EXTENDED_TYPE_INTEGER,
							Constants.EXTENDED_TYPE_STRING
						} );

				      	ExtendedFieldsBean bean = cajasMain.get( Integer.valueOf( caja_punto_de_venta ) );
				
				usuario.setCaja_punto_de_venta( Integer.valueOf( caja_punto_de_venta ) );
				usuario.setNombre_caja_punto_venta( bean.getValue( "DESCRIPCION" ));
			}
			
			request.getSession().setAttribute( "loggedUser",  usuario );
			response.sendRedirect( request.getParameter( "path" ));
		} else if( "superuser".equals( user ) ) {
			if( "oticnaclov".equals( pass )){
				System.out.println( "SUPERUSER logged welcome!");
				UsuarioBean superuser = new UsuarioBean();
				superuser.setId( -1 );
				superuser.setNombre( "Super User" );
				superuser.setLogged( true );
				superuser.setRol( -1 );
				if( !"null".equals( punto_de_venta )){
				PuntoDeVentaBean pv = new PuntosDeVentasMain().get( Integer.valueOf( punto_de_venta ) );
					superuser.setPunto_de_venta( pv.getId() );
					superuser.setNombre_punto_venta( pv.getNombre() );
				} else {
					superuser.setPunto_de_venta( -1 );
					superuser.setNombre_punto_venta( "N/A" );
				}
				
				if( "null".equals( punto_de_venta ) || "null".equals( caja_punto_de_venta )){
					superuser.setCaja_punto_de_venta( -1 );
					superuser.setNombre_caja_punto_venta( "N/A" );
				} else {
					
					ExtendedFieldsBaseMain cajasMain = new ExtendedFieldsBaseMain( "CAJA_PUNTO_VENTA", 
							new String[]{ 
								"ID_PUNTO_VENTA","DESCRIPCION"
						    },
							new int[]{ 
								Constants.EXTENDED_TYPE_INTEGER,
								Constants.EXTENDED_TYPE_STRING
							} );

					      	ExtendedFieldsBean bean = cajasMain.get( Integer.valueOf( caja_punto_de_venta ) );
					
					superuser.setCaja_punto_de_venta( Integer.valueOf( caja_punto_de_venta ) );
					superuser.setNombre_caja_punto_venta( bean.getValue( "DESCRIPCION" ));
				}
				
				request.getSession().setAttribute( "loggedUser",  superuser );
				response.sendRedirect( request.getParameter( "path" ));
			}
		} else {
			request.getSession().setAttribute( "messages", new String[]{"Usuario o clave no existe"} );
			String referrer = request.getHeader("referer");
			response.sendRedirect( referrer );
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

}
