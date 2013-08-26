using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Text.RegularExpressions;
using System.Web.Script.Serialization;

using System.Web.SessionState;

namespace LabBook
{
    /// <summary>
    /// RefreshArranges 的摘要说明
    /// </summary>
    public class RefreshArranges : IHttpHandler,IRequiresSessionState
    {
        protected  LabBookDBDataContext LabDB = new LabBookDBDataContext();

        public void ProcessRequest(HttpContext context)
        {
            //获取星期。
            //Regex regex = new Regex(@"\d");
            //var match = regex.Match(context.Request.QueryString["week"]);
            int week = Convert.ToInt32(context.Request.QueryString["week"]);

            //获取星期几。
            int weekday = Convert.ToInt32(context.Request.QueryString["weekday"]);

            //获取课程Id;
            string id = context.Request.QueryString["id"];

            //获取当前学生信息。
            StudentInfo student = LabDB.StudentInfo.SingleOrDefault(d => d.Account == (Account)context.Session["sid"]);

            //CourseInfo course = LabDB.CourseInfo.SingleOrDefault(d => d.Id.ToString() == id);
            IEnumerable<CourseArrange> arranges = LabDB.CourseArrange.Where(d => d.CourseId.ToString() == id && d.Week == week && d.WeekDay == weekday).OrderBy(d => d.Week).ThenBy(d => d.WeekDay);
            List<ArrangeToShow> CourseArranges = new List<ArrangeToShow>();
            foreach (var arrange in arranges)
            {
                CourseArranges.Add(new ArrangeToShow()
                {
                    Id = arrange.Id,
                    //Week = arrange.Week,
                    //WeekDay = arrange.WeekDay,
                    Capacity = arrange.Capacity,
                    BeginLesson = arrange.BeginLesson,
                    EndLesson = arrange.EndLesson,
                    HaveBookedNum = LabDB.CourseBookInfo.Count(d => d.CourseArrangeId == arrange.Id),
                    CanBook=CanBeBooked(arrange,student),
                });
            }



            //System.Threading.Thread.Sleep(2000);    //测试前台loading效果用。


            //实例化json序列化对象。
            JavaScriptSerializer JsonSerializer = new JavaScriptSerializer();


            //将数据返回到Select.aspx。
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonSerializer.Serialize(CourseArranges));


        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        
        protected bool CanBeBooked(CourseArrange arrange, StudentInfo student)
        {
            if (student == null || arrange == null || arrange.Capacity <= arrange.CourseBookInfo.Count || IsBooked(student, arrange.CourseInfo))
                return false;
            else return true;
        }

        
        protected bool IsBooked(StudentInfo student, CourseInfo course)
        {
            if (LabDB.CourseBookInfo.FirstOrDefault(d => d.StudentInfo == student && d.CourseArrange.CourseInfo == course) != null)
                return true;
            else return false;
        }


        /// <summary>
        /// 课程安排的UI模型。
        /// </summary>
        public class ArrangeToShow
        {
            public int Id;

            //public int Week;

            //public int WeekDay;

            public int Capacity;

            public int BeginLesson;

            public int EndLesson;

            /// <summary>
            /// 已经预约的人数。
            /// </summary>
            public int HaveBookedNum;

            /// <summary>
            /// 是否可以预约。
            /// </summary>
            public bool CanBook;
        }
    }
}