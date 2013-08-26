using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using System.Web.Script.Serialization;

namespace LabBook
{
    /// <summary>
    /// RefreshPackageArranges 的摘要说明
    /// </summary>
    public class RefreshPackageArranges : IHttpHandler
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        public void ProcessRequest(HttpContext context)
        {          

            //获取课程包Id;
            string id = context.Request.QueryString["packageId"];

            IEnumerable<PackageArrange> arranges = LabDB.PackageArrange.Where(d => d.CoursePackageId.ToString() == id );



            //List<ArrangeToShow> packageArranges = new List<ArrangeToShow>();
            //foreach (var arrange in arranges)
            //{
            //    packageArranges.Add(new ArrangeToShow()
            //    {
            //        Id = arrange.Id,
                    
            //        Capacity = arrange.Capacity,
                    
            //        HaveBookedNum = LabDB.CourseBookInfo.Count(d => d.CourseArrangeId == arrange.Id)
            //    });
            //}



            //System.Threading.Thread.Sleep(2000);    //测试前台loading效果用。


            //实例化json序列化对象。
            JavaScriptSerializer JsonSerializer = new JavaScriptSerializer();


            //将数据返回到Select.aspx。
            context.Response.ContentType = "text/plain";
            //context.Response.Write(JsonSerializer.Serialize(CourseArranges));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        /// <summary>
        /// 课程包安排的UI模型。
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
        }
    }
}