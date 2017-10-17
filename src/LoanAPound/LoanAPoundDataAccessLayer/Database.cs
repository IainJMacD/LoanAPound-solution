using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace LoanAPoundDataAccessLayer
{
    /// <summary>
    /// The Database class provides access to the SQL Server database
    /// </summary>
    public static class Database
    {
        private static string connectionString = Properties.Settings.Default.ConnectionString;

        /// <summary>
        /// Retrieves credit score engines from the database
        /// </summary>
        /// <param name="creditScoreEngines">out parameter - List of credit score engines in the database</param>
        /// <returns>true for success</returns>
        public static bool GetCreditScoreEngines(out List<CreditScoreEngineDO> creditScoreEngines)
        {
            bool retVal = false;
            creditScoreEngines = new List<CreditScoreEngineDO>();

            string queryString =
                @"SELECT ID, TypeName 
                  FROM [LoanAPound].[dbo].CreditScoreEngine ";

            using (SqlConnection connection =
                 new SqlConnection(connectionString))
            {
                // Create the Command and Parameter objects.
                SqlCommand command = new SqlCommand(queryString, connection);
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    while(reader.Read())
                    {
                        creditScoreEngines.Add(new CreditScoreEngineDO
                        {
                            ID = (int)reader["ID"],
                            TypeName = (string)reader["TypeName"]
                        });
                    }
                    reader.Close();
                    retVal = true;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            return retVal;
        }

        /// <summary>
        /// Retrieves a single applicant from the database
        /// </summary>
        /// <param name="ApplicantID">ID of the applicant</param>
        /// <param name="applicantDO">out parameter - a data object corresponding to the applicant</param>
        /// <returns></returns>
        public static bool GetApplicantDO(int ApplicantID, out ApplicantDO applicantDO)
        {
            bool retVal = false;
            applicantDO = null;

            string queryString =
                @"SELECT Title, FirstName, MiddleName, Surname, EmailAddress 
                  FROM [LoanAPound].[dbo].Applicant 
                  WHERE ID = @id ";

            using (SqlConnection connection =
                 new SqlConnection(connectionString))
            {
                // Create the Command and Parameter objects.
                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.AddWithValue("@id", ApplicantID);
                try
                {
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    reader.Read();
                    applicantDO = new ApplicantDO {
                        ID = ApplicantID,
                        Title = (string)reader["Title"],
                        FirstName = (string)reader["FirstName"],
                        MiddleName = (string)reader["MiddleName"],
                        Surname = (string)reader["Surname"],
                        EmailAddress = (string)reader["EmailAddress"]
                    };
                    retVal = true;
                    reader.Close();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            return retVal;
        }

        /// <summary>
        /// Inserts a credit score result into the database
        /// </summary>
        /// <param name="creditScoreResultDO">credit score result to insert</param>
        /// <returns>true for success</returns>
        public static bool InsertCreditScoreResult(CreditScoreResultDO creditScoreResultDO)
        {
            bool retVal = false;

            // SQL command
            string queryString = @"INSERT INTO [CreditScoreResult]
                        ([ApplicantID]
                        ,[CreditScoreEngineID]
                        ,[DateAchieved]
                        ,[Result])
                    VALUES
                        (@applicantID
                        ,@creditScoreEngineID
                        ,@dateAchieved
                        ,@result)";

            using (SqlConnection connection =
                new SqlConnection(connectionString))
            {
                // Create the Command and Parameter objects.
                SqlCommand command = new SqlCommand(queryString, connection);
                command.Parameters.AddWithValue("@applicantID", creditScoreResultDO.ApplicantID);
                command.Parameters.AddWithValue("@creditScoreEngineID", creditScoreResultDO.CreditScoreEngineID);
                command.Parameters.AddWithValue("@dateAchieved", creditScoreResultDO.DateAchieved);
                command.Parameters.AddWithValue("@result", creditScoreResultDO.Result);

                try
                {
                    connection.Open();
                    int insertedCount = command.ExecuteNonQuery();
                    retVal = insertedCount > 0;
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }

            return retVal;
        }
    }
}
