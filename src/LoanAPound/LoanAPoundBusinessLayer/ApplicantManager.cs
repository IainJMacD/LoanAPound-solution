using LoanAPoundDataAccessLayer;
using System.Collections.Generic;

namespace LoanAPoundBusinessLayer
{
    /// <summary>
    /// The ApplicantManager class provides applicant-related services
    /// </summary>
    public static class ApplicantManager
    {
        // Applicants is a cache of Applicant objects, maintained so that
        // unnecessary repeated database queries are not performed
        private static Dictionary<int, Applicant> Applicants = new Dictionary<int, Applicant>();

        public static Applicant GetApplicant(int applicantID)
        {
            if (!Applicants.ContainsKey(applicantID))
            {
                ApplicantDO applicantDO;
                if (Database.GetApplicantDO(applicantID, out applicantDO))
                {
                    Applicants[applicantID] = new Applicant(applicantDO);
                }
            }

            return Applicants[applicantID];
        }
    }
}
