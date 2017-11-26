package user;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import connection.Myconnection;

/**
 * Servlet implementation class VALIDATE_USER_UPDATE_PASSWORD
 */
@WebServlet("/VALIDATE_USER_UPDATE_PASSWORD")
public class VALIDATE_USER_UPDATE_PASSWORD extends HttpServlet {
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
			int id = Integer.parseInt(myjsonObj.get("id").toString());
			String password=VALIDATE_USER_UPDATE_PASSWORD.getPassword(id);
			JSONObject json_email_count = new JSONObject();
			json_email_count.put("password",password);
			PrintWriter pw = response.getWriter();
			pw.println(json_email_count);
		} catch (ParseException e) 
		{
			e.printStackTrace();
		}
		
	}
	protected static String getPassword(int id)
	{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rst = null;
		String password="";
		try
		{
			con = Myconnection.getConncetion();
			String sql = "SELECT userPassword AS PASSWORD FROM user WHERE userId=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1,id);
			rst = ps.executeQuery();
			while(rst.next())
			{
				password = rst.getString("PASSWORD");
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
		return password;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
