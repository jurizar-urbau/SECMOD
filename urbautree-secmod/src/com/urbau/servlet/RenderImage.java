package com.urbau.servlet;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.urbau.misc.Util;

@WebServlet("/RenderImage")
public class RenderImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RenderImage() {
        super();
    }

	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String imagePath = request.getParameter("imagePath");
		String w = request.getParameter( "w" );
		String h = request.getParameter( "h" );
		String type = request.getParameter( "type" );
		int width = -1;
		int height = -1;
		
		
		System.out.println("Rendering the  image path: "+ imagePath);		
		
		if(null != imagePath && !imagePath.isEmpty()){
			
			byte[] bytesData = null;
			try{
				FileInputStream is = new FileInputStream(imagePath);
				
				BufferedImage image = ImageIO.read( is );

				if( !Util.isEmpty( w ) ){
					width = Integer.valueOf( w ); 
				}
				if( !Util.isEmpty( h ) ){
					height = Integer.valueOf( h ); 
				}
				if( Util.isEmpty( w ) && Util.isEmpty( h )){
					width = image.getWidth();
					height = image.getHeight();
				}
				
				if( width > 0 ){
					int type_hint = Image.SCALE_DEFAULT;;
					if( "default".equals( type )  ){
						type_hint = Image.SCALE_DEFAULT;
					} else if( "smooth".equals( type )  ){
						type_hint = Image.SCALE_SMOOTH;
					} else if( "average".equals( type )  ){
						type_hint = Image.SCALE_AREA_AVERAGING;
					}
					
					Image scaledImage = image.getScaledInstance( width, height, type_hint );
					BufferedImage after = toBufferedImage( scaledImage );
					ImageIO.write(after, "png", response.getOutputStream());	
				} else {
					bytesData = IOUtils.toByteArray(is);
				}

				
			}catch(FileNotFoundException e){
				
				System.out.println("Error in File Inpur Stream for a image : "+ e.getMessage());
				FileInputStream is = new FileInputStream(request.getSession().getServletContext().getRealPath("/assets/img/placeholder_default.png"));
				bytesData = IOUtils.toByteArray(is);
			}
			
			if(null != bytesData){
				ServletOutputStream sos = response.getOutputStream();
				sos.write(bytesData);
				sos.flush();
				sos.close();
			}
						
		}			
	}
	public BufferedImage toBufferedImage(Image img)
	{
	    if (img instanceof BufferedImage)
	    {
	        return (BufferedImage) img;
	    }

	    // Create a buffered image with transparency
	    BufferedImage bimage = new BufferedImage(img.getWidth(null), img.getHeight(null), BufferedImage.TYPE_INT_ARGB);

	    // Draw the image on to the buffered image
	    Graphics2D bGr = bimage.createGraphics();
	    bGr.drawImage(img, 0, 0, null);
	    bGr.dispose();

	    // Return the buffered image
	    return bimage;
	}


}
