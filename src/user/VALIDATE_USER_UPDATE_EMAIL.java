package user;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import connection.Myconnection;
@WebServlet("/VALIDATE_USER_UPDATE_EMAIL")
public class VALIDATE_USER_UPDATE_EMAIL extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		StringBuilder sb = new StringBuilder();
		BufferedReader br = request.getReader();
		String temp = null;
		while((temp = br.readLine())!=null)
		{
			sb.append(temp);
		}
		JSONParser Parse = new JSONParser();
		try 
		{
			Object obj = Parse.parse(sb.toString());
			JSONObject myjsonObj = (JSONObject)obj;
			String email = myjsonObj.get("email").toString();
			int id = Integer.parseInt(myjsonObj.get("id").toString());
			int result=VALIDATE_USER_UPDATE_EMAIL.getEmailCount(email,id);
			JSONObject json_email_count = new JSONObject();
			json_email_count.put("number",result);
			PrintWriter pw = response.getWriter();
			pw.println(json_email_count);
		} catch (ParseException e) 
		{
			e.printStackTrace();
		}
		
	}
	protected static int getEmailCount(String email,int id)
	{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rst = null;
		int count=0;
		try
		{
			con = Myconnection.getConncetion();
			String sql = "SELECT COUNT(*) AS NUMBER FROM user WHERE userEmail=? AND userId NOT IN( id )";
			sql = sql.replace("id",id+"");
			ps = con.prepareStatement(sql);
			ps.setString(1,email);
			rst = ps.executeQuery();
			while(rst.next())
			{
				count = rst.getInt("NUMBER");
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if(rst!=null)
				{
					rst.close();
				}
				if(con!=null)
				{
					con.close();
				}
			}
			catch(SQLException e)
			{
				e.printStackTrace();
			}
		}
		return count;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
