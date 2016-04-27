package com.urbau.misc;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
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
	
	public static void main(String[] args) {
		MergePrintableFile mpf = new MergePrintableFile();
		
		File template = new File( "/Users/xumakgt/Desktop/templateEnvio.txt" );
		Map<String, String> values = new HashMap<String, String>();
		
		mpf.merge(template, values);
		
	}

}
