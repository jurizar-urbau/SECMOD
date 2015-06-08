package com.urbau.feeders;

import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.jdbc.JdbcConnectionSource;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;
import com.urbau.beans.Account;;

public class AccountMain {

	private static final String DATABASE_URL = "jdbc:mysql://127.0.0.1/urbausec";
	private static final String USER = "urbau";
	private static final String PASS = "secmod";
		
	private Dao<Account, Integer> accountDao;
	
	p
	public boolean addItem(Account  account ) throws Exception {
		ConnectionSource connectionSource = null;
		try {
			// create our data-source for the database
			connectionSource = new JdbcConnectionSource(DATABASE_URL,USER,PASS);
			// setup our database and DAOs
			setupDatabase(connectionSource);
			accountDao.create(account);			
			accountDao.update(account);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			connectionSource.close();
			return true;
		}
		
	}
	@SuppressWarnings("finally")
	public ArrayList<Account> getItems() throws Exception{
		ArrayList<Account> ac = new  ArrayList<Account>();
		
		ConnectionSource connectionSource = null;
		try {
			// create our data-source for the database
			connectionSource = new JdbcConnectionSource(DATABASE_URL,USER,PASS);
			// setup our database and DAOs
			setupDatabase(connectionSource);
			// read and write some data
		ac=	(ArrayList<Account>) readWriteData();
		
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// destroy the data source which should close underlying connections
					connectionSource.close();
					return ac;
			}
		
	}
	
	/**
	 * Setup our database and DAOs
	 */
	private void setupDatabase(ConnectionSource connectionSource) throws Exception {

		accountDao = DaoManager.createDao(connectionSource, Account.class);

		// if you need to create the table
		TableUtils.createTableIfNotExists(connectionSource, Account.class);
		
	}
	/**
	 * Read and write some example data.
	 */
	private List<Account> readWriteData() throws Exception {
		// create an instance of Account
		String name = "Jim 2";
		Account account = new Account(name);

		// persist the account object to the database
		accountDao.create(account);
		int id = account.getId();
	//	verifyDb(id, account);

		// assign a password
		account.setPassword("_sec2ret");
		// update the database after changing the object
		accountDao.update(account);
		//verifyDb(id, account);

		// query for all items in the database
		List<Account> accounts = accountDao.queryForAll();
		return accounts;
		
	}
	


}
