package com.urbau.misc;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.ObjectInputStream.GetField;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;


public class MergePrintableFile {
	
	
	public String merge( File template, Map<String, String> values ){
		try{
			BufferedReader bis = new BufferedReader( new FileReader(template));
			String line;
			while( ( line = bis.readLine() ) != null ){
				System.out.println( "normal   [" + line + "]" );
				if( line.length() > 64 ){
				System.out.println( "replaced [" + StringUtils.overlay( line, "01", 64, 64 + 2)  + "]" );
				} else {
					System.out.println( "line shorter: " + line );
				}
					
			}
			bis.close();
		} catch( Exception e ){
			e.printStackTrace();
		} 
		
		return null;
	}
	
	public static void main2(String[] args) {
		MergePrintableFile mpf = new MergePrintableFile();
		
		File template = new File( "/Users/xumakgt/Desktop/templateEnvio.txt" );
		Map<String, String> values = new HashMap<String, String>();
		
		mpf.merge(template, values);
		
	}
	
	
	public static void main3(String[] args) {
		AsciiPage page1 = new AsciiPage();
		page1.writeString(53, 4, "0000021" );
		page1.writeString(65, 4, "11" );
		page1.writeString(71, 4, "07" );
		page1.writeString(78, 4, "2016" );
		
		
		page1.writeString(51, 7, "jurizar" );
		
		
		System.out.println( "----------------INICIO-----------------" );
		System.out.print( page1 );
		System.out.println( "----------------  FIN  ----------------" );
	}
	
	public static void main(String[] args) {
		OrderDispatch od = new OrderDispatch();
		od.setNoEnvio( "0001" );
		od.setFecha(  Calendar.getInstance() );
		od.setNoVendedor( "jurizar");
		od.setNoSupervisor( "iburizar" );
		od.setCliente("JOSE ALEJANDRO URIZAR");
		od.setCarnetNumero( "021016" );
		od.setDireccion( "#31 VILLA SANTORINI KM 25.5 CARRETERA A EL SALVADOR." );
		od.setTel( "59935020" );
		od.setTotal( "100.00" ); 
		od.addDetail( "1", "1", "PB001", "COHETILLO CLASICO", "3.75", "3.75" );
		od.addDetail( "2", "2.0", "PB002", "VOLCANCITO CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "2", "2.0", "PB002", "VOLCANCITO CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", "3.75", "3.75" );
		od.addDetail( "3", "3.0", "PB003", "TRONDADOR CLASICO", 
				getFixedString("3.74", ALIGN_RIGTH, 10, ' '), 
				"3.75" );

		
		
		
		System.out.println( od );
		System.out.println( "final ["+getFixedString("3.74", ALIGN_RIGTH, 10, ' ')+"]");
 	}
	
	public static final int ALIGN_LEFT = 1;
	public static final int ALIGN_RIGTH = 2;
	
	public static String getFixedString( String st, int align, int size,char fillChar ){
		String str = "";
		System.out.println( "ST: "+ st );
		System.out.println( "ALIGN:" + align );
		System.out.println( "SIZE: " + size );
		System.out.println( "FILLCHAR: [" + fillChar + "]" );
		
		if( ALIGN_LEFT == align ){
			str = st;
			if( str.length() < size ){
				for( int n = 0; n < size - str.length(); n++){
					str += (char)fillChar;
				}
			}
		} else {
			if( str.length() < size ){
				for( int n = 0; n < size - str.length(); n++){
					str += (char)fillChar;
				}
			}
			str += st;
		}
		return str;
	}
	
}
