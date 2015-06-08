package com.urbau.feeders;

import java.sql.SQLException;
import java.util.ArrayList;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.support.ConnectionSource;
import com.urbau._abstract.AbstractMain;
import com.urbau.beans.CountryBean;
import com.urbau.db.ORMConnectionManager;

public class CountryMain  extends AbstractMain {
	private Dao<CountryBean, Integer> countryDAO;
	ConnectionSource conSource = null ; 
	
	public ArrayList<CountryBean> getItems(){
		ArrayList<CountryBean> list = new ArrayList<CountryBean>();
		
		try { 
			setupDatabase();
			list = (ArrayList<CountryBean>) countryDAO.queryForAll();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			closeCon();
		}
		return list;
	}

	private void setupDatabase() {
		try {
			conSource = ORMConnectionManager.getConnection();
			countryDAO = DaoManager.createDao(conSource	, CountryBean.class);
			
		}catch (SQLException e ) {
			e.printStackTrace();
		}
	}

	public CountryBean getItem(int id) {
		if(id < 0 ) {
			return getBlankBean();
			
		}
		CountryBean cb = getBlankBean();
		setupDatabase();
		try {
			cb = countryDAO.queryForId(id);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
		
		return cb;
		
	}

	public boolean addItem(CountryBean bean ){
		setupDatabase();
		boolean result = false;
		
		try {
			countryDAO.create(bean);
			result = true; 
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			closeCon();
		}
		return result;
	}
	
	public boolean modItem(CountryBean bean) {
		boolean result = false;
		
		try{
			setupDatabase();
			countryDAO.update(bean);
			result = true;
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			ORMConnectionManager.close(conSource);
		}
		return result;
		
		
	}
	
	public boolean delItem(CountryBean bean ) {
		boolean result = false;
		try {
			setupDatabase();
			countryDAO.delete(bean);
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
			countryDAO.deleteById(id);
			result = true;
		}catch (Exception e ) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
		return result;
	}
	private void closeCon() {
		ORMConnectionManager.close(conSource);
	}

	private CountryBean getBlankBean() {
		CountryBean bean = new CountryBean();
		bean.setCountry("");
		return bean;
	}
}
