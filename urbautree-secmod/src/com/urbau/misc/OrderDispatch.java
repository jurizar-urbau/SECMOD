package com.urbau.misc;

import java.util.ArrayList;
import java.util.Calendar;

public class OrderDispatch {

	ArrayList<AsciiPage> listOfPages = new ArrayList<>();
	AsciiPage firstPage = new AsciiPage();
	
	int currentDetailLine = 15;
	boolean appendable = true;
	
	public void setNoEnvio( String noenvio ){
		firstPage.writeString(53, 4, noenvio );
	}
	public void setNoVendedor( String novendedor ){
		firstPage.writeString(51, 7, novendedor );
	}
	public void setNoSupervisor( String nosupervisor ){
		firstPage.writeString(75, 7, nosupervisor );
	}
	public void setCliente( String cliente ){
		firstPage.writeString(8, 9, cliente );
	}
	public void setCarnetNumero( String carnet ){
		firstPage.writeString(77, 9, carnet );
	}
	public void setDireccion(String direccion){
			firstPage.writeString(11, 11, direccion );
	}
	public void setTel(String telefono){
		firstPage.writeString(71, 11, telefono );
	}
	public void setTotal(String total){
		firstPage.writeString(78, 58, total );
	}
	
	public void setFecha( Calendar date ){
		firstPage.writeString(65, 4, date.get( Calendar.DAY_OF_MONTH ) );
		firstPage.writeString(71, 4, date.get( Calendar.MONTH ) + 1 );
		firstPage.writeString(78, 4, date.get( Calendar.YEAR ) );
	}
	
	public void addDetail( String cant, String unid, String codigo, String descripcion, String punit, String total ){
		if( appendable ){
			firstPage.writeString( 4,  currentDetailLine, cant );
			firstPage.writeString( 9,  currentDetailLine, unid );
			firstPage.writeString( 14, currentDetailLine, codigo );
			firstPage.writeString( 23, currentDetailLine, descripcion );
			firstPage.writeString( 66, currentDetailLine, Util.getFixedString(
					String.valueOf( punit ), Util.ALIGN_RIGTH, 7, ' ') );
			firstPage.writeString( 76,  currentDetailLine, Util.getFixedString(
					String.valueOf( total ), Util.ALIGN_RIGTH, 10, ' ') );
			currentDetailLine += 2;
			if( currentDetailLine > 54 ){
				appendable = false;
			}
		} else { 
			System.out.println("WARN: page full, please implement multiple page pinting." );
		}
	}
	public String toString(){
		return firstPage.toString();
	}
	
	
}
