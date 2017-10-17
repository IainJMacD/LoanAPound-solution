using LoanAPoundDataAccessLayer;

namespace LoanAPoundBusinessLayer
{
    /// <summary>
    /// The Applicant class models an applicant for a loan
    /// </summary>
    public class Applicant
    {
        public int ID { get; }
        public string Title { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string Surname { get; set; }
        public string EmailAddress { get; set; }

        public Applicant(ApplicantDO applicantDO)
        {
            this.ID = applicantDO.ID;
            this.Title = applicantDO.Title;
            this.FirstName = applicantDO.FirstName;
            this.MiddleName = applicantDO.MiddleName;
            this.Surname = applicantDO.Surname;
            this.EmailAddress = applicantDO.EmailAddress;
        }
    }
}
