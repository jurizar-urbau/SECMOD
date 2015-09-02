package com.urbau.feeders;

import java.sql.SQLException;
import java.util.ArrayList;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.urbau._abstract.AbstractMain;
import com.urbau.beans.SellerBean;
import com.urbau.db.ORMConnectionManager;

public class SellerMain extends AbstractMain {
private Dao<SellerBean, Integer> beanDAO;
	
	
	public ArrayList<SellerBean> getItems( ){
		ArrayList<SellerBean> list = new ArrayList<SellerBean>();

		try { 
			setupDatabase();
			list = (ArrayList<SellerBean>) beanDAO.queryForAll();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeCon();
		}
		return list;
	}
	
	
	public SellerBean getItem( int id ){
		if(id < 0 ) {
			return getBlankBean();
			
		}
		SellerBean cb = getBlankBean();
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
	
	public SellerBean getBlankBean(){
		SellerBean bean = new SellerBean();
		bean.setName("");
		bean.setSurname("");
		bean.setUser("");
		return bean;
	}
	public boolean addItem( SellerBean bean ){
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
	
	public boolean modItem( SellerBean bean ){
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

	public boolean delItem( SellerBean bean ){
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
			beanDAO = DaoManager.createDao(conSource	, SellerBean.class);
			
		}catch (SQLException e ) {
			e.printStackTrace();
		}
	}
	
	
}
