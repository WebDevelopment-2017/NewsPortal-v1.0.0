package control;

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

/**
 * Servlet implementation class MessageGet
 */
@WebServlet("/MessageGet")
public class MessageGet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		con=Myconnection.getConncetion();
		try
		{
			StringBuilder sb=new StringBuilder();
			BufferedReader br=request.getReader();
			String temp;
			while((temp=br.readLine())!=null)
			{
				sb.append(temp);
			}
			JSONParser parse=new JSONParser();
			Object obj=parse.parse(sb.toString());
			JSONObject jobj=(JSONObject)obj;
			int userId=Integer.parseInt(jobj.get("userId").toString());
			int touserId=Integer.parseInt(jobj.get("touserId").toString());
			ps=con.prepareStatement("SELECT * FROM message WHERE (userId=? AND touserId=?) or (userId=? AND touserId=?) ORDER BY timeinterval");
			ps.setInt(1,userId);
			ps.setInt(2,touserId);
			ps.setInt(3,touserId);
			ps.setInt(4,userId);
			rs=ps.executeQuery();
			PrintWriter pw=response.getWriter();
			String data="{\"myrecords\":[";
			while(rs.next())
			{
				data=data+"{\"id1\":\""+rs.getInt(2)+"\",\"id2\":\""+rs.getInt(3)+"\",\"text\":\""+rs.getString(4)+"\"},";
			}
			data=data+"{}]}";
			pw.println(data);
		}
		catch(ParseException | SQLException e)
		{
			
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
				
			}
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}

}
