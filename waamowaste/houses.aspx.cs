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

                    field.HouseNumber = dr["HouseNumber"].ToString();

                    field.IsActive = dr["IsActive"].ToString();
                    field.fullname = dr["fullname"].ToString();
                    field.number = dr["number"].ToString();


                    details.Add(field);
                }
            } // Connection will be automatically closed here

            return details.ToArray();
        }


        [WebMethod]
        public static house[] datadisplay1( string id )
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
    }
}