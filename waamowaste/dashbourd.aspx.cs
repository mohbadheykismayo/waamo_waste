using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace waamowaste
{
    public partial class dashbourd : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static object GetPaymentData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            SELECT 
                CASE 
                    WHEN PaymentStatus.[Month] = 1 THEN 'Jan'
                    WHEN PaymentStatus.[Month] = 2 THEN 'Feb'
                    WHEN PaymentStatus.[Month] = 3 THEN 'Mar'
                    WHEN PaymentStatus.[Month] = 4 THEN 'Apr'
                    WHEN PaymentStatus.[Month] = 5 THEN 'May'
                    WHEN PaymentStatus.[Month] = 6 THEN 'Jun'
                    WHEN PaymentStatus.[Month] = 7 THEN 'Jul'
                    WHEN PaymentStatus.[Month] = 8 THEN 'Aug'
                    WHEN PaymentStatus.[Month] = 9 THEN 'Sep'
                    WHEN PaymentStatus.[Month] = 10 THEN 'Oct'
                    WHEN PaymentStatus.[Month] = 11 THEN 'Nov'
                    WHEN PaymentStatus.[Month] = 12 THEN 'Dec'
                END + ', ' + CAST(PaymentStatus.[Year] AS VARCHAR(4)) AS [MonthYear],
                SUM(PaymentStatus.[paidamount]) AS TotalAmountPerMonth
            FROM 
                [PaymentStatus]
            INNER JOIN 
                Houses ON PaymentStatus.HouseID = Houses.HouseID
            WHERE 
                PaymentStatus.HasPaid = 1 
                AND Houses.IsActive = 1 
           
            GROUP BY 
                PaymentStatus.[Month],
                PaymentStatus.[Year]
            HAVING 
                SUM(PaymentStatus.[paidamount]) > 0";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            // Convert DataTable to JSON object
            var data = dt.AsEnumerable()
                .Select(row => new {
                    MonthYear = row.Field<string>("MonthYear"),
                    TotalAmountPerMonth = row.Field<decimal>("TotalAmountPerMonth")
                }).ToList();

            return data;
        }





        [WebMethod]
        public static int users()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "select count(*) from Employees where IsActive = 1", con);

                int totalRecords = Convert.ToInt32(cmd.ExecuteScalar());
                return totalRecords;
            }
        }

        [WebMethod]
        public static int houses()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "select count(*) from Houses where IsActive = 1", con);

                int totalRecords = Convert.ToInt32(cmd.ExecuteScalar());
                return totalRecords;
            }
        }

    }
}