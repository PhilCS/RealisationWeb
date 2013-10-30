using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using projet_mozambique.Utilitaires;
using WebMatrix.WebData;
using WebMatrix.Data;
using System.Globalization;

namespace projet_mozambique
{
    // Remarque : pour obtenir des instructions sur l'activation du mode classique IIS6 ou IIS7, 
    // visitez http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            WebSecurity.InitializeDatabaseConnection("DefaultConnection", "UTILISATEUR", "ID", "NOMUTIL", true);

        }

        protected void Application_AcquireRequestState(object sender, EventArgs e)
        {
            CultureInfo ci;
            CultureInfo ciCookie;
            string langName;
            //It's important to check whether session object is ready
            if (HttpContext.Current.Session != null)
            {
                ci = (CultureInfo)this.Session["Culture"];

                if (HttpContext.Current.Request.Cookies.AllKeys.Contains("lang"))
                {
                    langName = HttpContext.Current.Request.Cookies.Get("lang").Value;
                    ciCookie = new CultureInfo(langName);

                    if (ci != null && langName.Equals(ci.Name))
                        ci = ciCookie;

                    if (ci == null)
                        ci = ciCookie;

                    HttpContext.Current.Request.Cookies.Get("lang").Value = ci.Name;


                    this.Session["Culture"] = ci;
                }
                else
                {
                    //Checking first if there is no value in session 
                    //and set default language 
                    //this can happen for first user's request
                    if (ci == null || ci.Name.Equals("fr") == false || ci.Name.Equals("pt") == false)
                    {
                        //Sets default culture to french
                        langName = "fr";

                        //Try to get values from Accept lang HTTP header
                        /*if (HttpContext.Current.Request.UserLanguages != null &&
                        HttpContext.Current.Request.UserLanguages.Length != 0)
                        {
                            //Gets accepted list 
                            langName = HttpContext.Current.Request.UserLanguages[0].Substring(0, 2);
                        }*/

                        ci = new CultureInfo(langName);
                        this.Session["Culture"] = ci;
                    }

                    HttpCookie cookie = new HttpCookie("lang");
                    cookie.Expires = DateTime.Now.AddMonths(3);
                    cookie.Value = ci.Name;
                    HttpContext.Current.Request.Cookies.Add(cookie);
                }

                //Finally setting culture for each request
                System.Threading.Thread.CurrentThread.CurrentUICulture = ci;
                System.Threading.Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(ci.Name);
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception exception = Server.GetLastError();
            Response.Clear();

            HttpException httpException = exception as HttpException;

            if (httpException != null)
            {
                string action;

                switch (httpException.GetHttpCode())
                {
                    case 404:
                        // page not found
                        action = "HttpError404";
                        break;
                    case 500:
                        // server error
                        action = "HttpError500";
                        break;
                    default:
                        action = "General";
                        break;
                }

                // clear error on server
                Server.ClearError();
                Response.Redirect(String.Format("~/Error/{0}?message={1}", action, httpException.Message));
            }
        }
    }
}