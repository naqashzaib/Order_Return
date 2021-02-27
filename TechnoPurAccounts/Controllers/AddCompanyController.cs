using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using DataAccessLayer;
using TechnoPurAccounts.Models;

namespace TechnoPurAccounts.Controllers
{
    public class AddCompanyController : ApiController
    {
        private return_orderEntities1 db = new return_orderEntities1();

        // GET: api/cat_1/5
        [Route("api/GetCompany")]
        [HttpGet]
        public HttpResponseMessage GetCompany()
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {
                var query = from c1 in db.companies
                            where c1.type == "Company"
                            select c1;
                transaction.Commit();
                return Request.CreateResponse(HttpStatusCode.OK, query);
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }

        public class clsCompanyInsert
        {
            public int company_id { get; set; }
            public string name { get; set; }
            public string username { get; set; }
            public string password { get; set; }
            public string email { get; set; }
            public string phone { get; set; }
        }


        [Route("api/CompanyInsert")]
        [HttpPost]
        public HttpResponseMessage GetCompanyInsert([FromBody] clsCompanyInsert objclsCompanyInsert)
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {

                var longin = (from comp in db.companies
                              where (comp.email == objclsCompanyInsert.email)
                              select comp).SingleOrDefault();

                var longin2 = (from comp in db.companies
                               where (comp.username == objclsCompanyInsert.username)
                               select comp).SingleOrDefault();


                string userfoundstring = "";

                if (longin != null)
                {
                    userfoundstring = "E-mail Already Exist";
                }
                else if (longin2 != null)
                {
                    userfoundstring = "User Name Already Exist";
                }






                if (userfoundstring == "")
                {
                    DateTime today = DateTime.Today;
                    company objcompany = new company();
                    objcompany.name = objclsCompanyInsert.name;
                    objcompany.username = objclsCompanyInsert.username;
                    objcompany.password = objclsCompanyInsert.password;
                    objcompany.email = objclsCompanyInsert.email;
                    objcompany.phone = objclsCompanyInsert.phone;
                    objcompany.type = "Company";
                    db.companies.Add(objcompany);
                    db.SaveChanges();
                    int company_id = objcompany.company_id;
                    login objlogin = new login();
                    objlogin.username = objclsCompanyInsert.username;
                    objlogin.password = objclsCompanyInsert.password.GetMD5HashData();
                    objlogin.email = objclsCompanyInsert.email;
                    objlogin.role_id = 2;
                    objlogin.date = today;
                    objlogin.company_id = company_id;
                    db.logins.Add(objlogin);
                    db.SaveChanges();

                    transaction.Commit();
                    return Request.CreateResponse(HttpStatusCode.OK, "Created");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.Found, userfoundstring);
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }


        [Route("api/CompanyUpdate")]
        [HttpPut]
        public HttpResponseMessage GetCompanyUpdate([FromBody] clsCompanyInsert objclsCompanyInsert)
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {

                var longin = (from comp in db.companies
                              where (comp.company_id == objclsCompanyInsert.company_id)
                              select comp).SingleOrDefault();


                var longin_table = (from comp in db.logins
                                    where (comp.company_id == objclsCompanyInsert.company_id)
                                    select comp).SingleOrDefault();

                if (longin != null)
                {
                    longin.name = objclsCompanyInsert.name;
                    longin.username = objclsCompanyInsert.username;
                    longin.password = objclsCompanyInsert.password;

                    longin.email = objclsCompanyInsert.email;
                    longin.phone = objclsCompanyInsert.phone;
                    db.SaveChanges();
                    longin_table.username = objclsCompanyInsert.username;
                    longin_table.password = objclsCompanyInsert.password.GetMD5HashData();
                    longin_table.email = objclsCompanyInsert.email;
                    db.SaveChanges();
                    transaction.Commit();

                    return Request.CreateResponse(HttpStatusCode.OK, "Updated");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound, "Not Found");
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }

        [Route("api/CompanyDelete")]
        [HttpDelete]
        public HttpResponseMessage GetCompanyDelete(int company_id)
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {

                var longin = (from comp in db.companies
                              where (comp.company_id == company_id)
                              select comp).SingleOrDefault();


                if (longin != null)
                {

                    var tabmanual_journal_entry =
                from details in db.companies
                where details.company_id == company_id
                select details;
                    db.companies.RemoveRange(tabmanual_journal_entry);
                    db.SaveChanges();



                    var longin_table =
           from details in db.logins
           where details.company_id == company_id
           select details;
                    db.logins.RemoveRange(longin_table);
                    db.SaveChanges();
                    transaction.Commit();

                    return Request.CreateResponse(HttpStatusCode.OK, "Deleted");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound, "Not Found");
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }




        //Employee

        [Route("api/GetEmployee")]
        [HttpGet]
        public HttpResponseMessage GetEmployee()
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {
                var query = from c1 in db.companies
                            where c1.type == "Employee"
                            select c1;
                transaction.Commit();

                return Request.CreateResponse(HttpStatusCode.OK, query);
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }


        [Route("api/EmployeeInsert")]
        [HttpPost]
        public HttpResponseMessage GetEmployeeInsert([FromBody] clsCompanyInsert objclsCompanyInsert)
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {

                var longin = (from comp in db.companies
                              where (comp.email == objclsCompanyInsert.email)
                              select comp).SingleOrDefault();

                var longin2 = (from comp in db.companies
                               where (comp.username == objclsCompanyInsert.username)
                               select comp).SingleOrDefault();


                string userfoundstring = "";

                if (longin != null)
                {
                    userfoundstring = "E-mail Already Exist";
                }
                else if (longin2 != null)
                {
                    userfoundstring = "User Name Already Exist";
                }






                if (userfoundstring == "")
                {
                    DateTime today = DateTime.Today;

                    company objcompany = new company();
                    objcompany.name = objclsCompanyInsert.name;
                    objcompany.username = objclsCompanyInsert.username;
                    objcompany.password = objclsCompanyInsert.password;
                    objcompany.email = objclsCompanyInsert.email;
                    objcompany.phone = objclsCompanyInsert.phone;
                    objcompany.type = "Employee";
                    db.companies.Add(objcompany);
                    db.SaveChanges();
                    int company_id = objcompany.company_id;
                    login objlogin = new login();
                    objlogin.username = objclsCompanyInsert.username;
                    objlogin.password = objclsCompanyInsert.password.GetMD5HashData();
                    objlogin.email = objclsCompanyInsert.email;
                    objlogin.role_id = 3;
                    objlogin.date = today;
                    objlogin.company_id = company_id;
                    db.logins.Add(objlogin);
                    db.SaveChanges();


                    transaction.Commit();
                    return Request.CreateResponse(HttpStatusCode.OK, "Created");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.Found, userfoundstring);

                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }


        [Route("api/EmployeeUpdate")]
        [HttpPut]
        public HttpResponseMessage GetEmployeeUpdate([FromBody] clsCompanyInsert objclsCompanyInsert)
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {

                var longin = (from comp in db.companies
                              where (comp.company_id == objclsCompanyInsert.company_id)
                              select comp).SingleOrDefault();

                var longin_table = (from comp in db.logins
                                    where (comp.company_id == objclsCompanyInsert.company_id)
                                    select comp).SingleOrDefault();
                if (longin != null)
                {
                    longin.name = objclsCompanyInsert.name;
                    longin.username = objclsCompanyInsert.username;
                    longin.password = objclsCompanyInsert.password;
                    longin.email = objclsCompanyInsert.email;
                    longin.phone = objclsCompanyInsert.phone;
                    db.SaveChanges();
                    longin_table.username = objclsCompanyInsert.username;
                    longin_table.password = objclsCompanyInsert.password.GetMD5HashData();
                    longin_table.email = objclsCompanyInsert.email;
                    db.SaveChanges();
                    transaction.Commit();

                    return Request.CreateResponse(HttpStatusCode.OK, "Updated");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound, "Not Found");
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }

        [Route("api/EmployeeDelete")]
        [HttpDelete]
        public HttpResponseMessage GetEmployeeDelete(int company_id)
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {

                var longin = (from comp in db.companies
                              where (comp.company_id == company_id)
                              select comp).SingleOrDefault();
                if (longin != null)
                {

                    var tabmanual_journal_entry =
                from details in db.companies
                where details.company_id == company_id
                select details;
                    db.companies.RemoveRange(tabmanual_journal_entry);
                    db.SaveChanges();

                    var longin_table =
   from details in db.logins
   where details.company_id == company_id
   select details;
                    db.logins.RemoveRange(longin_table);
                    db.SaveChanges();
                    transaction.Commit();

                    return Request.CreateResponse(HttpStatusCode.OK, "Deleted");
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound, "Not Found");
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }

    }
}