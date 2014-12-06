package com.riseon.chitfund.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import static com.riseon.chitfund.services.DBConstants.*;

public class ConnectionProvider    //singleton format.
{
	private static final ConnectionProvider  only_one= new ConnectionProvider();
	private Connection con;
	static int count=0;
	private ConnectionProvider()
	{
		try 
		{
			Class.forName(DRIVER);
			Properties propContent=new DBProperties().getDataBaseDetails();  //get the DB properties from DBProperties class.
			con= DriverManager.getConnection(URL,propContent);
			count=count+1;
			System.out.println("Connected " + count);
		}
		catch (ClassNotFoundException e) 
		{
			System.out.println("DRIVER NOT LOADED " + e.getMessage());
			e.printStackTrace();
		} 
		catch (SQLException e) 
		{
			System.out.println("CONNECTION NOT ESTABLISHED " + e.getMessage());
			e.printStackTrace();
		}
	}
	public static ConnectionProvider getObj()  //static factory method.
	{
		return only_one;
	}
	public Connection getCon()
	{
		return con;
	}
}
