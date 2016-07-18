package com.urbau.misc;

import java.util.ArrayList;
import java.util.Calendar;

import com.urbau.beans.ClienteBean;
import com.urbau.beans.ExtendedFieldsBean;
import com.urbau.beans.OrdenBean;
import com.urbau.beans.OrdenDetailBean;
import com.urbau.beans.ProductoBean;
import com.urbau.feeders.ClientesMain;
import com.urbau.feeders.ExtendedFieldsBaseMain;
import com.urbau.feeders.ExtendedFieldsOrderBy;
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
		//dispatch.setTotal( String.valueOf( orden.getMonto()));
		
		OrdenesDetalleMain main = new OrdenesDetalleMain();
		
		ExtendedFieldsBaseMain pagos = new ExtendedFieldsBaseMain("PAGOS_ORDENES",
				new String[]{"ID_CUPON","MONTO"}, 
				new int[]{Constants.EXTENDED_TYPE_INTEGER, Constants.EXTENDED_TYPE_DOUBLE}
		);
		ExtendedFieldsBaseMain cupones = new ExtendedFieldsBaseMain("CUPONES_DE_DESCUENTO",
				new String[]{"MONTO"}, 
				new int[]{Constants.EXTENDED_TYPE_DOUBLE}
		);
		ExtendedFieldsFilter pagosfilter = new ExtendedFieldsFilter( 
				new String[]{"ID_ORDEN","ID_CUPON"}, 
				new int[]{ExtendedFieldsFilter.EQUALS,ExtendedFieldsFilter.GT}, 
				new int[]{Constants.EXTENDED_TYPE_INTEGER,Constants.EXTENDED_TYPE_INTEGER}, 
				new String[]{ String.valueOf( orden.getId() ),"0"} 
				);
		
		ExtendedFieldsOrderBy orderBy = new  ExtendedFieldsOrderBy( new String[]{"ID"}, true );
		ArrayList<ExtendedFieldsBean> pagosConCupon = pagos.getAll(pagosfilter, orderBy);
		
		
		ArrayList<OrdenDetailBean> details = main.getDetails( orden.getId() );
		ProductosMain productosMain = new ProductosMain();
		for( OrdenDetailBean bean : details ){
			ProductoBean producto = productosMain.get( bean.getId_producto() );
			dispatch.addDetail( String.valueOf( bean.getCantidad()), String.valueOf( bean.getCantidad()) , producto.getCodigo(), producto.getDescripcion(),
					String.valueOf( bean.getPrecio_unitario()), String.valueOf( bean.getTotal() ));
		}
		if( pagosConCupon.size() > 0 ){
			ExtendedFieldsBean pagoCupon = pagosConCupon.get( 0 );
			ExtendedFieldsBean cupon = cupones.get( Integer.valueOf(pagoCupon.getValue( "ID_CUPON" )));
			dispatch.addDetail("1", "1", "", "DESCUENTO", "",  "-" + cupon.getValue( "MONTO" ) );
			dispatch.setTotal( String.valueOf( orden.getMonto() - Double.valueOf( cupon.getValue( "MONTO" ))));
					
		} else {
			dispatch.setTotal( String.valueOf( orden.getMonto()));
		}
		return dispatch;
	}
	
}
