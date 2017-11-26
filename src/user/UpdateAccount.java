package user;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import connection.Myconnection;
@WebServlet("/UpdateAccount")
public class UpdateAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sb = new StringBuilder();
		BufferedReader br = request.getReader();
		String temp = null;
		while((temp=br.readLine())!=null)
		{
			sb.append(temp);
		}
		JSONParser Parse = new JSONParser();
		try 
		{
			Object obj = Parse.parse(sb.toString());
			JSONObject myjson = (JSONObject)obj;
			String name = myjson.get("name").toString();
			String gender = myjson.get("gender").toString();
			String email = myjson.get("email").toString();
			int id = Integer.parseInt(myjson.get("id").toString());
			int result=UpdateAccount.UpdateData(name, gender, email, id);
			JSONObject myjson_send=new JSONObject();
			myjson_send.put("result",result);
			PrintWriter pw=response.getWriter();
			pw.println(myjson_send);
		} 
		catch (ParseException e) 
		{
			e.printStackTrace();
		}
	}
	protected static int UpdateData(String name,String gender,String email,int id)
	{
		Connection con = null;
		PreparedStatement ps = null;
		int result=0;
		try
		{
			con=Myconnection.getConncetion();
			String sql = "UPDATE user SET userName=?,userGender=?,userEmail=? WHERE userId=?";
			ps=con.prepareStatement(sql);
			ps.setString(1,name);
			ps.setString(2,gender);
			ps.setString(3,email);
			ps.setInt(4,id);
			result = ps.executeUpdate();
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return result;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
