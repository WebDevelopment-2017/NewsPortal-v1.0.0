package admin;

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
import connection.Myconnection;

@WebServlet("/DeleteDiscussion")
public class DeleteDiscussion extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		PrintWriter pw=response.getWriter();
		pw.println("Please Wait .....");
		int id = Integer.parseInt(request.getParameter("id"));
		int result = DeleteDiscussion.deletePost(id);
		response.sendRedirect("adminAllDiscussion.jsp?flag_Delete="+result);
	}
	public static int deletePost(int id)
	{
		Connection con=null;
		PreparedStatement ps=null;
		int result=0;
		try
		{
			con = Myconnection.getConncetion();
			String sql = "DELETE FROM discussion WHERE discussionId=?";
			ps = con.prepareStatement(sql);
			ps.setInt(1,id);
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
}
