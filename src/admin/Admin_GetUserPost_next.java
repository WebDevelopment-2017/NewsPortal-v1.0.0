package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.Myconnection;
import post.POST_BEAN;

@WebServlet("/Admin_GetUserPost_next")
public class Admin_GetUserPost_next extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int categoryId=Integer.parseInt(request.getParameter("categoryId"));
		List<POST_BEAN> mylist=new ArrayList<POST_BEAN>();
		mylist=getPostList(categoryId);
		request.setAttribute("mylist",mylist);
		request.getRequestDispatcher("adminDiverification.jsp").include(request,response);
	}
	protected static List<POST_BEAN> getPostList(int id)
	{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rst=null;
		List<POST_BEAN> mylist=new ArrayList<POST_BEAN>();
		try
		{
			con=Myconnection.getConncetion();
			String sql="SELECT * FROM userpost WHERE categoryId=? AND postId IN (SELECT postId FROM verifyPost) ORDER BY date DESC";
			ps=con.prepareStatement(sql);
			ps.setInt(1,id);
			rst=ps.executeQuery();	
			while(rst.next())
			{
				POST_BEAN obj=new POST_BEAN();
				obj.setPostId(rst.getInt("postId"));
				obj.setAdminId(rst.getInt("userId"));
				obj.setName(rst.getString("postName"));
				obj.setBody(rst.getString("postBody"));
				obj.setWork(rst.getString("postWork"));
				obj.setCategoryId(rst.getInt("categoryId"));
				mylist.add(obj);
			}
		}
		catch(SQLException e)
		{
			e.printStackTrace();
		}
		return mylist;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
