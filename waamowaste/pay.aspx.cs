using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static waamowaste.payments;

namespace waamowaste
{
    public partial class pay : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        public class yearr1
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
        public static yearr1[] datadisplay(string search)
        {
            List<yearr1> details = new List<yearr1>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  

      

SELECT h.HouseID,
       h.HouseNumber,
       h.fullname,
       h.number,
       h.IsActive,
       ps.PaymentStatusID,
       ps.Month,
       ps.Year,
       ps.HasPaid,
       ps.DueAmount,
       ps.PaymentPeriodID,
       Neighborhoods.NeighborhoodName,
       SubNeighborhoods.SubNeighborhoodName,
       ps.amount
FROM Houses h
LEFT JOIN PaymentStatus ps 
    ON h.HouseID = ps.HouseID 
    AND (ps.PaymentPeriodID = @search OR ps.PaymentPeriodID IS NULL)
INNER JOIN SubNeighborhoods 
    ON h.SubNeighborhoodID = SubNeighborhoods.SubNeighborhoodID
INNER JOIN Neighborhoods 
    ON SubNeighborhoods.NeighborhoodID = Neighborhoods.NeighborhoodID
WHERE h.IsActive = 1 
  AND (ps.DueAmount > 0 OR ps.DueAmount = 0)  -- Include houses with or without debt
  AND ps.HasPaid IN (0, 1); -- Include houses with HasPaid 0 or 1

        ", con);
                cmd.Parameters.AddWithValue("@search", search);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    yearr1 field = new yearr1();
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
        public static string addlacag(string id, string amountRequired, string creditAmount, string remainingAmount, string PaymentPeriodID)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Step 1: Get the HouseID from the existing row using the PaymentStatusID
                    string selectHouseQuery = "SELECT HouseID FROM [PaymentStatus] WHERE [PaymentStatusID] = @id";
                    string houseID = string.Empty;

                    using (SqlCommand selectCmd = new SqlCommand(selectHouseQuery, con))
                    {
                        selectCmd.Parameters.AddWithValue("@id", id);

                        object result = selectCmd.ExecuteScalar();
                        if (result != null)
                        {
                            houseID = result.ToString();
                        }
                        else
                        {
                            return "Error: No record found for the provided PaymentStatusID.";
                        }
                    }

                    // Step 2: Update the existing PaymentStatus row
                    string updateQuery = "UPDATE [PaymentStatus] SET " +
                                         "[amount] = @amountRequired, " +
                                         "[paidamount] = @creditAmount, " +
                                         "[PaymentPeriodID] = @PaymentPeriodID, " +
                                         "[HasPaid] = 1, " +
                                         "[DueAmount] = @remainingAmount " +
                                         "WHERE [PaymentStatusID] = @id";

                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                    {
                        updateCmd.Parameters.AddWithValue("@id", id);
                        updateCmd.Parameters.AddWithValue("@amountRequired", amountRequired);
                        updateCmd.Parameters.AddWithValue("@creditAmount", creditAmount);
                        updateCmd.Parameters.AddWithValue("@remainingAmount", remainingAmount);
                        updateCmd.Parameters.AddWithValue("@PaymentPeriodID", PaymentPeriodID);

                        updateCmd.ExecuteNonQuery();
                    }

                    // Step 3: Insert a new row with HouseID and default values for non-nullable columns
                    string insertQuery = "INSERT INTO [PaymentStatus] ([HouseID], [Month], [Year], [HasPaid], [DueAmount]) " +
                                         "VALUES (@houseID, @defaultMonth, @defaultYear, 0, @defaultDueAmount)";

                    using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                    {
                        insertCmd.Parameters.AddWithValue("@houseID", houseID);
                        insertCmd.Parameters.AddWithValue("@defaultMonth", DateTime.Now.Month);  // Example: Use current month
                        insertCmd.Parameters.AddWithValue("@defaultYear", DateTime.Now.Year);    // Example: Use current year
                        insertCmd.Parameters.AddWithValue("@defaultDueAmount", 0);               // Set DueAmount to 0 as default
        

                        insertCmd.ExecuteNonQuery();
                    }
                }

                return "true";
            }
            catch (Exception ex)
            {
                // Handle exceptions
                return "Error: " + ex.Message;
            }
        }

        [WebMethod]
        public static string paydeyn(string id, string repayAmount)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // Update PaymentStatus table
                    string updateQuery = "UPDATE [PaymentStatus] SET " +
                              "[paidamount] =paidamount +  @repayAmount, " +
                                         "[DueAmount] = DueAmount -  @repayAmount " +
                                           "WHERE [PaymentStatusID] = @id";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.Parameters.AddWithValue("@repayAmount", repayAmount);
                


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


        public class indi
        {
            public string TotalDifference;
            public string TotalAmount;
            public string TotalDueAmount;
        }



        [WebMethod]
        public static indi[] money(int id)
        {
            List<indi> details = new List<indi>();
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
 where PaymentStatusID = @search;

        ", con);
                cmd.Parameters.AddWithValue("@search", id);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    indi field = new indi();
                    field.TotalAmount = dr["TotalAmount"].ToString();
                    field.TotalDueAmount = dr["TotalDueAmount"].ToString();
                    field.TotalDifference = dr["TotalDifference"].ToString();
                    details.Add(field);
                }
            }
            return details.ToArray();
        }

    }
}