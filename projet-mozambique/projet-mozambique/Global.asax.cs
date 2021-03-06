﻿using System;
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
using projet_mozambique.Models;
using projet_mozambique.Controllers;

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
            string langName;
            List<SECTEUR> lstS = new List<SECTEUR>();
            //It's important to check whether session object is ready
            if (HttpContext.Current.Session != null)
            {
                ci = (CultureInfo)this.Session["Culture"];

                /*langName = HttpContext.Current.Request.Cookies.Get("lang").Value;
                ci = new CultureInfo(langName);

                if (ci != null && langName.Equals(ci.Name))
                    ci = ciCookie;

                if (ci == null)
                    ci = ciCookie;

                HttpContext.Current.Request.Cookies.Get("lang").Value = ci.Name;

                this.Session["Culture"] = ci;*/
                
                //Checking first if there is no value in session 
                //and set default language 
                //this can happen for first user's request
                if (ci == null)
                {
                    /*if (HttpContext.Current.Request.Cookies.AllKeys.Contains("lang"))
                    {
                        langName = HttpContext.Current.Request.Cookies["lang"].Value;
                    }
                    else
                    {*/
                        //Sets default culture to french
                        langName = "fr";

                        /*HttpCookie cookie = new HttpCookie("lang");
                        cookie.Expires = DateTime.Now.AddMonths(3);
                        cookie.Value = ci.Name;
                        HttpContext.Current.Response.AppendCookie(cookie);*/
                    //}
                    
                    //Try to get values from Accept lang HTTP header
                    /*if (HttpContext.Current.Request.UserLanguages != null &&
                    HttpContext.Current.Request.UserLanguages.Length != 0)
                    {
                        //Gets accepted list 
                        langName = HttpContext.Current.Request.UserLanguages[0].Substring(0, 2);
                    }*/

                    ci = new CultureInfo(langName);
                    this.Session["Culture"] = ci;
                /*}
                else
                {
                    if (HttpContext.Current.Request.Cookies.AllKeys.Contains("lang"))
                    {
                        HttpCookie c = HttpContext.Current.Request.Cookies["lang"];
                        c.Value = ci.Name;
                        HttpContext.Current.Response.SetCookie(c);
                    }
                    */
                }

                Entities db = new Entities();

                if (Request.IsAuthenticated)
                {
                    var currentUser = db.UTILISATEUR.SingleOrDefault(u => u.NOMUTIL == User.Identity.Name);

                    if (currentUser != null)
                    {
                        DateTime currentDate = DateTime.Now;

                        var sectUtil = from s in db.UTILISATEURSECTEUR
                                        where s.IDUTILISATEUR == currentUser.ID && s.DEBUTACCES <= currentDate
                                        && s.FINACCES >= currentDate
                                        select s;

                        lstS = null;

                        int cookieValue = 0;
                        bool currentExist = false;
                        if (HttpContext.Current.Request.Cookies["currentSect"] != null)
                        {
                            cookieValue = int.Parse(HttpContext.Current.Request.Cookies["currentSect"].Value);

                        }

                        if (sectUtil.FirstOrDefault() != null)
                        {
                            lstS = new List<SECTEUR>();

                            foreach (var su in sectUtil)
                            {
                                lstS.Add(su.SECTEUR);

                                if (su.SECTEUR.ID == cookieValue)
                                    currentExist = true;
                            }
                        }

                        this.Session["lstSect"] = lstS;

                        if (lstS == null)
                        {
                            this.Session["currentSecteur"] = 0;
                        }
                        else
                        {
                            if (currentExist && cookieValue != 0)
                                this.Session["currentSecteur"] = cookieValue;
                            else
                                this.Session["currentSecteur"] = lstS.First().ID;
                        }
                    }
                }
               
                /*HttpCookie cookie = new HttpCookie("lang");
                cookie.Expires = DateTime.Now.AddMonths(3);
                cookie.Value = ci.Name;
                HttpContext.Current.Request.Cookies.Add(cookie);*/
                
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

            RouteData routeData = new RouteData();
            routeData.Values.Add("controller", "Error");

            if (httpException == null)
            {
                routeData.Values.Add("action", "Index");
            }
            else
            {
                string action;

                switch (httpException.GetHttpCode())
                {
                    case 403:
                        // access denied
                        action = "HttpError403";
                        break;
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

                routeData.Values.Add("action", action);
            }

            // Pass exception details to the target error View.
            routeData.Values.Add("error", exception);

            // Clear the error on server.
            Server.ClearError();

            // Avoid IIS7 getting in the middle
            Response.TrySkipIisCustomErrors = true;

            Response.StatusCode = httpException.GetHttpCode();

            // Call target Controller and pass the routeData.
            IController errorController = new ErrorController();
            errorController.Execute(new RequestContext(new HttpContextWrapper(Context), routeData));
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            if (HttpContext.Current.Request.Cookies["lang"] != null)
            {
                CultureInfo ci = new CultureInfo(HttpContext.Current.Request.Cookies["lang"].Value);
                
                this.Session["Culture"] = ci;
            }

            Entities db = new Entities();

            if(Request.IsAuthenticated)
            {
                var currentUser = db.UTILISATEUR.SingleOrDefault(u => u.NOMUTIL == User.Identity.Name);

                if (currentUser != null)
                {
                    DateTime currentDate = DateTime.Now;

                    var sectUtil = from s in db.UTILISATEURSECTEUR
                                   where s.IDUTILISATEUR == currentUser.ID && s.DEBUTACCES <= currentDate
                                   && s.FINACCES >= currentDate
                                   select s;

                    List<SECTEUR> lstS = null;

                    int cookieValue = 0;
                    bool currentExist = false;
                    if (HttpContext.Current.Request.Cookies["currentSect"] != null)
                    {
                        cookieValue = int.Parse(HttpContext.Current.Request.Cookies["currentSect"].Value);

                    }

                    if (sectUtil.FirstOrDefault() != null)
                    {
                        lstS = new List<SECTEUR>();

                        foreach (var su in sectUtil)
                        {
                            lstS.Add(su.SECTEUR);

                            if (su.SECTEUR.ID == cookieValue)
                                currentExist = true;
                        }
                    }

                    this.Session["lstSect"] = lstS;

                    if (lstS == null)
                    {
                        this.Session["currentSecteur"] = 0;
                    }
                    else
                    {
                        if (currentExist && cookieValue != 0)
                            this.Session["currentSecteur"] = cookieValue;
                        else
                            this.Session["currentSecteur"] = lstS.First().ID;
                    }
                }
            }
            

            /*if(HttpContext.Current.Request.Cookies["lstSect"] != null)
            {
                Dictionary<int, string> lstSect = new Dictionary<int, string>();

                string[] cookieStr = HttpContext.Current.Request.Cookies["lstSect"].Value.Split('&');

                for(int i = 0; i < cookieStr.Length; i++)
                {
                    string[] strSplit = cookieStr[i].Split(',');
                    int idSecteur = int.Parse(strSplit[0]);
                    lstSect.Add(idSecteur, strSplit[1]);
                }

                this.Session["lstSect"] = lstSect;
            }*/

        }

        protected void Session_End(object sender, EventArgs e)
        {
            // event is raised when a session is abandoned or expires
        }
    }
}