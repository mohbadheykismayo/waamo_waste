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

namespace waamowaste
{
    public partial class crudneighbourhoods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        



        [WebMethod]
        public static string deletewaax(string id)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Delete job from jobs table
                    string jobQuery = "DELETE FROM SubNeighborhoods WHERE SubNeighborhoodID = @id";

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
        public static string editwax(string id, string wax, string xafad)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Update jobs table
                    string jobQuery = "UPDATE [SubNeighborhoods] SET " +
                          "[SubNeighborhoodName] = @wax ," +
                            "[NeighborhoodID] = @xafad" +
                           " WHERE [SubNeighborhoodID] = @id";





                    using (SqlCommand cmd = new SqlCommand(jobQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.Parameters.AddWithValue("@xafad", xafad);
                        cmd.Parameters.AddWithValue("@wax", wax);

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
        public static string addwax(string wax ,string xafad)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Insert into patient table
                    string catquery = "INSERT INTO SubNeighborhoods (SubNeighborhoodName,NeighborhoodID) VALUES (@wax, @xafad);";
                    using (SqlCommand cmd = new SqlCommand(catquery, con))
                    {
                        cmd.Parameters.AddWithValue("@wax", wax);
                        cmd.Parameters.AddWithValue("@xafad", xafad);
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
        public static List<ListItem> getxafad()
        {
            string query = "select * from Neighborhoods";
            string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> customers = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(new ListItem
                            {
                                Value = sdr["NeighborhoodID"].ToString(),
                                Text = sdr["NeighborhoodName"].ToString()
                            });
                        }
                    }
                    con.Close();
                    return customers;
                }
            }
        }









        [WebMethod]
        public static string deletexafad(string id)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Delete job from jobs table
                    string jobQuery = "DELETE FROM Neighborhoods WHERE NeighborhoodID = @id";

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
        public static string editxafad(string id, string catname)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Update jobs table
                    string jobQuery = "UPDATE [Neighborhoods] SET " +
                          "[NeighborhoodName] = @CategoryName" +
                           " WHERE [NeighborhoodID] = @id";





                    using (SqlCommand cmd = new SqlCommand(jobQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.Parameters.AddWithValue("@CategoryName", catname);


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
        public static string addxaafad(string catname)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Insert into patient table
                    string catquery = "INSERT INTO Neighborhoods (NeighborhoodName) VALUES (@name);";
                    using (SqlCommand cmd = new SqlCommand(catquery, con))
                    {
                        cmd.Parameters.AddWithValue("@name", catname);

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



        public class xaafada
        {
            public string magaca;
            public string id;
        }
        [WebMethod]
        public static xaafada[] datadisplay()
        {
            List<xaafada> details = new List<xaafada>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
      select * from Neighborhoods
        ", con);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    xaafada field = new xaafada();
                    field.id = dr["NeighborhoodID"].ToString();

                    field.magaca = dr["NeighborhoodName"].ToString();


                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }













        public class waaxaha
        {
            public string xafada;
            public string waaxdi;
            public string SubNeighborhoodID;
        }
        [WebMethod]
        public static waaxaha[] waax()
        {
            List<waaxaha> details = new List<waaxaha>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
  
  select * from Neighborhoods
  inner join SubNeighborhoods on Neighborhoods.NeighborhoodID = SubNeighborhoods.NeighborhoodID
        ", con);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    waaxaha field = new waaxaha();
                    field.waaxdi = dr["SubNeighborhoodName"].ToString();

                    field.SubNeighborhoodID = dr["SubNeighborhoodID"].ToString();
                    field.xafada = dr["NeighborhoodName"].ToString();
                    
                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }



    }
}