using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook.Manage
{
    /// <summary>
    /// DeleteTerm 的摘要说明
    /// </summary>
    public class DeleteTerm : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
            {
                try
                {

                    Semester term = LabDB.Semester.SingleOrDefault(d => d.Id.ToString() == context.Request.QueryString["id"]);
                    LabDB.Semester.DeleteOnSubmit(term);
                    LabDB.SubmitChanges();
                }
                catch (Exception ex)
                {
                    context.Response.Write("<script type=\"text/javascript\"> alert('发生错误！错误信息："+ex.Message+"');</script>");
                }
                context.Response.Write("删除成功！");
                
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