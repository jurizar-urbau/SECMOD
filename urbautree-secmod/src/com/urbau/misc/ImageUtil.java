package com.urbau.misc;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.InputStream;
import javax.imageio.ImageIO;

public class ImageUtil {
	
	public static void saveScaledImage( InputStream is, int width, int height, File outputfile ){
		try{
		BufferedImage image = ImageIO.read( is );	
		Image scaledImage = image.getScaledInstance( width, height, Image.SCALE_SMOOTH );
		BufferedImage after = toBufferedImage( scaledImage );
		ImageIO.write(after, "jpg", outputfile);
		} catch( Exception e ){
			System.out.println( "Error scaling image" );
			e.printStackTrace();
		}
	}
	
	public static BufferedImage toBufferedImage(Image img) {
	    if (img instanceof BufferedImage) {
	        return (BufferedImage) img;
	    }
	    BufferedImage bimage = new BufferedImage(img.getWidth(null), img.getHeight(null), BufferedImage.TYPE_INT_ARGB);
	    Graphics2D bGr = bimage.createGraphics();
	    bGr.drawImage(img, 0, 0, null);
	    bGr.dispose();
	    return bimage;
	}
}
