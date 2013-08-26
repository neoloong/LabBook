using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using System.Web.SessionState;



namespace LabBook
{
    /// <summary>
    /// BookingPackage 的摘要说明
    /// </summary>
    public class BookingPackage : IHttpHandler, IRequiresSessionState
    {

        LabBookDBDataContext LabDB = new LabBookDBDataContext();


        protected StudentInfo Student
        {
            get;
            set;
        }


        public void ProcessRequest(HttpContext context)
        {
            Account  user = (Account)context.Session["sid"];
            Student = LabDB.StudentInfo.SingleOrDefault(d => d.AccountId == user.Id);

            


            PackageBookInfo bookInfo = new PackageBookInfo
            {
                StudentInfo=Student,
                PackageArrangeId = Convert.ToInt32(context.Request.QueryString["arrangeid"].Trim()),
                BookTime = DateTime.Now,
                UserAgent = context.Request.UserAgent.ToString(),
            };


            context.Response.ContentType = "text/plain";

            try
            {
                if (LabDB.PackageBookInfo.FirstOrDefault(d => d.PackageArrangeId == bookInfo.PackageArrangeId && d.StudentId == bookInfo.StudentId) != null)
                {
                    throw (new Exception("已经预约！不能再次预约！"));
                }

                LabDB.PackageBookInfo.InsertOnSubmit(bookInfo);
                LabDB.SubmitChanges();
                context.Response.Write("1");

            }

            catch (Exception ex)
            {
                context.Response.Write("预约失败！请联系管理员！" );
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