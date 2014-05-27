using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Collinson.Web.Controllers
{
    public class LoginController : Controller
    {
        //
        // GET: /Login/

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(LoginModel model)
        {
            if (model.Username == ConfigurationManager.AppSettings["Username"] && model.Password == ConfigurationManager.AppSettings["Password"])
            {
                ViewData["IsAuthenticated"] = true;
                return RedirectToAction("Index", "Dashboard");
            }

            ViewData["IsAuthenticated"] = false;
            return View();
        }
    }

    public class LoginModel
    {
        public string Username { get; set; }

        public string Password { get; set; }
    }
}
