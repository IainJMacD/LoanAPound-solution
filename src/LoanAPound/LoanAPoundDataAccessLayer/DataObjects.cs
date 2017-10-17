using System;

namespace LoanAPoundDataAccessLayer
{
    // Light-weight data objects corresponding to tables in the database

    public class ApplicantDO
    {
        public int ID { get; set;  }
        public string Title { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string Surname { get; set; }
        public string EmailAddress { get; set; }
    }

    public class CreditScoreResultDO
    {
        public int ID { get; set;  }
        public int ApplicantID { get; set; }
        public int CreditScoreEngineID { get; set; }
        public DateTime DateAchieved { get; set; }
        public double Result { get; set; }
    }

    public class CreditScoreEngineDO
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string TypeName { get; set; }
    }
}
