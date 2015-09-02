package com.urbau.feeders;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.support.ConnectionSource;
import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ClientBean;
import com.urbau.beans.ClientTypeBean;
import com.urbau.beans.CountryBean;
import com.urbau.beans.SellerBean;
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
		bean.setTipo_cliente(new ClientTypeBean());
		bean.setSeller( new SellerBean());
		
		
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
