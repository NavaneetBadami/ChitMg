package com.riseon.chitfund.services;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


public class PoolSrv extends HttpServlet 
{
	static DataSource ds=null;
	@Override
	public void init() throws ServletException 
	{
		try
		{
			/*Properties p= new Properties();
			p.put(Context.INITIAL_CONTEXT_FACTORY,"weblogic,jndi.WLINITIALFACTORY");
			p.put(Context.PROVIDER_URL,"http://localhost:3306");*/
			InitialContext ctx=new InitialContext();
			Object obj=ctx.lookup("myjndi");
			ds=(DataSource)obj;
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	@Override
	public void service(HttpServletRequest arg0, HttpServletResponse arg1)throws ServletException, IOException 
	{
		try
		{
			Connection con=ds.getConnection();
			System.out.println("Connected.. " + con);
			Statement stm=con.createStatement();
			ResultSet res=stm.executeQuery("select * from admindetails");
			
			while(res.next())
			{
				String name=res.getString(1);
				System.out.println("Name "  + name);
			}
			con.close();
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
}
