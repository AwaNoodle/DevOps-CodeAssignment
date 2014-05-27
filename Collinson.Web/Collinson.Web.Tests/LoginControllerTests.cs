using System.Diagnostics;
using System.Web.Mvc;
using Collinson.Web.Controllers;
using NUnit.Framework;

namespace Collinson.Web.Tests
{
    [TestFixture]
    public class LoginControllerTests
    {
        [Test]
        public void RedirectsToLoginPageOnFailedValidation()
        {
            var loginController = new LoginController();
            var result = loginController.Index(new LoginModel()) as ViewResult;

            Assert.That(result.ViewData["IsAuthenticated"], Is.False);
        }

        [Test]
        public void RedirectsToDashboardPageOnFailedValidation()
        {
            var loginController = new LoginController();
            var result = loginController.Index(new LoginModel
                {
                    Username = "john.smith",
                    Password = "password"
                }) as RedirectToRouteResult;

            Assert.That(result, Is.Not.Null);
            Assert.That(result.RouteValues["action"], Is.EqualTo("Index"));
            Assert.That(result.RouteValues["controller"], Is.EqualTo("Dashboard"));
        }
    }
}
