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
using static waamowaste.houses;

namespace waamowaste
{
    public partial class paymentga : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<ListItem> getdate()
        {
            string query = " SELECT TOP (1000) \r\n    [HouseID], \r\n    CONCAT([fullname], ' - ', [HouseID]) AS FullnameHouseID\r\n\r\nFROM \r\n    [Houses]\r\nWHERE \r\n    [IsActive] = 1;";
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
                                Value = sdr["HouseID"].ToString(),
                                Text = sdr["FullnameHouseID"].ToString()
                            });
                        }
                    }
                    con.Close();
                    return customers;
                }
            }
        }




        [WebMethod]
        public static string InsertPayment(string chargeType, string houseID, string paymentMonth, string paymentYear)
        {
            try
            {
                // Define your SQL connection string
       
                string constr = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();
                    string query = "";
                    string checkQuery = "";

                    int month = int.Parse(paymentMonth); // Month passed as a string
                    int year = int.Parse(paymentYear);   // Year passed as a string

                    if (chargeType == "single")
                    {
                        // Single Charge: Check if the house is already charged for the selected month and year
                        checkQuery = "SELECT COUNT(1) FROM PaymentStatus WHERE HouseID = @HouseID AND Month = @Month AND Year = @Year";
                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                        {
                            checkCmd.Parameters.AddWithValue("@HouseID", houseID);
                            checkCmd.Parameters.AddWithValue("@Month", month);
                            checkCmd.Parameters.AddWithValue("@Year", year);

                            int exists = (int)checkCmd.ExecuteScalar();

                            if (exists > 0)
                            {
                                return "This house is already charged for the selected month and year.";
                            }
                        }

                        // Proceed with the insert if not charged
                        query = "INSERT INTO PaymentStatus (HouseID, Month, Year, HasPaid, DueAmount, amount) " +
                                "VALUES (@HouseID, @Month, @Year, 0 , 0, 0)";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@HouseID", houseID);
                            cmd.Parameters.AddWithValue("@Month", month);
                            cmd.Parameters.AddWithValue("@Year", year);
                            //cmd.Parameters.AddWithValue("@HasPaid", paymentStatus == "paid" ? 1 : 0);
                            //cmd.Parameters.AddWithValue("@DueAmount", string.IsNullOrEmpty(paymentAmount) ? DBNull.Value : (object)paymentAmount);
                            //cmd.Parameters.AddWithValue("@Amount", string.IsNullOrEmpty(paymentAmount) ? DBNull.Value : (object)paymentAmount);

                            cmd.ExecuteNonQuery();
                        }
                    }
                    else if (chargeType == "all")
                    {
                        // All Charge: Insert only for houses that have not been charged for the selected month and year
                        query = "INSERT INTO PaymentStatus (HouseID, Month, Year, HasPaid, DueAmount, amount) " +
                                "SELECT h.HouseID, @Month, @Year, 0, 0 AS DueAmount, 0 AS amount " +
                                "FROM Houses h " +
                                "WHERE NOT EXISTS (SELECT 1 FROM PaymentStatus ps WHERE ps.HouseID = h.HouseID AND ps.Month = @Month AND ps.Year = @Year)";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Month", month);
                            cmd.Parameters.AddWithValue("@Year", year);
                   

                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                return "success";
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }




        public class housepay
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
        public static housepay[] datadisplay()
        {
            List<housepay> details = new List<housepay>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
  SELECT TOP (1000) 
   PaymentStatus.   [PaymentStatusID],
   PaymentStatus.   [HouseID],
     PaymentStatus. [Month],
   PaymentStatus.   [Year],
     PaymentStatus. [HasPaid],
    PaymentStatus.  [DueAmount],
     PaymentStatus. [PaymentPeriodID],
      PaymentStatus.[paidamount],
	  Houses.Amount,
  Houses.HouseNumber,
      Houses.fullname,
       Houses.number,
	  Neighborhoods.NeighborhoodName,
	  SubNeighborhoods.SubNeighborhoodName

  FROM [waamo_waste].[dbo].[PaymentStatus]
  inner join Houses on PaymentStatus.HouseID = Houses.HouseID
  inner join SubNeighborhoods on Houses.SubNeighborhoodID = SubNeighborhoods.SubNeighborhoodID
inner join Neighborhoods on SubNeighborhoods.NeighborhoodID = Neighborhoods.NeighborhoodID
  WHERE [Month] = MONTH(GETDATE())
  AND [Year] = YEAR(GETDATE())
        ", con);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    housepay field = new housepay();
                    field.NeighborhoodName = dr["NeighborhoodName"].ToString();

                    field.SubNeighborhoodName = dr["SubNeighborhoodName"].ToString();
                    field.HouseID = dr["HouseID"].ToString();

                    field.HouseNumber = dr["HouseNumber"].ToString();

                    field.fullname = dr["fullname"].ToString();
                    field.number = dr["number"].ToString();
                    field.DueAmount = dr["DueAmount"].ToString();
                    field.amount = dr["Amount"].ToString();
                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }



        public class housepayidivdual
        {
            public string NeighborhoodName;
            public string SubNeighborhoodName;
            public string HouseID;
            public string HouseNumber;
            public string IsActive;
            public string fullname;
            public string number;
            public string MonthYear;
            
            public string PaymentStatusID;
            public string amount;
            public string DueAmount;

        }




        [WebMethod]
        public static housepayidivdual[] datadisplay1(string id)
        {
            List<housepayidivdual> details = new List<housepayidivdual>();
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"  
SELECT TOP (1000) 
    PaymentStatus.[PaymentStatusID],
    PaymentStatus.[HouseID],
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
    PaymentStatus.[HasPaid],
    PaymentStatus.[DueAmount],
    PaymentStatus.[PaymentPeriodID],
    PaymentStatus.[paidamount],
    Houses.Amount,
    Houses.HouseNumber,
    Houses.fullname,
    Houses.number,
    Neighborhoods.NeighborhoodName,
    SubNeighborhoods.SubNeighborhoodName
FROM [waamo_waste].[dbo].[PaymentStatus]
INNER JOIN Houses ON PaymentStatus.HouseID = Houses.HouseID
INNER JOIN SubNeighborhoods ON Houses.SubNeighborhoodID = SubNeighborhoods.SubNeighborhoodID
INNER JOIN Neighborhoods ON SubNeighborhoods.NeighborhoodID = Neighborhoods.NeighborhoodID

  WHERE  Houses.HouseNumber = @id and PaymentStatus.HasPaid = 0 ;
        ", con);
                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    housepayidivdual field = new housepayidivdual();
                    field.NeighborhoodName = dr["NeighborhoodName"].ToString();

                    field.SubNeighborhoodName = dr["SubNeighborhoodName"].ToString();
                    field.HouseID = dr["HouseID"].ToString();

                    field.HouseNumber = dr["HouseNumber"].ToString();
                    field.MonthYear = dr["MonthYear"].ToString();
                    
                    field.fullname = dr["fullname"].ToString();
                    field.number = dr["number"].ToString();
                    field.DueAmount = dr["DueAmount"].ToString();
                    field.amount = dr["Amount"].ToString();
                    field.PaymentStatusID = dr["PaymentStatusID"].ToString();
                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }

        [WebMethod]
        public static string saveAmount(int PaymentStatusID, decimal paidAmount)
        {
            // Define your connection string
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

            try
            {
                // Establish a connection to the database
                using (SqlConnection conn = new SqlConnection(cs))
                {
                    conn.Open();

                    // First, retrieve the current DueAmount and PaidAmount
                    string selectQuery = "SELECT amount, DueAmount, paidamount FROM PaymentStatus WHERE PaymentStatusID = @PaymentStatusID";
                    using (SqlCommand selectCmd = new SqlCommand(selectQuery, conn))
                    {
                        selectCmd.Parameters.AddWithValue("@PaymentStatusID", PaymentStatusID);

                        using (SqlDataReader reader = selectCmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                decimal totalAmount = reader.GetDecimal(0);  // The total amount assigned to pay
                                decimal currentDueAmount = reader.GetDecimal(1);  // The remaining DueAmount
                                decimal currentPaidAmount = reader.GetDecimal(2);  // The total amount paid so far

                                // Ensure the payment doesn't exceed the remaining DueAmount
                                if (paidAmount > currentDueAmount)
                                {
                                    return "The amount you are trying to pay exceeds the remaining due amount.";
                                }

                                // Calculate the new DueAmount and PaidAmount
                                decimal newDueAmount = currentDueAmount - paidAmount;
                                decimal newPaidAmount = currentPaidAmount + paidAmount;

                                // Determine if the user has paid the full amount
                                int hasPaid = newDueAmount == 0 ? 1 : 0; // Set HasPaid to 1 if DueAmount becomes 0

                                // Close the reader before proceeding with the update
                                reader.Close();

                                // Update the database with the new values
                                string updateQuery = @"
                            UPDATE PaymentStatus 
                            SET DueAmount = @NewDueAmount, paidamount = @NewPaidAmount, HasPaid = @HasPaid
                            WHERE PaymentStatusID = @PaymentStatusID";

                                using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                                {
                                    updateCmd.Parameters.AddWithValue("@NewDueAmount", newDueAmount);
                                    updateCmd.Parameters.AddWithValue("@NewPaidAmount", newPaidAmount);
                                    updateCmd.Parameters.AddWithValue("@HasPaid", hasPaid);  // Update HasPaid status
                                    updateCmd.Parameters.AddWithValue("@PaymentStatusID", PaymentStatusID);

                                    int rowsAffected = updateCmd.ExecuteNonQuery();

                                    if (rowsAffected > 0)
                                    {
                                        return "Payment saved successfully!";
                                    }
                                    else
                                    {
                                        return "Failed to save payment. Please try again.";
                                    }
                                }
                            }
                            else
                            {
                                return "No record found for the specified PaymentStatusID.";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any errors that occurred during the database operation
                return "Error: " + ex.Message;
            }
        }

    }
}