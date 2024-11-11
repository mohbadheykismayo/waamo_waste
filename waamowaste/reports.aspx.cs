using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace waamowaste
{
    public partial class reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetReportData1(string selectedDate)
        {
            try
            {
                // Parse the selectedDate into month and year
                DateTime reportDate = DateTime.Parse(selectedDate);
                string month = reportDate.Month.ToString("D2");  // Month as two digits
                string year = reportDate.Year.ToString();

                // Connection string (update with your actual connection details)
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("GetPaidAmountsBySubNeighborhood14", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add parameters for the stored procedure
                        cmd.Parameters.AddWithValue("@Month", month);
                        cmd.Parameters.AddWithValue("@Year", year);

                        conn.Open();

                        // Execute and retrieve data for the first query
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt1 = new DataTable();
                        da.Fill(dt1);  // This will fill the results from the first query (total paid per sub-neighborhood)

                        // Retrieve the second result set (total paid for the entire month/year)
                        cmd.CommandText = "GetPaidAmountsBySubNeighborhood14";  // Ensure the second query runs properly
                        SqlDataReader reader = cmd.ExecuteReader();

                        DataTable dt2 = new DataTable();
                        if (reader.NextResult())
                        {
                            dt2.Load(reader);  // This will load the result from the second query (total paid for the month/year)
                        }

                        // Combine both DataTables into a JSON object to return to the client-side
                        var result = new
                        {
                            SubNeighborhoods = dt1,
                            TotalUnpaidForMonthYear = dt2
                        };

                        return Newtonsoft.Json.JsonConvert.SerializeObject(result);
                    }
                }
            }
            catch (Exception ex)
            {
                // Return the exact error message to the client
                return Newtonsoft.Json.JsonConvert.SerializeObject(new { error = ex.Message });
            }
        }

        [WebMethod]
        public static string GetReportData(string selectedDate)
        {
            try
            {
                // Parse the selectedDate into month and year
                DateTime reportDate = DateTime.Parse(selectedDate);
                string month = reportDate.Month.ToString("D2");  // Month as two digits
                string year = reportDate.Year.ToString();

                // Connection string (update with your actual connection details)
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    using (SqlCommand cmd = new SqlCommand("GetPaidAmountsBySubNeighborhood3", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        // Add parameters for the stored procedure
                        cmd.Parameters.AddWithValue("@Month", month);
                        cmd.Parameters.AddWithValue("@Year", year);

                        conn.Open();

                        // Execute and retrieve data for the first query
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt1 = new DataTable();
                        da.Fill(dt1);  // This will fill the results from the first query (total paid per sub-neighborhood)

                        // Retrieve the second result set (total paid for the entire month/year)
                        cmd.CommandText = "GetPaidAmountsBySubNeighborhood3";  // Ensure the second query runs properly
                        SqlDataReader reader = cmd.ExecuteReader();

                        DataTable dt2 = new DataTable();
                        if (reader.NextResult())
                        {
                            dt2.Load(reader);  // This will load the result from the second query (total paid for the month/year)
                        }

                        // Combine both DataTables into a JSON object to return to the client-side
                        var result = new
                        {
                            SubNeighborhoods = dt1,
                            TotalPaidForMonthYear = dt2
                        };

                        return Newtonsoft.Json.JsonConvert.SerializeObject(result);
                    }
                }
            }
            catch (Exception ex)
            {
                // Return the exact error message to the client
                return Newtonsoft.Json.JsonConvert.SerializeObject(new { error = ex.Message });
            }
        }
    }
}