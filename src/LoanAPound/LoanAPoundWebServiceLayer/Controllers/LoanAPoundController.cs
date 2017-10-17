using LoanAPoundBusinessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace LoanAPoundWebServiceLayer.Controllers
{
    public class GetApplicantCreditScoresParams
    {
        public List<string> creditScoreEngineNames;
        public int applicantID;
    }

    public class LoanAPoundController : ApiController
    {
        /// <summary>
        /// Wrapper for CreditScoreManager.GetCreditScoreEngines
        /// </summary>
        /// <returns>List of credit score engines</returns>
        [Route("GetCreditScoreEngineNames")]
        [HttpPost]
        public List<string> GetCreditScoreEngineNames()
        {
            List<string> creditScoreEngineNames = new List<string>();

            foreach (var kvp in CreditScoreManager.GetCreditScoreEngines())
            {
                creditScoreEngineNames.Add(kvp.Key);
            }

            return creditScoreEngineNames;
        }

        /// <summary>
        /// Wrapper for CreditScoreManager.GetApplicantCreditScores
        /// </summary>
        /// <param name="parameters">List of credit score engines and applicant id, wrapped in an object</param>
        /// <returns>List of credit scores</returns>
        [Route("GetApplicantCreditScores")]
        [HttpPost]
        public List<double> GetApplicantCreditScores(GetApplicantCreditScoresParams parameters)
        {
            List<double> retValue;
            try
            {
                List<string> creditScoreEngineNames = parameters.creditScoreEngineNames;
                CreditScoreManager.GetApplicantCreditScores(creditScoreEngineNames, parameters.applicantID, out retValue);
            }
            catch(Exception e)
            {
                retValue = null;
            }

            return retValue;
        }
    }
}
