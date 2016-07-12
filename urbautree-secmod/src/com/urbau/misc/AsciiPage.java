package com.urbau.misc;

public class AsciiPage {

	final static int WIDTH  = 87;
	final static int HEIGTH = 58;
	final static char NEW_LINE = '\n';
	
	char[][] allchars = new char[87][58];
	
	public void writeString(int x, int y, int value ){
		writeString(x, y, String.valueOf( value ) );
	}
	
	public void writeString(int x, int y, String string ){
		if( string.length() <= (WIDTH - x) ){
			int currentx = x;
			for( char c: string.toCharArray() ){
				allchars[ currentx - 1 ][ y - 1 ] =  (char)c;
				currentx++;
			}
		} else {
			System.out.println("no cabe..");
		}
	}
	
	public String toString(){
		StringBuffer stringBuffer = new StringBuffer();
		for( int Y = 0; Y < HEIGTH ; Y++ ){
			for( int X = 0; X < WIDTH ; X++ ){
				stringBuffer.append( fillIfEmpty(allchars[X][Y]) );
			}
			stringBuffer.append( NEW_LINE );
		}
		return stringBuffer.substring( 0, stringBuffer.length() -1 );
	}
	char fillIfEmpty( char c ){
		if( Character.UNASSIGNED == c ){
			return ' ';
		} else {
			return c;
		}
	}
}
