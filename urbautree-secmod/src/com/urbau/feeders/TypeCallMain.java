package com.urbau.feeders;

import java.util.ArrayList;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;
import com.urbau._abstract.AbstractMain;
import com.urbau.beans.TypeCallBean;
import com.urbau.db.ORMConnectionManager;

public class TypeCallMain extends AbstractMain {
	private Dao<TypeCallBean, Integer> typeCallDAO;
	
	public ArrayList<TypeCallBean> getItems() {
		ArrayList<TypeCallBean> list = new ArrayList<TypeCallBean>();
		ConnectionSource conSource = null;
		try {
		conSource = ORMConnectionManager.getConnection();
		
		setupDatabase(conSource);
		list = (ArrayList<TypeCallBean>) typeCallDAO.queryForAll();
		 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		return list;
	}
	
	
	public TypeCallBean getItem(int id ) {
		
		if(id<0) {
			return getBlankBean();
		}
		
		ConnectionSource conSource = null;
		TypeCallBean tpc = getBlankBean();
		try {
			conSource = ORMConnectionManager.getConnection();
			setupDatabase(conSource);
		
			tpc = typeCallDAO.queryForId(id);
			
			
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
			return tpc;
		
		
	}

	
	public boolean addItem( TypeCallBean bean ) {
		ConnectionSource conSource = null;
		boolean result = false;
		try {
		conSource = ORMConnectionManager.getConnection();
		setupDatabase(conSource);
		
		typeCallDAO.create(bean);
		typeCallDAO.update(bean);
		result = true;
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		
		return result;
		
	}
	

	public boolean modItem (TypeCallBean bean ) { 
		ConnectionSource conSource = null;
		boolean result = false;
		try {
		conSource = ORMConnectionManager.getConnection();
		setupDatabase(conSource);
		
		typeCallDAO.update(bean);
		result = true;
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ORMConnectionManager.close(conSource);
		}
		
		return result;
		
	}
	

	public boolean delItem (TypeCallBean bean ) {
		
		ConnectionSource conSource = null;
		boolean result = false;
		try {
			conSource = ORMConnectionManager.getConnection();
			setupDatabase(conSource);
			
			typeCallDAO.delete(bean);
			
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
		
		typeCallDAO.deleteById(id);
		
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
	public TypeCallBean getBlankBean(){
		TypeCallBean bean = new TypeCallBean();
		bean.setType("");
		return bean;
	}
	private void setupDatabase(ConnectionSource connectionSource) throws Exception {
		typeCallDAO = DaoManager.createDao(connectionSource, TypeCallBean.class);
		TableUtils.createTableIfNotExists(connectionSource, TypeCallBean.class);
	}
	
}
