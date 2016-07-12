package com.urbau.misc;

import java.util.ArrayList;
import java.util.Calendar;

import com.urbau.beans.OrdenBean;
import com.urbau.beans.OrdenDetailBean;
import com.urbau.feeders.OrdenesDetalleMain;

public class OrderPrintWrapper {

	
	
	public OrderDispatch getOrderDispatchPrintable( OrdenBean orden ){
		OrderDispatch dispatch = new OrderDispatch();
		Calendar fecha = Calendar.getInstance();
		fecha.setTime( orden.getFecha() );
		dispatch.setNoEnvio( String.valueOf( orden.getId()  ));
		dispatch.setFecha( fecha );
		dispatch.setNoVendedor( String.valueOf( orden.getId_usuario()  ));
		dispatch.setNoSupervisor( String.valueOf( orden.getId_usuario()  )  );
		dispatch.setCliente(  orden.getId_cliente() + " BUSCAR NOMBRES" );
		dispatch.setCarnetNumero( String.valueOf( orden.getId_cliente() ));
		dispatch.setDireccion( String.valueOf( orden.getId_cliente() ));
		dispatch.setTel( String.valueOf( orden.getId_cliente() ));
		
		OrdenesDetalleMain main = new OrdenesDetalleMain();
		
		ArrayList<OrdenDetailBean> details = main.getDetails( orden.getId() );
		for( OrdenDetailBean bean : details ){
			dispatch.addDetail( String.valueOf( bean.getCantidad()), String.valueOf( bean.getCantidad()) , String.valueOf( bean.getId_producto()), String.valueOf(  bean.getId_producto()),
					String.valueOf( bean.getPrecio_unitario()), String.valueOf( bean.getTotal() ));
		}
		return dispatch;
	}
	
}
