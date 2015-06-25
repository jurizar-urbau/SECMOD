package com.urbau.servlet.entity;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.urbau._abstract.entity.Entity;
import com.urbau.beans.ProductoBean;
import com.urbau.feeders.ProductosMain;

@WebServlet("/Productos")
public class Productos extends Entity {
	private static final long serialVersionUID = 1L;
	private String mode="";
	private String id = "";
	private String codigo = "";
	private String descripcion = "";
	private String coeficiente_unidad ="";
	private String proveedor = "";
	private String precio ="";
	private String precio_importacion="";
	private String image_path = "";
	private String image_path_modified = "";
	private String stock_minimo = "";
	
       	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	    	
    	//get all parameters from form
    	getFormParameters(request);										
    	
		try{
						
			HttpSession session = request.getSession();
			validateRequest( session );
			String message = "";
			
			System.out.println( "mode: " + this.mode );			
						
			if( !this.mode.isEmpty() || !this.mode.equals("cancel")  ){
				
				ProductoBean bean = new ProductoBean();				
				bean.setCodigo( this.codigo );
				bean.setDescripcion( this.descripcion );
				bean.setCoeficiente_unidad( Integer.valueOf( this.coeficiente_unidad ));
				bean.setProveedor(Integer.valueOf( this.proveedor ));
				bean.setPrecio( Double.valueOf( this.precio  ));
				bean.setPrecio_importacion( Double.valueOf( this.precio_importacion  ));
				bean.setStock_minimo(Integer.valueOf( this.stock_minimo ));
				bean.setImage_path( this.image_path );
								
											
				if( !"add".equals( this.mode ) ){
					bean.setId( Integer.parseInt( this.id));
				}
				ProductosMain rmain = new ProductosMain();
				
				if( "add".equals( this.mode )){
					if ( rmain.add( bean ) ){
						message = "Registro creado con exito.";
					} else {
						showMessage( "No se pudo crear el registro " , response );
					}
				} else if( "edit".equals( this.mode )){
					if ( rmain.mod( bean ) ){
						message = "Registro modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el registro ", response  );
					}
				} else if( "remove".equals( this.mode )){
					if ( rmain.del( bean ) ){
						message = "Registro eliminado con exito.";
					} else {
						showMessage( "No se pudo eliminar el registro " , response );
					}
				}
				response.getOutputStream().write( message.getBytes() );
				response.getOutputStream().flush();
				response.getOutputStream().close();
			}
			
		} catch( UserNotAuthenticatedException exception ){
			System.out.println( "Error: " + exception.getMessage() );
			exception.printStackTrace();
			response.getOutputStream().write( exception.getMessage().getBytes() );
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}
    
    
    public String getFormParameters(HttpServletRequest request){
    	
		String imagePath="";		
		File file ;
		
		int maxFileSize = 35000 * 1024;
	    int maxMemSize = 35000 * 1024;
	    
		ServletContext context = request.getSession().getServletContext();
		String filePath = context.getInitParameter("file-upload-path");					  
		String contentType = request.getContentType();
	   		
		if ((contentType.indexOf("multipart/form-data") >= 0)) {
			
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			// maximum size that will be stored in memory
			factory.setSizeThreshold(maxMemSize);
			
			// Location to save data that is larger than maxMemSize.
			factory.setRepository(new File("/usr/tmp/"));
	      
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			
			// maximum file size to be uploaded.
			upload.setSizeMax( maxFileSize );
			
			try{							
				List fileItems = upload.parseRequest(request);						// Parse the request to get file items.				
				Iterator i = fileItems.iterator();									// Process the uploaded file items
	         
				while ( i.hasNext () ) {
					
					FileItem fi = (FileItem)i.next();					
					String fieldName = fi.getFieldName();
					
					if ( !fi.isFormField () ){						
						String fileName = fi.getName();
		          			            			            
						if(fi.getFieldName().equals("image_path")){
		    							
			            	// Write the file
				            if( fileName.lastIndexOf("\\") >= 0 ){
					            file = new File( filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
				            }else{
					            file = new File( filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
				            }				            			            				            	
				            fi.write( file ) ;
				            
				            this.image_path= file.toString();				            
				            
						}			           
					}else{										
						if(fieldName.equals("mode")){
							this.mode = fi.getString();
						}else if(fieldName.equals("id")){
							this.id = fi.getString();
						}else if(fieldName.equals("codigo")){
							this.codigo = fi.getString();
						}else if(fieldName.equals("descripcion")){
							this.descripcion = fi.getString();
						}else if(fieldName.equals("coeficiente_unidad")){
							this.coeficiente_unidad = fi.getString();
						}else if(fieldName.equals("proveedor")){
							this.proveedor = fi.getString();
						}else if(fieldName.equals("precio")){
							this.precio= fi.getString();
						}else if(fieldName.equals("precio_importacion")){
							this.precio_importacion= fi.getString();
						}else if(fieldName.equals("imagePath")){
							this.image_path_modified= fi.getString();
						}else if(fieldName.equals("stock_minimo")){
							this.stock_minimo= fi.getString();
						}															
					}
				}  	         
	      }catch(Exception ex) {
	    	  	    	  
	    	  if(this.mode.equals("edit")){
	    		  this.image_path= this.image_path_modified;
	    	  }else{
	    		  this.image_path= request.getSession().getServletContext().getRealPath("/assets/img/placeholder_default.png");
	    	  }
	    	  
	    	  System.out.println("ERROR to upload image, using the placeholder_default.png - message: " + ex.getMessage());
	      }   	      	    
	   } 		
		return imagePath;
	}
	
}
				
				
				


