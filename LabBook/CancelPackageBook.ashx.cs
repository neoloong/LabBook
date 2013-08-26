using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.SessionState;

namespace LabBook.Manage
{
    /// <summary>
    /// CancelPackageBook 的摘要说明
    /// </summary>
    public class CancelPackageBook : IHttpHandler,IRequiresSessionState
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            StudentInfo student = LabDB.StudentInfo.SingleOrDefault(d => d.Account == (Account)context.Session["sid"]);

            PackageBookInfo bookInfo = LabDB.PackageBookInfo.SingleOrDefault(d => d.PackageArrangeId.ToString() == context.Request.QueryString["arrangeId"]);

            LabDB.PackageBookInfo.DeleteOnSubmit(bookInfo);

            try
            {
                LabDB.SubmitChanges();
                context.Response.Write("1");
            }

            catch {
                context.Response.Write("0");
            }
           
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}