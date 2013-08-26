using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook.Manage
{
    /// <summary>
    /// DeleteStudent 的摘要说明
    /// </summary>
    public class DeleteStudent : IHttpHandler
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            StudentInfo student = LabDB.StudentInfo.SingleOrDefault(d => d.Id.ToString() == context.Request.QueryString["id"]);

            LabDB.StudentInfo.DeleteOnSubmit(student);


            try
            {
                LabDB.SubmitChanges();
                context.Response.Write("1");
            }

            catch
            {
                context.Response.Write("0");

            }
            LabDB.Connection.Close();


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