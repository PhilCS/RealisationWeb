using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace projet_mozambique.Utilitaires
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, Inherited = true, AllowMultiple = true)]
    public class AccessDeniedAuthorizeAttribute : AuthorizeAttribute
    {
         protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
         {
             if (filterContext.HttpContext.Request.IsAuthenticated)
             {
                 //filterContext.Result = new HttpStatusCodeResult((int)System.Net.HttpStatusCode.Forbidden);
                 UrlHelper urlHelper = new UrlHelper(filterContext.RequestContext);
                 filterContext.Result = new RedirectResult(urlHelper.Action("HttpError403", "Error"));
             }
             else
             {
                 base.HandleUnauthorizedRequest(filterContext);
             }
         }
     }

    /*public class AccessDeniedAuthorizeAttribute : AuthorizeAttribute
    {
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);

            if (filterContext.Result is HttpUnauthorizedResult)
            {
                UrlHelper urlHelper = new UrlHelper(filterContext.RequestContext);
                filterContext.Result = new RedirectResult(urlHelper.Action("HttpError403", "Error"));
            }
        }
    }*/
}