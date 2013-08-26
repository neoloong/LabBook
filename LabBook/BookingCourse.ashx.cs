using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook
{
    /// <summary>
    /// BookingCourse 的摘要说明
    /// </summary>
    public class BookingCourse : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            try
            {
                using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
                {

                    string arrangeId = context.Request.QueryString["arrangeid"].Trim();
                    string studentId = context.Request.QueryString["studentid"].Trim();

                    //检查是否已经预约满。
                    if (LabDB.CourseBookInfo.Where(d => d.CourseArrangeId.ToString() == arrangeId).Count() >= LabDB.CourseArrange.FirstOrDefault(d => d.Id.ToString() == arrangeId).Capacity)
                    {
                        throw (new Exception("此实验已经预约满！"));
                    }

                    //检查是否已经预约过。
                        if (LabDB.CourseBookInfo.FirstOrDefault(d => d.CourseArrangeId.ToString() == arrangeId && d.StudentId == studentId) != null)
                    {
                        throw(new Exception("此实验你已经预约过！不能重复预约同一实验！"));
                    }
                    CourseBookInfo courseBookInfo = new CourseBookInfo
                    {
                        StudentId = context.Request.QueryString["studentid"],
                        CourseArrangeId = Convert.ToInt32(context.Request.QueryString["arrangeid"].Trim()),
                        BookTime=DateTime.Now,
                        UserAgent=context.Request.UserAgent.ToString(),
                    };

                    

                    LabDB.CourseBookInfo.InsertOnSubmit(courseBookInfo);
                    LabDB.SubmitChanges();

                }
                context.Response.Write("1");
            }

            catch(Exception ex)
            {
                context.Response.Write(ex.Message);
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