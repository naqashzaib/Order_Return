using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using TechnoPurAccounts.Models;

namespace TechnoPurAccounts.Controllers
{
    public class ReturnOrdersController : ApiController
    {
        private return_orderEntities1 db = new return_orderEntities1();



        [Route("api/ReturnDelete")]
        [HttpDelete]
        public IHttpActionResult Deletebrand(int id)
        {
            returns_order brand = db.returns_order.Find(id);
            if (brand == null)
            {
                return NotFound();
            }
            db.returns_order.Remove(brand);
            db.SaveChanges();
            return Ok(brand);
        }
        [Route("api/ReturnInsert")]
        [HttpPost]
        public HttpResponseMessage GetCompanyInsert([FromBody] ClsReturn objclsCompanyInsert)
        {
            var identity = (ClaimsIdentity)User.Identity;
            int login_id;
            try { var login_id1 = (identity.Claims.FirstOrDefault(c => c.Type == "login_id").Value); login_id = Convert.ToInt16(login_id1); } catch (Exception) { login_id = 0; }

            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {
                DateTime today = DateTime.Today;
                returns_order objcompany = new returns_order();
                objcompany.company_id = objclsCompanyInsert.company_id;
                objcompany.customer_name = objclsCompanyInsert.customer_name;
                objcompany.rma = objclsCompanyInsert.rma;
                objcompany.note = objclsCompanyInsert.note;
                objcompany.attachment = objclsCompanyInsert.attachment;
                objcompany.created_datetime = objclsCompanyInsert.created_time;
                objcompany.modified_datetime = objclsCompanyInsert.created_time;
                objcompany.status = "Open";
                objcompany.created_by = login_id;
                objcompany.modified_by = login_id;
                db.returns_order.Add(objcompany);
                db.SaveChanges();


                return_actions ra = new return_actions();
                ra.status = "Open";
                ra.reaturn_id = objcompany.reaturn_order_id;
                ra.created_datetime = objclsCompanyInsert.created_time;
                ra.attachment = objclsCompanyInsert.attachment;
                ra.created_by = login_id;
                ra.note = "New Return Opened";
                db.return_actions.Add(ra);
                db.SaveChanges();

                transaction.Commit();
                return Request.CreateResponse(HttpStatusCode.OK, objcompany.reaturn_order_id);

            }
            catch (Exception ex)
            {
                transaction.Rollback();
                var message = Request.CreateResponse(HttpStatusCode.InternalServerError);
                return message;
            }
        }


        [Route("api/GetReturns")]
        [HttpGet]
        public HttpResponseMessage GetCompany()
        {
            DbContextTransaction transaction = db.Database.BeginTransaction();
            try
            {
                var query = from c1 in db.returns_order
                            join e in db.companies on c1.company_id equals e.company_id
                            select new {

                               c1,e.name

                            };
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

    }
}
