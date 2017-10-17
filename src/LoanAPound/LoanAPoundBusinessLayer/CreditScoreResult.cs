using LoanAPoundDataAccessLayer;
using System;

namespace LoanAPoundBusinessLayer
{
    /// <summary>
    /// The CreditScoreResult class models a credit score result, including its date
    /// </summary>

    public class CreditScoreResult
    {
        public int ApplicantID { get; set; }
        public int CreditScoreEngineID { get; set; }
        public DateTime DateAchieved { get; set; }

        public CreditScoreResult() { }

        public CreditScoreResult(CreditScoreResultDO creditScoreResultDO)
        {
            this.ApplicantID = creditScoreResultDO.ApplicantID;
            this.CreditScoreEngineID = creditScoreResultDO.CreditScoreEngineID;
            this.DateAchieved = creditScoreResultDO.DateAchieved;
        }

        /// <summary>
        /// Converts business object to data object
        /// </summary>
        /// <returns>corresponding data object</returns>
        public CreditScoreResultDO GetDataObject()
        {
            return new CreditScoreResultDO
            {
                ApplicantID = this.ApplicantID,
                CreditScoreEngineID = this.CreditScoreEngineID,
                DateAchieved = this.DateAchieved
            };
        }
    }
}
