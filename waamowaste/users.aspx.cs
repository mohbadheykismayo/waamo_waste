using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static waamowaste.users;

namespace waamowaste
{
    public partial class users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string badalxafad(string id, string waxda)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Update jobs table
                    string jobQuery = "UPDATE [EmployeeAssignments] SET " +
                          "[SubNeighborhoodID] = @waxda " +

                           " WHERE [AssignmentID] = @id";





                    using (SqlCommand cmd = new SqlCommand(jobQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.Parameters.AddWithValue("@waxda", waxda);
                     

                        cmd.ExecuteNonQuery();
                    }
                }

                return "true";
            }
            catch (Exception ex)
            {
                // Handle exceptions
                return "Error in updating method: " + ex.Message;
            }
        }



        [WebMethod]
        public static List<ListItem> GetWax(string search)
        {
            string query = "SELECT SubNeighborhoodID, SubNeighborhoodName FROM SubNeighborhoods WHERE NeighborhoodID = @search";
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            List<ListItem> subNeighborhoods = new List<ListItem>();

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@search", SqlDbType.NVarChar).Value = search;  // Specify the data type

                    con.Open();

                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            subNeighborhoods.Add(new ListItem
                            {
                                Value = sdr["SubNeighborhoodID"].ToString(),
                                Text = sdr["SubNeighborhoodName"].ToString()
                            });
                        }
                    }
                }
            }

            return subNeighborhoods;
        }



        public class userda
        {
            public string Username;
            public string PasswordHash;
            public string UserRole;
            public string fullname;
     
            public string Position;
            public string Salary;
            public string EmployeeID;
            public string UserID;
            public string SubNeighborhoodName;
            public string NeighborhoodName;
            public string AssignmentDate;
            public string AssignmentID;
            
        }
        [WebMethod]
        public static userda[] datadisplay()
        {
            List<userda> details = new List<userda>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
      select * from users
  inner join Employees on Users.UserID = Employees.UserID
        ", con);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    userda field = new userda();
                    field.Username = dr["Username"].ToString();

                    field.PasswordHash = dr["PasswordHash"].ToString();
                    field.UserRole = dr["UserRole"].ToString();

                    field.fullname = dr["fullname"].ToString();

                    field.Position = dr["Position"].ToString();
                    field.Salary = dr["Salary"].ToString();

                    field.EmployeeID = dr["EmployeeID"].ToString();
                    field.UserID = dr["UserID"].ToString();
                    
                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }

        [WebMethod]
        public static userda[] datadisplay1( string id)
        {
            List<userda> details = new List<userda>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
        select * from users
  inner join Employees on Users.UserID = Employees.UserID
  where Employees.EmployeeID = @id
        ", con);
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    userda field = new userda();
                    field.Username = dr["Username"].ToString();

                    field.PasswordHash = dr["PasswordHash"].ToString();
                    field.UserRole = dr["UserRole"].ToString();

                    field.fullname = dr["fullname"].ToString();

                    field.Position = dr["Position"].ToString();
                    field.Salary = dr["Salary"].ToString();

                    field.EmployeeID = dr["EmployeeID"].ToString();
                    field.UserID = dr["UserID"].ToString();

                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }

        [WebMethod]
        public static userda[] datadisplay2(string id)
        {
            List<userda> details = new List<userda>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
      SELECT DISTINCT 
    Neighborhoods.NeighborhoodName, 
    SubNeighborhoods.SubNeighborhoodName, 
    Employees.Position, 
    EmployeeAssignments.AssignmentDate,
   EmployeeAssignments.AssignmentID
FROM Neighborhoods
INNER JOIN SubNeighborhoods ON Neighborhoods.NeighborhoodID = SubNeighborhoods.NeighborhoodID
INNER JOIN EmployeeAssignments ON SubNeighborhoods.SubNeighborhoodID = EmployeeAssignments.SubNeighborhoodID
INNER JOIN Employees ON EmployeeAssignments.EmployeeID = Employees.EmployeeID
WHERE Employees.EmployeeID = @id;

        ", con);
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    userda field = new userda();
                    field.NeighborhoodName = dr["NeighborhoodName"].ToString();

                    field.SubNeighborhoodName = dr["SubNeighborhoodName"].ToString();
                    field.AssignmentDate = dr["AssignmentDate"].ToString();
                    field.AssignmentID = dr["AssignmentID"].ToString();
                    

                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }

    }
}