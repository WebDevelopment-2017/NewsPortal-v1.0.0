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


@WebServlet("/SearchFriends")
public class SearchFriends extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		StringBuilder sb=new StringBuilder();
		BufferedReader br=request.getReader();
		PrintWriter pw=response.getWriter();
		String temp=null;
		ResultSet rs=null;
		Connection con=null;
		PreparedStatement ps=null;
		if((temp=br.readLine())!=null)
		{
			sb.append(temp);
		}
		try
		{
			JSONParser Parse=new JSONParser();
			Object object=Parse.parse(sb.toString());
			JSONObject job=(JSONObject)object;
			String mytext=job.get("mytext").toString();
			String myid=job.get("myid").toString();
			con=Myconnection.getConncetion();
			//String query="SELECT userId,userName,userGender,userEmail FROM user WHERE userId NOT IN (SELECT userId2 FROM friendlist WHERE userId1="+myid+") AND userId NOT IN ("+myid+") AND userName LIKE \""+mytext+"%\";";
			String query="SELECT userId,userName,userGender,userEmail FROM user WHERE userId NOT IN (SELECT userId2 FROM friendlist WHERE userId1="+myid+") AND userId NOT IN ("+myid+")";
			ps=con.prepareStatement(query);
			rs=ps.executeQuery();
			String data="{\"myrecords\":[";
			while(rs.next())
			{
				data=data+"{\"id\":\""+rs.getString(1)+"\",\"name\":\""+rs.getString(2)+"\",\"gender\":\""+rs.getString(3)+"\",\"email\":\""+rs.getString(4)+"\"},";
			}
			data=data+"{}]}";
			pw.print(data);
		}
		catch(ParseException | SQLException e)
		{
			pw.print("Error");
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
