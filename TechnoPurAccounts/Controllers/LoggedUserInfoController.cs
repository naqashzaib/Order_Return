using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using TechnoPurAccounts.Models.UserAuthntication;

namespace TechnoPurAccounts.Controllers
{
    public class LoggedUserInfoController : ApiController
    {
        [System.Web.Http.Authorize(Roles = "SuperAdmin, Admin, Customer, Vendor")]
        [System.Web.Http.HttpGet]
        [System.Web.Http.Route("api/logged-user-info")]
        public IHttpActionResult GetResource2()
        {
            var identity = (ClaimsIdentity)User.Identity;
            var Email = identity.Claims
                      .FirstOrDefault(c => c.Type == "Email").Value;
            var status = "";
            try { status = (identity.Claims.FirstOrDefault(c => c.Type == "status").Value); } catch (Exception) { status = ""; }
            var type = "";
            try { type = (identity.Claims.FirstOrDefault(c => c.Type == "type").Value); } catch (Exception) { type = ""; }
            var role_name = (identity.Claims
                 .FirstOrDefault(c => c.Type == "role_name").Value);

            var role_id = (identity.Claims
            .FirstOrDefault(c => c.Type == "role_id").Value);

            var UserName = identity.Name;
            var loginId = (identity.Claims
                 .FirstOrDefault(c => c.Type == "login_id").Value);
            int chartId, logId;
            try { logId = Convert.ToInt16(loginId); } catch (Exception) { logId = 0; }
            UserLogin user = new UserLogin()
            {
                username = UserName,
                email = Email,
                role_name = role_name,
                role_id = Convert.ToInt32(role_id),
                login_id = logId,

            };
            return Ok(user);
        }
    }
}