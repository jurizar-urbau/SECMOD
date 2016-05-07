package com.urbau.print;

import java.awt.Dimension;

import com.mysql.jdbc.StringUtils;

public class FixedMatrixPrint {

	
	char[][] format;
	int width;
	int height; 
	
	public FixedMatrixPrint( Dimension dimension ){
		
		width  = dimension.width;
		height = dimension.height;
		System.out.println( "constructor w:" + width );
		System.out.println( "constructor h:" + height );		
		
		format = new char[ width ][ height ];
	}
	
	public void write( int x, int y, String string ){
		if( x < width && y < height ) {
			int currentChar = 0;
			for( int w = x; w < width -1 ; w ++ ){
				format[ w ][ y ] = string.charAt( currentChar );
				currentChar++;
				if( currentChar >= string.length() ){
					break;
				}
			}
			
		}
	}
	
	public void printableData(){
		System.out.println("============START OF FILE============");
		for( int y = 0; y < height - 1 ; y ++ ){
			for( int x = 0 ; x < width - 1 ; x ++ ){
				if( format[x][y] == 0 ){
					System.out.print(' ');
				} else {
					System.out.print( (char)format[x][y] );
				}
			}
			System.out.println();
		}
		System.out.println("============END OF FILE============");
	}
	
	public static void main(String[] args) {
		FixedMatrixPrint fmp = new FixedMatrixPrint( new Dimension( 83,  58 ));
		fmp.write(52, 3, "0000021" );
		fmp.write(64, 3, "32" );
		
		
		fmp.printableData();
	}
}
