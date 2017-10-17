using LoanAPoundDataAccessLayer;
using System;
using System.Collections.Generic;
using System.Reflection;

namespace LoanAPoundBusinessLayer
{
    /// <summary>
    /// The CreditScoreManager class provides credit score-related services
    /// </summary>

    public static class CreditScoreManager
    {
        static private Dictionary<string, ICreditScoreEngine> creditScoreEngines;

        static CreditScoreManager()
        {
            // Initialise the credit score engines on construction of the static class
            InitialiseCreditScoreEngines();
        }

        /// <summary>
        /// Retrieve credit score engine type names from the database, and instantiate them
        /// </summary>
        public static void InitialiseCreditScoreEngines()
        {
            List<CreditScoreEngineDO> creditScoreEngineDOs;

            if (Database.GetCreditScoreEngines(out creditScoreEngineDOs))
            {
                creditScoreEngines = new Dictionary<string, ICreditScoreEngine>();

                foreach (var creditScoreEngineDO in creditScoreEngineDOs)
                {
                    ICreditScoreEngine creditScoreEngine = (ICreditScoreEngine)Assembly.GetExecutingAssembly().CreateInstance(creditScoreEngineDO.TypeName);
                    creditScoreEngine.SetID(creditScoreEngineDO.ID);
                    creditScoreEngines.Add(creditScoreEngine.GetName(), creditScoreEngine);
                }
            }
        }

        /// <summary>
        /// Accessor method for dictionary of credit score engines
        /// </summary>
        public static Dictionary<string, ICreditScoreEngine> GetCreditScoreEngines()
        {
            return creditScoreEngines;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="creditScoreEngineNames">List of names of credit score engines to query</param>
        /// <param name="applicantID">ID of applicant</param>
        /// <param name="creditScores">out parameter - list of numeric credit scores, in same order as input list of engine names</param>
        /// <returns>true for success</returns>
        public static bool GetApplicantCreditScores(List<string> creditScoreEngineNames, int applicantID, out List<double> creditScores)
        {
            bool retValue = true;
            creditScores = new List<double>();

            foreach(string name in creditScoreEngineNames)
            {
                if (creditScoreEngines.ContainsKey(name))
                {
                    ICreditScoreEngine creditScoreEngine = creditScoreEngines[name];
                    double creditScore = creditScoreEngine.GetCreditScore(applicantID);

                    creditScores.Add(creditScore);

                    //Write credit score result to the database
                    CreditScoreResultDO creditScoreResultDO = new CreditScoreResultDO
                    {
                        ApplicantID = applicantID,
                        CreditScoreEngineID = creditScoreEngine.GetID(),
                        DateAchieved = DateTime.Now,
                        Result = creditScore
                    };
                    Database.InsertCreditScoreResult(creditScoreResultDO);

                }
                else
                {
                    creditScores.Add(-1);
                    retValue = false;
                }
            }

            return retValue;
        }

        /// <summary>
        /// Stores the result of a credit check to the database
        /// </summary>
        /// <param name="creditScoreResult">Credit score result object to store</param>
        /// <returns>true for success</returns>
        public static bool InsertCreditScoreResult(ref CreditScoreResult creditScoreResult)
        {
            return Database.InsertCreditScoreResult(creditScoreResult.GetDataObject());
        }
    }
}
