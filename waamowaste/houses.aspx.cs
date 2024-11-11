
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using static waamowaste.users;

namespace waamowaste
{
    public partial class houses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string SaveHouseDetails(string houseNumber, string waaxda, string street, string city, string state, string postalCode, string gpsLatitude, string gpsLongitude, string isActive, string fullname, string number, decimal amount, string date)
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
                    INSERT INTO Houses (HouseNumber, SubNeighborhoodID, Street, City, State, PostalCode, GPSLatitude, GPSLongitude, IsActive, FullName, Number, Amount, Date)
                    VALUES (@HouseNumber, @SubNeighborhoodID,  @Street, @City, @State, @PostalCode, @GPSLatitude, @GPSLongitude, @IsActive, @FullName, @Number, @Amount, @Date);
                    SELECT SCOPE_IDENTITY();"; // To retrieve the new HouseID

                        using (SqlCommand cmd = new SqlCommand(houseInsertQuery, conn, transaction))
                        {
                            // Add parameters to prevent SQL injection
                            cmd.Parameters.AddWithValue("@HouseNumber", houseNumber);
                            cmd.Parameters.AddWithValue("@SubNeighborhoodID", waaxda);
                            cmd.Parameters.AddWithValue("@Street", street);
                            cmd.Parameters.AddWithValue("@City", city);
                            cmd.Parameters.AddWithValue("@State", state);
                            cmd.Parameters.AddWithValue("@PostalCode", postalCode);
                            cmd.Parameters.AddWithValue("@GPSLatitude", string.IsNullOrEmpty(gpsLatitude) ? (object)DBNull.Value : gpsLatitude);
                            cmd.Parameters.AddWithValue("@GPSLongitude", string.IsNullOrEmpty(gpsLongitude) ? (object)DBNull.Value : gpsLongitude);
                            cmd.Parameters.AddWithValue("@IsActive", isActive == "1" ? 1 : 0);
                            cmd.Parameters.AddWithValue("@FullName", fullname);
                            cmd.Parameters.AddWithValue("@Number", number);
                            cmd.Parameters.AddWithValue("@Amount", amount);
                            cmd.Parameters.AddWithValue("@Date", parsedDate);  // Pass the parsed date

                            // Execute the query and get the new HouseID
                            int houseID = Convert.ToInt32(cmd.ExecuteScalar());

                            // Insert into PaymentStatus table
                            string paymentStatusInsertQuery = @"
                        INSERT INTO PaymentStatus (HouseID, Month, Year, HasPaid, DueAmount, PaymentPeriodID, amount, paidamount)
                        VALUES (@HouseID, @Month, @Year, @HasPaid, @DueAmount, @PaymentPeriodID, @Amount, @PaidAmount)";

                            using (SqlCommand paymentCmd = new SqlCommand(paymentStatusInsertQuery, conn, transaction))
                            {
                                // Add the required parameters
                                paymentCmd.Parameters.AddWithValue("@HouseID", houseID);
                                paymentCmd.Parameters.AddWithValue("@Month", parsedDate.Month);  // Month from the date field
                                paymentCmd.Parameters.AddWithValue("@Year", parsedDate.Year);    // Year from the date field
                                paymentCmd.Parameters.AddWithValue("@HasPaid", 0);               // Default value for HasPaid
                                paymentCmd.Parameters.AddWithValue("@DueAmount", amount);        // Due amount same as house amount
                                paymentCmd.Parameters.AddWithValue("@PaymentPeriodID", 1);       // Example PaymentPeriodID, modify as needed
                                paymentCmd.Parameters.AddWithValue("@Amount", amount);           // House amount
                                paymentCmd.Parameters.AddWithValue("@PaidAmount", 0);            // Initially paid amount is 0

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


        public class house
        {
            public string NeighborhoodName;
            public string SubNeighborhoodName;
            public string HouseID;
            public string HouseNumber;
            public string IsActive;
            public string fullname;
            public string number;
            public string GPSLongitude;
            public string GPSLatitude;



            public string Street;
            public string City;
            public string State;
            public string PostalCode;
            public string date;
            public string Amount;
            public string NeighborhoodID;
            public string SubNeighborhoodID;

        }

        [WebMethod]
        public static house[] datadisplay()
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
        ", con);

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    house field = new house();
                    field.NeighborhoodName = dr["NeighborhoodName"].ToString();

                    field.SubNeighborhoodName = dr["SubNeighborhoodName"].ToString();
                    field.HouseID = dr["HouseID"].ToString();
                    field.GPSLatitude = dr["GPSLatitude"].ToString();
                    field.GPSLongitude = dr["GPSLongitude"].ToString();
                    field.HouseNumber = dr["HouseNumber"].ToString();

                    field.IsActive = dr["IsActive"].ToString();
                    field.fullname = dr["fullname"].ToString();
                    field.number = dr["number"].ToString();



                    field.Street = dr["Street"].ToString();

                    field.City = dr["City"].ToString();

                    field.State = dr["State"].ToString();


                    field.PostalCode = dr["PostalCode"].ToString();
                    field.date = dr["date"].ToString();

                    field.Amount = dr["Amount"].ToString();


                    field.NeighborhoodID = dr["NeighborhoodID"].ToString();
                    field.SubNeighborhoodID = dr["SubNeighborhoodID"].ToString();







                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
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
where Houses.HouseID = @id
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
WHERE Houses.HouseID = @id;

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



        public class fclass
        {
            public string PaymentStatus { get; set; }
            public string MonthYear { get; set; }
            public string paidamount { get; set; }

        }

        [WebMethod]
        public static string updatehouses(HouseData houseData)
        {

            bool isActive = houseData.isActive;
            try
            {
                // Connection string from Web.config
                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;

                // SQL query for updating the house details
                string query = @"
                UPDATE Houses
                SET 
                    SubNeighborhoodID = @waaxda,
                    Street = @street,
                    City = @city,
                    State = @state,
                    PostalCode = @postalCode,
                    GPSLatitude = @gpsLatitude,
                    GPSLongitude = @gpsLongitude,
                    IsActive = @isActive,
                    fullname = @fullname,
                    number = @number,
                    Amount = @amount,
                     houseNumber = @houseNumber,
                    date = @date




                WHERE 
                    HouseID = @HouseID";

                using (SqlConnection connection = new SqlConnection(cs))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Adding parameters to prevent SQL injection
                        command.Parameters.AddWithValue("@houseNumber", houseData.houseNumber);
                        command.Parameters.AddWithValue("@waaxda", houseData.waaxda);
                        command.Parameters.AddWithValue("@street", houseData.street);
                        command.Parameters.AddWithValue("@city", houseData.city);
                        command.Parameters.AddWithValue("@state", houseData.state);
                        command.Parameters.AddWithValue("@postalCode", houseData.postalCode);
                        command.Parameters.AddWithValue("@gpsLatitude", houseData.gpsLatitude);
                        command.Parameters.AddWithValue("@gpsLongitude", houseData.gpsLongitude);
                        command.Parameters.AddWithValue("@isActive", houseData.isActive);
                        command.Parameters.AddWithValue("@fullname", houseData.fullname);
                        command.Parameters.AddWithValue("@number", houseData.number);
                        command.Parameters.AddWithValue("@amount", houseData.amount);
                        command.Parameters.AddWithValue("@date", houseData.date);
                        command.Parameters.AddWithValue("@HouseID", houseData.HouseID);
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
        public class HouseData
        {
            public string houseNumber { get; set; }
            public string waaxda { get; set; }
            public string street { get; set; }
            public string city { get; set; }
            public string state { get; set; }
            public string postalCode { get; set; }
            public decimal gpsLatitude { get; set; }
            public decimal gpsLongitude { get; set; }
            public bool isActive { get; set; }
            public string fullname { get; set; }
            public string number { get; set; }
            public string amount { get; set; }
            public string date { get; set; }
            public string HouseID { get; set; }

        }
    }
}





