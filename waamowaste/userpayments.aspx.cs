using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static waamowaste.houses;

namespace waamowaste
{
    public partial class userpayments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static house[] datadisplay1(string id)
        {
            List<house> details = new List<house>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  

      select * from Houses
inner join SubNeighborhoods on Houses.SubNeighborhoodID = SubNeighborhoods.SubNeighborhoodID
inner join Neighborhoods on SubNeighborhoods.NeighborhoodID = Neighborhoods.NeighborhoodID
where Houses.HouseNumber = @id
        ", con);
                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    house field = new house();
                    field.NeighborhoodName = dr["NeighborhoodName"].ToString();

                    field.SubNeighborhoodName = dr["SubNeighborhoodName"].ToString();
                    field.HouseID = dr["HouseID"].ToString();

                    field.HouseNumber = dr["HouseNumber"].ToString();

                    field.IsActive = dr["IsActive"].ToString();
                    field.fullname = dr["fullname"].ToString();
                    field.number = dr["number"].ToString();

                    field.GPSLatitude = dr["GPSLatitude"].ToString();
                    field.GPSLongitude = dr["GPSLongitude"].ToString();
                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }















        [WebMethod]
        public static fclass[] financedisplay(string id)
        {
            List<fclass> details = new List<fclass>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  

 
SELECT TOP (1000) 
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
    CASE 
        WHEN PaymentStatus.[HasPaid] = 1 THEN 'Paid'
        ELSE 'Not Paid'
    END AS [PaymentStatus],

    PaymentStatus.[paidamount]
  
FROM [waamo_waste].[dbo].[PaymentStatus]
INNER JOIN Houses ON PaymentStatus.HouseID = Houses.HouseID
INNER JOIN SubNeighborhoods ON Houses.SubNeighborhoodID = SubNeighborhoods.SubNeighborhoodID
INNER JOIN Neighborhoods ON SubNeighborhoods.NeighborhoodID = Neighborhoods.NeighborhoodID
WHERE Houses.HouseNumber = @id;

        ", con);
                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    fclass field = new fclass();
                    field.PaymentStatus = dr["PaymentStatus"].ToString();

                    field.MonthYear = dr["MonthYear"].ToString();
                    field.paidamount = dr["paidamount"].ToString();


                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }

    }
}