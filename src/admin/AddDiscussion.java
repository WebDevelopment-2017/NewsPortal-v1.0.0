/**
 * AddDiscussion
 * Objective
 * 1 Add Discussion to discussion table
 * 2 Return 0 or 1 to addDiscussion.jsp as url parameter
 * Function Used
 * 1 saveData(String topic,String description,int category,String date,int adminId);
 * Imported Class
 * 1 connection.Myconnection
 * Author : Satya Prakash Nandy
 * Date   : 31-10-2017
 */
package admin;
//---------------------- Importing All The Packages ----------------------
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection;

import connection.Myconnection;
//------------------------------------------------------------------------
@WebServlet("/AddDiscussion")
public class AddDiscussion extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		PrintWriter pw = response.getWriter();
		pw.println("Please wait a minute ....");
		
		//================ Initializing Variables ================
		String topic = request.getParameter("topic");
		String description = request.getParameter("description");
		int category = Integer.parseInt(request.getParameter("category"));
		String date = request.getParameter("year")+"-"+request.getParameter("month")+"-"+request.getParameter("day");
		int adminId = Integer.parseInt(request.getParameter("adminId"));
		//=======================================================
		
		if(AddDiscussion.saveData(topic, description, category, date, adminId)!=0)
		{
			response.sendRedirect("addDiscussion.jsp?flag=1");
		}
		else
		{
			response.sendRedirect("addDiscussion.jsp?flag=0");
		}
	}
	public static int saveData(String topic,String description,int category,String date,int adminId)
	{
		//================ Initializing Variables ================
		Connection con=null;
		PreparedStatement ps=null;
		int result=0;
		//=======================================================
		
		try
		{
			con = Myconnection.getConncetion();
			String sql = "INSERT INTO discussion VALUES(null,?,?,?,?,?)";
			ps = con.prepareStatement(sql);
			ps.setString(1,topic);
			ps.setString(2,description);
			ps.setInt(3,category);
			ps.setDate(4,java.sql.Date.valueOf(date));
			ps.setInt(5,adminId);
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
				return 0;
			}
		}
		return result;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
