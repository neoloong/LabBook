using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook.Manage
{
    /// <summary>
    /// DeleteCourseArrange 的摘要说明
    /// </summary>
    public class DeleteCourseArrange : IHttpHandler
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        

        public void ProcessRequest(HttpContext context)
        {

            context.Response.ContentType = "text/plain";

            CourseArrange arrange = LabDB.CourseArrange.SingleOrDefault(d=>d.Id.ToString()==context.Request["arrangeId"]);

            LabDB.CourseArrange.DeleteOnSubmit(arrange);

            try
            {
                LabDB.SubmitChanges();
            }
            catch (Exception ex)
            {
                //删除失败返回错误信息。
                context.Response.Write(ex.Message);
                return;
            }

            //删除成功返回1。
            context.Response.Write("1");
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