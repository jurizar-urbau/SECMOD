package com.urbau.misc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import com.urbau.db.ConnectionManager;

public class InventarioHelper {
	
	
	
	/**
	 * The metodo addBodega crea una tabla de inventario utilizando el parametro 
	 * id_bodega para formar el nombre de la tabla por ejemplo INV1, INV2, etc.
	 * 
	 * @return
	 * 1 : Si la tabla fue creada correctamente.
	 * 0:  Si la tabla no fue creada porque ya existe esa tabla en la base de datos.
	 * 
	 * */
	public int addBodega( int id_bodega ){
		System.out.println( "<< addBodega started >>" );
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;

		int total;

		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			
			int recheckIfTableExistResult = checkIfTableExistsHelper(id_bodega,stmt, rs);
						
			if(recheckIfTableExistResult == 0){
				String sql = "CREATE TABLE INV"+id_bodega+" ( ID_PRODUCT NUMERIC(11) NOT NULL, ESTATUS VARCHAR(1) NOT NULL, " +
						"AMOUNT NUMERIC(12), CONSTRAINT PK_INVID PRIMARY KEY (ID_PRODUCT,ESTATUS))";

				System.out.println( sql );
				total = stmt.executeUpdate( sql )+1;
			}else{
				System.out.println( "La tabla INV"+id_bodega + " ya existe en la base de datos." );
				total = 0;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {			
			ConnectionManager.close( con, stmt, null );
		}
		System.out.println( "<< addBodega completed >> \n" );
		return total;
	}
	
	
	/**
	 * El metodo sustractProduct se usa para restar la cantidad de productos que correspondea la columna
	 * AMOUNT de una tabla de Inventario (INV1, INV2, etc).
	 * 
	 * Flujo:
	 * 	Primero verifica si existe la tabla usando el id_bodega,, si existe la tabla 
	 * 	revisa si la primary key existe (ID_PRODUCT, AMOUNT) de esa tabla encontrada,
	 * 
	 * 	Segundo, verifica si la cantidad a restar es menor que la cantidad de AMOUNT de la tabla inventario (INV1, INV2)
	 * 	si es asi, hace la operacion.
	 * 
	 * 	@return
	 *  
	 *  -1 : Si no encuentra la tabla.
	 *   1 : Si se hizo la operacion correctamente (resta).
	 *   0 : Si no hizo la operacion (No encotro la primary key de la tabla)
	 *  
	 *  
	 * */
	public int sustractProduct( int id_bodega, int id_producto, String state, int amount ){
		System.out.println( "<< sustractProduct started >>" );
		
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;

		int total;

		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();
			
			int recheckIfTableExistResult = checkIfTableExistsHelper(id_bodega,stmt, rs);
						
			if(recheckIfTableExistResult > 0){
				
				int primaryKeyExists = checkIfPrimaryKeyExistsHelper(id_bodega,id_producto,state,stmt,rs);
				
				if(primaryKeyExists > 0){
					int amountRetrieved=getAmountFromTableHelper(id_bodega,id_producto,state, stmt,rs);
					
					if(amountRetrieved >= amount){
						
						int amountUpdate = amountRetrieved-amount;					
						updateInventarioHelper(id_bodega, amountUpdate, id_producto, state, stmt);					
						total = 1;										
						
					}else{
						System.out.println( "La cantidad "+ amount+" excede a lo que contiene el registro" );
						total = 0;
					}
				}else{
					System.out.println( "La primary key (ID_PRODUCT="+id_producto+" ESTATUS='"+state+"') de la tabla INV"+id_bodega + " NO existe");
					total = 0;					
				}
				
								
			}else{
				System.out.println( "La tabla INV"+id_bodega + " no existe en la base de datos." );
				total = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {			
			ConnectionManager.close( con, stmt, null );
		}
		System.out.println( "<< sustractProduct completed  >>  \n" );
		return total;
	}
	

	
	/**
	 * El metodo translateProduct es usado para transferir una cantidad (Amount) de una tabla inventario a otra
	 * siguiendo el siguiente flujo:
	 * 
	 * Primero: Verifica si bodegaOrigen existe, si no existe entonces no hace la transferencia y retorna -1
	 * Segundo: Verifica si existe bodega destino, si no existe entonce sera creada con el parametro id_bodegaDestination (INV1, INV2, etc).
	 * Tercero: Verifica si la primaryKey existe en la tabla origin, si existe continua el flujo, de lo contrario retorna 0
	 * Cuarto:  Verifica si la primaryKey existe en la tabla destino:
	 * Quinto:  Obtener AMOUNT de tabla origin y verifica si se puede hacer la operacion (resta)
	 * 			Si se puede ejecutar la operacion (resta) 				
	 *				Actualizar la AMOUNT de la fila correspondiente de la tabla origin
	 *				
	 * 				Si primaryKey existe en la tabla destino	 *  				
	 * 					- Obtener AMOUNT de la tabla destino y hacer el update de AMOUNT con la primaryKey correspondiente.	 * 				
	 * 				de lo contrario:
	 * 					- crea un nuevo registro con la primaryKey de origin en la nueva tabla de INV1, INV2 etc..
	 * 				
	 * 			de lo contrario:
	 * 				 retorna 0, indicando que no se puede restar la cantidades en AMOUNT de la tabla origin
	 * 			
	 *  @return
	 *  -1 : Si no encuentra la tabla origin.
	 *   1 : Si se hizo la operacion correctamente 
	 *   0 : Si no hizo la operacion
	 *   
	 * */
	public int translateProduct( int id_bodegaOrigin, int id_bodegaDestination, int id_producto, String status, int amount ){
		
		System.out.println( "<< translateProduct started >>" );
		Connection con = null;
		Statement  stmt= null;
		ResultSet  rs   = null;

		int total;

		try {
			con = ConnectionManager.getConnection();
			stmt= con.createStatement();					
						
			if(checkIfTableExistsHelper(id_bodegaOrigin, stmt, rs) > 0){
				
				// create table destination if it not exists
				addBodega(id_bodegaDestination);				
				
				// check if primary key on table origin exists
				int primaryKeyExistsOrigin = checkIfPrimaryKeyExistsHelper(id_bodegaOrigin,id_producto,status,stmt,rs);
				if(primaryKeyExistsOrigin > 0){
																							
					// check if primary key exists on table destination
					int primaryKeyExistsDestination = checkIfPrimaryKeyExistsHelper(id_bodegaDestination,id_producto,status,stmt,rs);
					
					// get amount from table origin
					int amountOrigin = getAmountFromTableHelper(id_bodegaOrigin,id_producto,status,stmt,rs);
					if(amountOrigin >= amount){
												
						// updating table oring
						int amountUpdatedOrigin = amountOrigin-amount;																								
						updateInventarioHelper(id_bodegaOrigin, amountUpdatedOrigin, id_producto, status, stmt);
						
						
						if(primaryKeyExistsDestination > 0){
																									
							// get amount from table destination
							int amountDestination = getAmountFromTableHelper(id_bodegaDestination,id_producto,status,stmt,rs);
							int amountUpdatedDestination = amountDestination+amount;
										
							// updating table destination
							updateInventarioHelper(id_bodegaDestination, amountUpdatedDestination, id_producto, status, stmt);										
							total = 1;														
						}else{
							
							String sqlInsertDestination = "INSERT INTO  INV"+id_bodegaDestination+
									" (ID_PRODUCT,ESTATUS,AMOUNT) " +
										"VALUES " +
									"("+ id_producto+",'"+status+"',"+amount+")";
							System.out.println("sqlInsert Destination:: " + sqlInsertDestination);
							stmt.executeUpdate( sqlInsertDestination );
							total = 1;
						}
						
					}else{					
						System.out.println( "La cantidad "+ amount+" excede a lo que contiene el registro de la tabla INV"+id_bodegaOrigin);
						total = 0;
					}	
												
				}else{
					System.out.println( "La primary key (ID_PRODUCT="+id_producto+" ESTATUS='"+status+"') de la tabla INV"+id_bodegaOrigin + " NO existe");
					total = 0;
				}
								
			}else{
				System.out.println( "La tabla Origen INV"+id_bodegaOrigin + " no existe en la base de datos." );
				total = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {			
			ConnectionManager.close( con, stmt, null );
		}
		System.out.println( "<< translateProduct Completed >>\n" );
		return total;
		
	}
	
	
	public void updateInventarioHelper(int id_bodega, int amount, int id_producto, String status,Statement stmt){		
		try{
			String sqlUpdateDestination = "UPDATE INV"+id_bodega+" SET AMOUNT="+amount+" WHERE ID_PRODUCT="+id_producto+" AND ESTATUS='"+status+"'";						
			stmt.executeUpdate( sqlUpdateDestination );
			System.out.println("sqlUpdate:: " + sqlUpdateDestination);
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error to upadate the table INV"+id_bodega);
		}
	}
	
	public int checkIfPrimaryKeyExistsHelper(int id_bodega, int id_producto, String status, Statement  stmt, ResultSet  rs){
		
		int amountRetrieved=0;		
		try{		
			String sql = "SELECT * FROM INV"+id_bodega+" WHERE ID_PRODUCT="+id_producto+" and ESTATUS='"+status+"'";
	
			System.out.println( sql );				
			rs = stmt.executeQuery( sql );
			
			while( rs.next() ){
				amountRetrieved = rs.getInt(1);
				break;
			}
		}catch(Exception e){
			e.printStackTrace();			
		}			
		return amountRetrieved;
	}

	
	public int getAmountFromTableHelper(int id_bodega, int id_producto, String status, Statement  stmt, ResultSet  rs){		
		int amountRetrieved=0;
		
		try{
			String sql = "SELECT AMOUNT FROM INV"+id_bodega+" WHERE ID_PRODUCT="+id_producto+" and ESTATUS='"+status+"'";
	
			System.out.println( sql );				
			rs = stmt.executeQuery( sql );
			
			while( rs.next() ){
				amountRetrieved = rs.getInt(1);
				break;
			}
		}catch(Exception e){
			e.printStackTrace();
		}	
		
		return amountRetrieved;
	}
	
	public int checkIfTableExistsHelper(int idBodega, Statement  stmt, ResultSet  rs){
		
		try{
			String checkIfTableExistCommand = "SHOW TABLES  LIKE 'INV"+idBodega+"'";			
			rs = stmt.executeQuery( checkIfTableExistCommand);
			rs.beforeFirst();
			rs.last();			
			return  rs.getRow();
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		
	}

}
