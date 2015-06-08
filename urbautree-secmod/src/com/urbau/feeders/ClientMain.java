package com.urbau.feeders;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.support.ConnectionSource;
import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ClientBean;
import com.urbau.beans.CountryBean;
import com.urbau.db.ORMConnectionManager;
import com.urbau.misc.Util;

public class ClientMain extends AbstractMain {
	private Dao<ClientBean, Integer> clientDAO;
	
	
	public ArrayList<ClientBean> getItems( ){
		ArrayList<ClientBean> list = new ArrayList<ClientBean>();
		ConnectionSource conSource = null;
		try {
		conSource = ORMConnectionManager.getConnection();
		
		setupDatabase(conSource);
		list = (ArrayList<ClientBean>) clientDAO.queryForAll();
		 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		return list;
	}
	
	
	
	private void setupDatabase(ConnectionSource conSource) {
		try {
			clientDAO = DaoManager.createDao(conSource, ClientBean.class);
			//can create a table but already exist
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}


@Deprecated
	public ClientBean getBean(ResultSet rs) throws Exception {
		ClientBean bean = new ClientBean();
		
		bean.setId(  rs.getInt   ( 1  ));
		bean.setRzsocial(Util.trimString( rs.getString( 2 )));
		bean.setClient(Util.trimString( rs.getString( 3 )));
		bean.setFax(Util.trimString( rs.getString( 4 )));
		bean.setFaxalt(Util.trimString( rs.getString( 5 )));
		bean.setTel(Util.trimString( rs.getString( 6 )));
		bean.setTelalt(Util.trimString( rs.getString( 7 )));
		bean.setNumfiscal(Util.trimString( rs.getString( 8 )));
		bean.setAddrfiscal(Util.trimString( rs.getString( 9 )));
		bean.setEmail(Util.trimString( rs.getString( 10 )));
		bean.setAddrship(Util.trimString( rs.getString( 11 )));
		bean.setCountry(rs.getInt(12));
		bean.setTipo_cliente(rs.getInt(13));
		bean.setSeller(rs.getInt(14));
		
		return bean;
	}



	public ClientBean getItem( int id ){

		if(id<0) {
			return getBlankBean();
		}
		ConnectionSource conSource = null;
		ClientBean tpc = getBlankBean();
		try {
			conSource = ORMConnectionManager.getConnection();
			setupDatabase(conSource);
		
			tpc = clientDAO.queryForId(id);
			
			
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
			return tpc;
		
		
	}
	
	public ClientBean getBlankBean(){
		ClientBean bean = new ClientBean();
		bean.setRzsocial("");
		bean.setClient("");
		bean.setFax("");
		bean.setFaxalt("");
		bean.setTel("");
		bean.setTelalt("");
		bean.setNumfiscal("");
		bean.setNumfiscal("");
		bean.setAddrfiscal("");
		bean.setEmail("");
		bean.setRating(0);
		bean.setAddrship("");
		bean.setCountry(new CountryBean());
		bean.setTipo_cliente(0);
		bean.setSeller(0);
		
		
		return bean;
	}
	public boolean addItem( ClientBean bean ){
		ConnectionSource conSource = null;
		boolean result = false;
		try {
			conSource = ORMConnectionManager.getConnection();
			setupDatabase(conSource);
			clientDAO.create(bean);
			clientDAO.update(bean);
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		
		return result;
	}
	

	public boolean modItem( ClientBean bean ){
		ConnectionSource conSource = null;
		boolean result = false;
		try {
		conSource = ORMConnectionManager.getConnection();
		setupDatabase(conSource);
		
		clientDAO.update(bean);
		result = true;
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		
		return result;
	}
	
	

	public boolean delItem( ClientBean bean ){
		ConnectionSource conSource = null;
		boolean result = false;
		try {
			conSource = ORMConnectionManager.getConnection();
			setupDatabase(conSource);
			
			clientDAO.delete(bean);
			
			result = true;
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		
		return result;
	}
public boolean delItemById(int id ) {
		
		ConnectionSource conSource = null;
		boolean result = false;
		try {
		conSource = ORMConnectionManager.getConnection();
		setupDatabase(conSource);
		
		clientDAO.deleteById(id);
		
		result = true;
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		
		return result;
		
	}
	public static int getProgramId() {
		return 1;
	}
	
}
