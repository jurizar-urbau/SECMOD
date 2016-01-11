package com.urbau.servlet.entity;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.InvetarioBean;
import com.urbau.beans.OrdenBean;
import com.urbau.beans.OrdenDetailBean;
import com.urbau.beans.OrdenPagoBean;
import com.urbau.beans.UsuarioBean;
import com.urbau.feeders.InventariosMain;
import com.urbau.feeders.OrdenesDetalleMain;
import com.urbau.feeders.OrdenesMain;
import com.urbau.misc.Util;
import static com.urbau.misc.Constants.ESTADO_CANCELADO;

@WebServlet("/bin/ReversePayment")
public class ReversePayment extends Entity {
	private static final long serialVersionUID = 1L;
	

       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			System.out.println( "calling reverse paymnt...");
			HttpSession session = request.getSession();
			UsuarioBean loggedUser = getLoggedUser( session );
			validateRequest( session );
			
			String id = request.getParameter( "formid" );
			System.out.println( "id: " + id );
				
			String message = "No se pudo eliminar la orden.";
			
			OrdenPagoBean b = new OrdenPagoBean();
			b.setOrden_id( Integer.valueOf( id ));
			
			
			OrdenesMain ordenesMain = new OrdenesMain();
			
				if( ordenesMain.changeStatus( b.getOrden_id(), ESTADO_CANCELADO, loggedUser.getId() )){
					InventariosMain inventarios = new InventariosMain();
					OrdenesMain ordenes = new OrdenesMain();
					OrdenBean ordenBean = ordenes.get( b.getOrden_id() );
					OrdenesDetalleMain ordenesDetalleMain = new OrdenesDetalleMain();
					ArrayList<OrdenDetailBean> ordenDetailBeanList = ordenesDetalleMain.getDetails( ordenBean.getId() );
					System.out.println( "orden details found: " + ordenDetailBeanList.size() );
					for( OrdenDetailBean ordenDetailBean : ordenDetailBeanList ){
						InvetarioBean inv_activo = inventarios.get(ordenDetailBean.getId_producto(), "a", ordenBean.getId_bodega() );
						inv_activo.setIdBodega( ordenBean.getId_bodega() );
						inv_activo.setAmount( ordenDetailBean.getCantidad() + inv_activo.getAmount() );
						boolean a1 = inventarios.mod( inv_activo );
						System.out.println("ai:" + a1 );
						
						InvetarioBean inv_inactivo = inventarios.get( ordenDetailBean.getId_producto(), "r", ordenBean.getId_bodega(), ordenBean.getId() );
						inv_inactivo.setEstatus(ESTADO_CANCELADO);
						inv_inactivo.setIdBodega( ordenBean.getId_bodega() );
						boolean a2 = inventarios.modWithoutStatus( inv_inactivo );
						System.out.println("a2:" + a2 );
					}
					message = "Eliminada con exito."; 
				} else {
					System.out.println( "no se pudo cambiar el estado..." );
					message = "No se pudo eliminar.";
				}
			
			
			
			response.getOutputStream().write( message.getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
			
			
		} catch( Exception exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
    
    void printParameterValues( String[] values ){
    	for( String s : values ){
    		System.out.println( ">\t" + s);
    	}
    }
	
    private String  validateParameters( 
    		String order_id, String tipo_pago, String numero_cheque, String banco, String tipo_tarjeta, 
    		String numero_tarjeta, String autorizacion, String monto ) {
    	
		String message = "";
		
		if( Util.isEmpty( order_id )){
			message = "No ha seleccionado una orden";
		} else if( Util.isEmpty(tipo_pago)) {
			message = "No ha seleccionado un tipo de pago";
		} else if( Util.isEmpty( monto )){
			message = "No ha ingresado un monto";
		}
		
		if( "tarjeta".equals( tipo_pago  )){
			if( Util.isEmpty( banco  )){
				message = "No ha seleccionado un banco";
			} else if( Util.isEmpty( tipo_tarjeta )) {
				message = "No ha seleccionado un tipo de tarjeta";
			} else if ( Util.isEmpty( numero_tarjeta )){
				message = "No ha ingresado un numero de tarjeta";
			} else if ( Util.isEmpty( autorizacion )){
				message = "No ha ingresado una autorizacion";
			}
		} else if( "cheque".equals( tipo_pago  )){
			if( Util.isEmpty( numero_cheque )){
				message = "No ha ingresado un numero de cheque";
			} else if( Util.isEmpty( banco  )){
				message = "No ha seleccionado un banco";
			}
		}
		return message;
    	
    }
   
}
				
							