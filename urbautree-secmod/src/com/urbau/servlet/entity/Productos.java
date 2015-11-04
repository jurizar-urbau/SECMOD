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
import com.urbau.beans.ProductoHelperBean;

import com.urbau.feeders.ProductosMain;

import static com.urbau.misc.Constants.ADD;
import static com.urbau.misc.Constants.EDIT;
import static com.urbau.misc.Constants.REMOVE;
import static com.urbau.misc.Constants.MODE_PARAMETER;
import static com.urbau.misc.Constants.ID_PARAMETER;
import static com.urbau.misc.Constants.DESCRIPCION_PARAMETER;
import static com.urbau.misc.Constants.PRECIO_PARAMETER;
import static com.urbau.misc.Constants.PROVEEDOR_PARAMETER;
import static com.urbau.misc.Constants.COEFICIENTE_UNIDAD_PARAMETER;
import static com.urbau.misc.Constants.PRECIO_1_PARAMETER;
import static com.urbau.misc.Constants.PRECIO_2_PARAMETER;
import static com.urbau.misc.Constants.PRECIO_3_PARAMETER;
import static com.urbau.misc.Constants.PRECIO_4_PARAMETER;
import static com.urbau.misc.Constants.IMAGE_PATH_PARAMETER;
import static com.urbau.misc.Constants.STOCK_MINIMO_PARAMETER;
import static com.urbau.misc.Constants.CODIGO_PARAMETER;
import static com.urbau.misc.Constants.FAMILIA;

@WebServlet("/bin/Productos")
public class Productos extends Entity {
	
	private static final long serialVersionUID = 1L;
	       
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	    	
    	//get all parameters from form
    	ProductoHelperBean productoHelperBean = getFormParameters(request);										
    	
		try{					
			HttpSession session = request.getSession();
			validateRequest( session );
			String message = "";
													
			if( null != productoHelperBean && (!productoHelperBean.getMode().isEmpty() || !productoHelperBean.getMode().equals("cancel"))  ){
				
				ProductoBean bean = new ProductoBean();
								
				bean.setCodigo( productoHelperBean.getCodigo() );
				bean.setDescripcion( productoHelperBean.getDescripcion());
				bean.setProveedor(Integer.valueOf( productoHelperBean.getProveedor() ));
				bean.setPrecio( Double.valueOf( productoHelperBean.getPrecio()  ));
				bean.setPrecio_1(Double.valueOf( productoHelperBean.getPrecio_1()  ) );
				bean.setPrecio_2(Double.valueOf( productoHelperBean.getPrecio_2()  ) );
				bean.setPrecio_3(Double.valueOf( productoHelperBean.getPrecio_3()  ) );
				bean.setPrecio_4(Double.valueOf( productoHelperBean.getPrecio_4()  ) );				
				
				bean.setImage_path( productoHelperBean.getImage_path() );
				bean.setFamilia( productoHelperBean.getFamilia() );
																			
				if( !ADD.equals( productoHelperBean.getMode()) ){
					bean.setId( Integer.parseInt( productoHelperBean.getIdString()));
				}
				ProductosMain rmain = new ProductosMain();
				
				if( ADD.equals( productoHelperBean.getMode() )){
					if ( rmain.add( bean ) ){
						message = "Registro creado con exito.";
					} else {
						showMessage( "No se pudo crear el registro " , response );
					}
				} else if( EDIT.equals( productoHelperBean.getMode() )){
					if ( rmain.mod( bean ) ){
						message = "Registro modificado con exito.";
					} else {
						showMessage( "No se pudo modificar el registro ", response  );
					}
				} else if( REMOVE.equals( productoHelperBean.getMode() )){
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
    
    
    @SuppressWarnings("rawtypes")
	public ProductoHelperBean getFormParameters(HttpServletRequest request){
    	
    	ProductoHelperBean phBean = new ProductoHelperBean();			
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
				            				            
				            phBean.setImage_path(file.toString());				            
						}			           
					}else{		
						System.out.println("checking value of: " + fieldName );
						if(fieldName.equals( MODE_PARAMETER )){
							phBean.setMode(fi.getString());							
						}else if(fieldName.equals( ID_PARAMETER )){							
							phBean.setIdString(fi.getString());
						}else if(fieldName.equals(CODIGO_PARAMETER)){
							phBean.setCodigo(fi.getString());							
						}else if(fieldName.equals(DESCRIPCION_PARAMETER)){
							phBean.setDescripcion(fi.getString());							
						}else if(fieldName.equals(PROVEEDOR_PARAMETER)){							
							phBean.setProveedor(fi.getString());
						}else if(fieldName.equals(PRECIO_PARAMETER)){
							if(fi.getString().isEmpty()){
								phBean.setPrecio("0.0");
							}else{
								phBean.setPrecio(fi.getString());
							}							
						}else if(fieldName.equals(PRECIO_1_PARAMETER)){
							if(fi.getString().isEmpty()){
								phBean.setPrecio_1("0.0");
							}else{
								phBean.setPrecio_1(fi.getString());
							}							
						}else if(fieldName.equals(PRECIO_2_PARAMETER)){
							if(fi.getString().isEmpty()){
								phBean.setPrecio_2("0.0");
							}else{
								phBean.setPrecio_2(fi.getString());
							}							
						}else if(fieldName.equals(PRECIO_3_PARAMETER)){
							if(fi.getString().isEmpty()){
								phBean.setPrecio_3("0.0");
							}else{
								phBean.setPrecio_3(fi.getString());
							}							
						}else if(fieldName.equals(PRECIO_4_PARAMETER)){
							if(fi.getString().isEmpty()){
								phBean.setPrecio_4("0.0");
							}else{
								phBean.setPrecio_4(fi.getString());
							}							
						}else if(fieldName.equals(IMAGE_PATH_PARAMETER)){							
							phBean.setImage_path_modified(fi.getString());							
						}else if(fieldName.equals(FAMILIA)){
							phBean.setFamilia( Integer.valueOf( fi.getString() ));
						}
					}
				}  	         
	      }catch(Exception ex) {
	    	  	    	  
	    	  if(phBean.getMode().equals(EDIT)){
	    		  phBean.setImage_path(phBean.getImage_path_modified());	    		  
	    	  }else{	    		  
	    		  phBean.setImage_path(request.getSession().getServletContext().getRealPath("/assets/img/placeholder_default.png"));
	    	  }
	    	  
	    	  System.out.println("ERROR to upload image, using the placeholder_default.png - message: " + ex.getMessage());
	      }   	      	    
	   } 		
		return phBean;
	}
	
}
				
				
				


