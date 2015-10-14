package com.urbau.applets;

import java.applet.Applet;
import java.io.FileOutputStream;
import java.io.PrintStream;

public class PrintApplet  extends Applet {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5734225671775474751L;

	
	
	private void print( StringBuffer content ){
		try{
			FileOutputStream os = new FileOutputStream("LPT1");
	        PrintStream ps = new PrintStream(os);
	        ps.print(content);
	        ps.print("\f");
	        ps.close();
		}  catch( Exception e ){
			e.printStackTrace();
		}
	}

}
