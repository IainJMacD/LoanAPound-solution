using LoanAPoundDataAccessLayer;

namespace LoanAPoundBusinessLayer
{
    /// <summary>
    /// Credit Score Engines are obliged to implement the ICreditScoreEngine interface
    /// </summary>
    public interface ICreditScoreEngine
    {
        string GetName();
        int GetID();
        void SetID(int id);
        double GetCreditScore(int applicantID);
    }

    /// <summary>
    ///  The CreditScoreEngine abstract class implements the ICreditScoreEngine interface.
    ///  It is the base class for concrete "plug-in" implementation classes.
    /// </summary>
    public abstract class CreditScoreEngine : ICreditScoreEngine
    {
        public virtual string Name { get; set; }
        private int id;

        public virtual string GetName() { return Name; }
        public virtual int GetID() { return id; }
        public virtual void SetID(int id) { this.id = id; }
        public abstract double GetCreditScore(int applicantID);

        protected virtual ApplicantDO GetApplicantDO(int applicantID)
        {
            ApplicantDO applicantDO;
            if (!Database.GetApplicantDO(applicantID, out applicantDO))
            {
                applicantDO = null;
            };
            return applicantDO;
        }
    }

    // Concrete Credit Score Engine classes - three dummy implentations are supplied in this file
    // Names are implemented in code, rather than in the database

    public class CreditScoreEngine1 : CreditScoreEngine
    {
        public CreditScoreEngine1()
        {
            this.Name = "Provider 1 (First name length * 10)";
        }

        public override double GetCreditScore(int applicantID)
        {
            return GetApplicantDO(applicantID).FirstName.Length * 10;
        }
    }

    public class CreditScoreEngine2 : CreditScoreEngine
    {
        public CreditScoreEngine2()
        {
            this.Name = "Provider 2 (Middle name length + Surname length)";
        }

        public override double GetCreditScore(int applicantID)
        {
            ApplicantDO applicantDO = GetApplicantDO(applicantID);
            return applicantDO.MiddleName.Length + applicantDO.Surname.Length;
        }
    }

    public class CreditScoreEngine3 : CreditScoreEngine
    {
        public CreditScoreEngine3()
        {
            this.Name = "Provider 3 (Likes Gmail)";
        }

        public override double GetCreditScore(int applicantID)
        {
            return GetApplicantDO(applicantID).EmailAddress.Contains("gmail")? 100 : 0;
        }
    }
}

