package user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import connection.Myconnection;
public class GetUserName 
{
	public static String getUserName(int id)
	{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rst=null;
		String name=null;
		try
		{
			con=Myconnection.getConncetion();
			String sql="SELECT userName FROM user WHERE userId=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1,id);
			rst=ps.executeQuery();
			while(rst.next())
			{
				name=rst.getString("userName");
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
		return name;
	}
}
