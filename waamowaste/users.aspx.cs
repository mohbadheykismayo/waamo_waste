























































































































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
        public static string saveusers(string username, string pass, string userrole, string isActive, string fullname, string number, string salary, string date , string position)
        {
            try
            {
                // Parse the date string to DateTime
                DateTime parsedDate = DateTime.Parse(date);

                // Your connection string to the SQL Server database
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(cs))
                {
                    // Open the connection
                    conn.Open();

                    // Start a SQL transaction to ensure atomicity
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        // Insert into Houses table
                        string houseInsertQuery = @"
                    INSERT INTO Users (Username, PasswordHash, UserRole)
                    VALUES (@Username, @PasswordHash,  @UserRole);
                    SELECT SCOPE_IDENTITY();"; // To retrieve the new HouseID

                        using (SqlCommand cmd = new SqlCommand(houseInsertQuery, conn, transaction))
                        {
                            // Add parameters to prevent SQL injection
                            cmd.Parameters.AddWithValue("@Username", username);
                            cmd.Parameters.AddWithValue("@PasswordHash", pass);
                            cmd.Parameters.AddWithValue("@UserRole", userrole);
              
             

                            // Execute the query and get the new HouseID
                            int userid = Convert.ToInt32(cmd.ExecuteScalar());

                            // Insert into PaymentStatus table
                            string paymentStatusInsertQuery = @"
                        INSERT INTO Employees ( UserID, fullname, Position, Salary ,date , isactive ,number)
                        VALUES (@UserID, @fullname, @Position, @Salary ,@date,@isActive, @number)";

                            using (SqlCommand paymentCmd = new SqlCommand(paymentStatusInsertQuery, conn, transaction))
                            {
                                // Add the required parameters
                                paymentCmd.Parameters.AddWithValue("@fullname", fullname);
                                paymentCmd.Parameters.AddWithValue("@isActive", isActive);
                                paymentCmd.Parameters.AddWithValue("@number", number);
                                paymentCmd.Parameters.AddWithValue("@salary", salary);
                                paymentCmd.Parameters.AddWithValue("@date", date);
                                paymentCmd.Parameters.AddWithValue("@UserID", userid);
                                paymentCmd.Parameters.AddWithValue("@Position",position);
                                

                                // Execute PaymentStatus insertion
                                paymentCmd.ExecuteNonQuery();
                            }

                            // Commit the transaction if both insertions succeed
                            transaction.Commit();
                        }

                        return "Success";
                    }
                    catch (Exception ex)
                    {
                        // Rollback the transaction in case of any error
                        transaction.Rollback();
                        // Log the error details
                        return "Error during transaction: " + ex.Message;
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the parsing or general exception
                return "Error: " + ex.Message;
            }
        }










        [WebMethod]
        public static string updateusers(Userdata userdata)
        {

            bool isActive = userdata.isActive;
            try
            {
                // Connection string from Web.config
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

                // SQL query for updating the house details
                string query = @"
                UPDATE Employees
                SET 
                    Position = @Position,
                    Salary = @Salary,
                  IsActive = @isActive,
                    fullname = @fullname,
                    number = @number,
            
                    date = @date




                WHERE 
                    EmployeeID = @id";









                using (SqlConnection connection = new SqlConnection(cs))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Adding parameters to prevent SQL injection
                        command.Parameters.AddWithValue("@Position", userdata.position);
                        command.Parameters.AddWithValue("@Salary", userdata.salary);
                      command.Parameters.AddWithValue("@isActive", userdata.isActive);
                        command.Parameters.AddWithValue("@fullname", userdata.fullname);
                        command.Parameters.AddWithValue("@number", userdata.number);
           
                        command.Parameters.AddWithValue("@date", userdata.date);
                        command.Parameters.AddWithValue("@id", userdata.id);
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        // Check if the update was successful
                        if (rowsAffected > 0)
                        {
                            return "Success";
                        }
                        else
                        {
                            return "Failed to update the house details.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error (you can implement your own logging mechanism here)
                return "Error: " + ex.Message;
            }
        }

        // Define a C# class for the house data
        public class Userdata
        {
            public string salary { get; set; }
           public bool isActive { get; set; }
            public string fullname { get; set; }
            public string number { get; set; }
            public string position { get; set; }
            public string date { get; set; }
            public string id { get; set; }






        }




















































        [WebMethod]
        public static string updateusername(Userdetails userdetails)
        {


            try
            {
                // Connection string from Web.config
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

                // SQL query for updating the house details
                string query = @"
                UPDATE Users
                SET 
                    Username = @Username,
                    PasswordHash = @PasswordHash,
                  UserRole = @UserRole
             

                WHERE 
                    UserID = @id";







                using (SqlConnection connection = new SqlConnection(cs))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Adding parameters to prevent SQL injection
                        command.Parameters.AddWithValue("@Username", userdetails.username);
                        command.Parameters.AddWithValue("@PasswordHash", userdetails.pass);
                        command.Parameters.AddWithValue("@UserRole", userdetails.userole);

                        command.Parameters.AddWithValue("@id", userdetails.id);
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        // Check if the update was successful
                        if (rowsAffected > 0)
                        {
                            return "Success";
                        }
                        else
                        {
                            return "Failed to update the house details.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error (you can implement your own logging mechanism here)
                return "Error: " + ex.Message;
            }
        }

        // Define a C# class for the house data
        public class Userdetails
        {
        
            public string userole { get; set; }
            public string pass { get; set; }
            public string username { get; set; }
            public string id { get; set; }






        }






























































































        [WebMethod]
        public static string kudarxafad(string waxda, string id)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Insert into patient table
                    string catquery = "INSERT INTO EmployeeAssignments (SubNeighborhoodID, EmployeeID, AssignmentDate) VALUES (@waxda, @id, getdate());";

                    using (SqlCommand cmd = new SqlCommand(catquery, con))
                    {
                        cmd.Parameters.AddWithValue("@waxda", waxda);
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();

                    }
                }

                return "true";
            }
            catch (Exception ex)
            {
                // Handle exceptions and return the error message
                return "Error in submitdata method: " + ex.Message;
            }
        }











        [WebMethod]
        public static string deletexafadashaqo(string id)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Delete job from jobs table
                    string jobQuery = "DELETE FROM EmployeeAssignments WHERE AssignmentID = @id";

                    using (SqlCommand cmd = new SqlCommand(jobQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);

                        cmd.ExecuteNonQuery();
                    }
                }

                return "true";
            }
            catch (Exception ex)
            {
                // Handle exceptions
                throw new Exception("Error deleting job", ex);
            }
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
            public string isactive;
            public string number;

            public string date;
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
                    field.isactive = dr["isactive"].ToString();
                    field.number = dr["number"].ToString();
                    field.date = dr["date"].ToString();

                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }

        [WebMethod]
        public static userda[] datadisplay1(string id)
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
                    field.isactive = dr["isactive"].ToString();
                    field.number = dr["number"].ToString();
                    field.date = dr["date"].ToString();
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