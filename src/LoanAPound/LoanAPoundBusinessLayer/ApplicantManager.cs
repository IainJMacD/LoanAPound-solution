using LoanAPoundDataAccessLayer;

namespace LoanAPoundBusinessLayer
{
    /// <summary>
    /// The ApplicantManager class provides applicant-related services
    /// </summary>
    public static class ApplicantManager
    {
        public static Applicant GetApplicant(int applicantID)
        {
            Applicant retVal = null;

            ApplicantDO applicantDO;
            if(Database.GetApplicantDO(applicantID, out applicantDO))
            {
                retVal = new Applicant(applicantDO);
            }

            return retVal;
        }
    }
}
