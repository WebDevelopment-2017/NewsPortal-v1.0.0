package admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import connection.Myconnection;

public class AdminUpdatePostClass
{
	public int UpdatePost(AdminAddPostBean obj)
	{
		int result=0;
		Connection con=null;
		PreparedStatement ps=null;
		try
		{
			con = Myconnection.getConncetion();
			String sql = "UPDATE adminpost SET admin_postName=?,"
					+ "admin_postcategoryId=?,"
					+ "admin_postBody=?,"
					+ "admin_postWork=?"
					+ " WHERE admin_postId=?";
			ps = con.prepareStatement(sql);
			ps.setString(1,obj.getName());
			ps.setInt(2,obj.getCategoryId());
			ps.setString(3,obj.getBody());
			ps.setString(4,obj.getWork());
			ps.setInt(5,obj.getPostId());
			result=ps.executeUpdate();
			ps.close();
			if(obj.getImage1().available()>0)
			{
				ps=con.prepareStatement("UPDATE adminpost SET admin_postImagePrimary=? WHERE admin_postId=?");
				ps.setBlob(1,obj.getImage1());
				ps.setInt(2,obj.getPostId());
				result=ps.executeUpdate();
				ps.close();
			}
			if(obj.getImage2().available()>0)
			{
				ps=con.prepareStatement("UPDATE adminpost SET admin_postImageSecondary=? WHERE admin_postId=?");
				ps.setBlob(1,obj.getImage2());
				ps.setInt(2,obj.getPostId());
				result=ps.executeUpdate();
				ps.close();
			}
			if(obj.getVideo1().available()>0)
			{
				ps=con.prepareStatement("UPDATE adminpost SET admin_postVideo=? WHERE admin_postId=?");
				ps.setBlob(1,obj.getVideo1());
				ps.setInt(2,obj.getPostId());
				result=ps.executeUpdate();
				ps.close();
			}
			
		}
		catch(SQLException | IOException e)
		{
			e.printStackTrace();
		}
		finally
		{
			try
			{
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
