using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook.Manage
{
    /// <summary>
    /// DeleteTeacher 的摘要说明
    /// </summary>
    public class DeleteTeacher : IHttpHandler
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            TeacherInfo teacher = LabDB.TeacherInfo.SingleOrDefault(d => d.Id.ToString() == context.Request.QueryString["id"]);

            LabDB.TeacherInfo.DeleteOnSubmit(teacher);


            try
            {
                LabDB.SubmitChanges();
                context.Response.Write("1");
            }

            catch
            {
                context.Response.Write("0");
                    
            }
            //string str=context.Request.QueryString["id"];
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