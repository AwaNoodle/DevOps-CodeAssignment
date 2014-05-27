using System.Web.Mvc;
using System.Web.UI.WebControls;

namespace Collinson.Web.Controllers
{
    public class DashboardController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}