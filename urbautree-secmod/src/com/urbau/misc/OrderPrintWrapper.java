package com.urbau.misc;

import java.util.ArrayList;
import java.util.Calendar;

import com.urbau.beans.ClienteBean;
import com.urbau.beans.OrdenBean;
import com.urbau.beans.OrdenDetailBean;
import com.urbau.beans.ProductoBean;
import com.urbau.feeders.ClientesMain;
import com.urbau.feeders.OrdenesDetalleMain;
import com.urbau.feeders.ProductosMain;

public class OrderPrintWrapper {

	
	public OrderPrintWrapper(){
		
	}
	
	public OrderDispatch getOrderDispatchPrintable( OrdenBean orden ){
		OrderDispatch dispatch = new OrderDispatch();
		Calendar fecha = Calendar.getInstance();
		fecha.setTime( orden.getFecha() );
		dispatch.setNoEnvio( String.valueOf( orden.getId()  ));
		dispatch.setFecha( fecha );
		dispatch.setNoVendedor( String.valueOf( orden.getId_usuario()  ));
		dispatch.setNoSupervisor( String.valueOf( orden.getId_usuario()  )  );
		ClientesMain clienteMain = new ClientesMain();
		ClienteBean cliente = clienteMain.get( orden.getId_cliente() );
		dispatch.setCliente( cliente.getNombres() + " " + cliente.getApellidos() );
		dispatch.setCarnetNumero( String.valueOf( orden.getId_cliente() ));
		dispatch.setDireccion( cliente.getDireccion() );
		dispatch.setTel( cliente.getTelefono() );
		dispatch.setTotal( String.valueOf( orden.getMonto()));
		
		OrdenesDetalleMain main = new OrdenesDetalleMain();
		
		ArrayList<OrdenDetailBean> details = main.getDetails( orden.getId() );
		ProductosMain productosMain = new ProductosMain();
		for( OrdenDetailBean bean : details ){
			ProductoBean producto = productosMain.get( bean.getId_producto() );
			dispatch.addDetail( String.valueOf( bean.getCantidad()), String.valueOf( bean.getCantidad()) , producto.getCodigo(), producto.getDescripcion(),
					String.valueOf( bean.getPrecio_unitario()), String.valueOf( bean.getTotal() ));
		}
		return dispatch;
	}
	
}
