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
using static waamowaste.users;

namespace waamowaste
{
    public partial class payments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public class dis
        {
            public string TotalDifference;
            public string TotalAmount;
            public string TotalDueAmount;

        }


        [WebMethod]
        public static dis[] money(int search)
        {
            List<dis> details = new List<dis>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
      
 SELECT 
    SUM([amount]) AS TotalAmount,
    SUM([DueAmount]) AS TotalDueAmount,
    SUM([amount] - [DueAmount]) AS TotalDifference
FROM 
 [PaymentStatus]
 where PaymentPeriodID = @search;

        ", con);
                cmd.Parameters.AddWithValue("@search", search);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    dis field = new dis();
                    field.TotalAmount = dr["TotalAmount"].ToString();
                    field.TotalDueAmount = dr["TotalDueAmount"].ToString();
                    field.TotalDifference = dr["TotalDifference"].ToString();
                    details.Add(field);
                }
            }
            return details.ToArray();
        }

        public class yearr
        {
            public string NeighborhoodName;
            public string SubNeighborhoodName;
            public string HouseID;
            public string HouseNumber;
            public string IsActive;
            public string fullname;
            public string number;

            public string PaymentStatusID;
            public string amount;
            public string DueAmount;


        }


        [WebMethod]
        public static yearr[] datadisplay(string search)
        {
            List<yearr> details = new List<yearr>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
     

select * from PaymentStatus
inner join Houses on  Houses.HouseID = PaymentStatus.HouseID
inner join SubNeighborhoods on Houses.SubNeighborhoodID = SubNeighborhoods.SubNeighborhoodID
inner join Neighborhoods on SubNeighborhoods.NeighborhoodID = Neighborhoods.NeighborhoodID
where  Houses.IsActive = 1 and PaymentStatus.PaymentPeriodID = @search
        ", con);
                cmd.Parameters.AddWithValue("@search", search);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    yearr field = new yearr();
                    field.NeighborhoodName = dr["NeighborhoodName"].ToString();

                    field.SubNeighborhoodName = dr["SubNeighborhoodName"].ToString();
                    field.HouseID = dr["HouseID"].ToString();

                    field.HouseNumber = dr["HouseNumber"].ToString();

                    field.IsActive = dr["IsActive"].ToString();
                    field.fullname = dr["fullname"].ToString();
                    field.number = dr["number"].ToString();

                    field.amount = dr["amount"].ToString();
                    field.DueAmount = dr["DueAmount"].ToString();
                    field.PaymentStatusID = dr["PaymentStatusID"].ToString();
                    



                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }
        [WebMethod]
        public static List<ListItem> getdate()
        {
            string query = "  SELECT \r\n    PaymentPeriodID, \r\n    CONCAT(MonthName, ', ', CAST(Year AS VARCHAR(4))) AS MonthAndYear\r\nFROM \r\n    PaymentPeriod;";
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
                                Value = sdr["PaymentPeriodID"].ToString(),
                                Text = sdr["MonthAndYear"].ToString()
                            });
                        }
                    }
                    con.Close();
                    return customers;
                }
            }
        }

    }
}