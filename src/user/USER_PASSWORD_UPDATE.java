package user;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

@WebServlet("/USER_PASSWORD_UPDATE")
public class USER_PASSWORD_UPDATE extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			String password=myjsonObj.get("password").toString();
			int result=UpdatePassword(id,password);
			JSONObject json_result = new JSONObject();
			json_result.put("result",result);
			PrintWriter pw = response.getWriter();
			pw.println(json_result);
		}
		catch(ParseException e)
		{
			e.printStackTrace();
		}
	}

	protected static int UpdatePassword(int id,String password)
	{
		Connection con = null;
		PreparedStatement ps = null;
		int result = 0;
		try
		{
			con = Myconnection.getConncetion();
			String sql = "UPDATE user SET userPassword=? WHERE userId=?";
			ps = con.prepareStatement(sql);
			ps.setString(1,password);
			ps.setInt(2,id);
			result = ps.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
				if(ps!=null)
				{
					ps.close();
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
		return result;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
