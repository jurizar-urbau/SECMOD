package com.urbau.feeders;

import java.sql.SQLException;
import java.util.ArrayList;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.urbau._abstract.AbstractMain;
import com.urbau.beans.ClientTypeBean;
import com.urbau.db.ORMConnectionManager;

public class ClientTypeMain extends AbstractMain {
	private Dao<ClientTypeBean, Integer> beanDAO;
	
	
	public ArrayList<ClientTypeBean> getItems( ){
		ArrayList<ClientTypeBean> list = new ArrayList<ClientTypeBean>();

		try { 
			setupDatabase();
			list = (ArrayList<ClientTypeBean>) beanDAO.queryForAll();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeCon();
		}
		return list;
	}
	
	
	public ClientTypeBean getItem( int id ){
		if(id < 0 ) {
			return getBlankBean();
			
		}
		ClientTypeBean cb = getBlankBean();
		setupDatabase();
		try {
			cb = beanDAO.queryForId(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
		
		return cb;
	}
	
	public ClientTypeBean getBlankBean(){
		ClientTypeBean bean = new ClientTypeBean();
		bean.setType("");
		return bean;
	}
	public boolean addItem( ClientTypeBean bean ){
		setupDatabase();
		boolean result = false;
		
		try {
			beanDAO.create(bean);
			result = true; 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeCon();
		}
		return result;
	}
	
	public boolean modItem( ClientTypeBean bean ){
		boolean result = false;
		try{
			setupDatabase();
			beanDAO.update(bean);
			result = true;
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			ORMConnectionManager.close(conSource);
		}
		return result;
	}

	public boolean delItem( ClientTypeBean bean ){
		boolean result = false;
		try {
			setupDatabase();
			beanDAO.delete(bean);
			result = true;
			
		}catch (Exception e ) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
		return result;
	}

	
	public boolean delItemById(int id) {
		boolean result = false;
		try {
			setupDatabase();
			beanDAO.deleteById(id);
			result = true;
		}catch (Exception e ) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
		return result;
	}
	public static int getProgramId() {
		return 1;
	}

	private void setupDatabase() {
		try {
			conSource = ORMConnectionManager.getConnection();
			beanDAO = DaoManager.createDao(conSource	, ClientTypeBean.class);
			
		}catch (SQLException e ) {
			e.printStackTrace();
		}
	}
	
}
