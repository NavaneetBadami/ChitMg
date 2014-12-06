package com.riseon.chitfund.services;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class DBProperties 
{
	public Properties getDataBaseDetails()  // get properties file content.
	{
		InputStream fin=getClass().getResourceAsStream("/com/riseon/chitfund/services/DBdetails.properties"); //path of property file.
		Properties DbProp= new Properties();
		try 
		{
			DbProp.load(fin );
		}
		catch (IOException e) 
		{
			System.out.println(e.getMessage());
		}
		return DbProp;
	}
}
