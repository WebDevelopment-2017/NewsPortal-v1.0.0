package user;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import control.Myconnection;
public class UpdateClass 
{
	public int Post(Post obj)
	{
		Connection con=null;
		int flag=0;
		con=Myconnection.getConncetion();
		try 
		{
			PreparedStatement ps=con.prepareStatement("UPDATE userpost SET userId=?,postName=?,categoryId=?,postBody=?,postWork=? WHERE postId=?");
			ps.setInt(1,obj.getUserId());
			ps.setString(2,obj.getName());
			ps.setInt(3,obj.getCategory());
			ps.setString(4,obj.getBody());
			ps.setString(5,obj.getAboutWork());
			ps.setInt(6,obj.getPostId());
			flag=ps.executeUpdate();
			ps.close();
			if(obj.getImage1().available()>1)
			{
				ps=con.prepareStatement("UPDATE userpost SET image1=? WHERE postId=?");
				ps.setBlob(1,obj.getImage1());
				ps.setInt(2,obj.getPostId());
				flag=ps.executeUpdate();
				ps.close();
			}
			if(obj.getImage2().available()>1)
			{
				ps=con.prepareStatement("UPDATE userpost SET image2=? WHERE postId=?");
				ps.setBlob(1,obj.getImage2());
				ps.setInt(2,obj.getPostId());
				flag=ps.executeUpdate();
				ps.close();
			}
			if(obj.getVideo1().available()>1)
			{
				ps=con.prepareStatement("UPDATE userpost SET video=? WHERE postId=?");
				ps.setBlob(1,obj.getVideo1());
				ps.setInt(2,obj.getPostId());
				flag=ps.executeUpdate();
				ps.close();
			}
		} 
		catch (SQLException | IOException e) 
		{
			System.out.println("Something Went Wrong"+e);
		}
		return flag;
	}
}
