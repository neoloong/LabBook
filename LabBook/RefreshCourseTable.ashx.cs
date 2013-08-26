using System.Collections.Generic;
using System.Linq;
using System.Web;


using System.Web.Script.Serialization;

namespace LabBook
{
    /// <summary>
    /// RefreshCourseTable 的摘要说明
    /// </summary>
    public class RefreshCourseTable : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var LabDB = new LabBookDBDataContext();
            var experiment = LabDB.ExperimentInfo.SingleOrDefault(d => d.Id.ToString() == context.Request.QueryString["key"]);

            

            if (experiment == null)
            {
                return;
            }

            IEnumerable<CourseInfo> SelectCourses = LabDB.CourseInfo.Where(d => d.ExperimentId == experiment.Id);

            //将取出的数据填充UI模型中。
            List<CourseToShow> Courses = new List<CourseToShow>();

            foreach (var course in SelectCourses)
            {
                Courses.Add(new CourseToShow()
                {                    
                    Name = course.Name,
                    TeacherName = course.TeacherId==null?"暂无":course.TeacherInfo.Name,
                    Address = course.Address,
                    Id=course.Id,
                });     
                
            }           


            //实例化json序列化对象。
            JavaScriptSerializer JsonSerializer = new JavaScriptSerializer();
           
          
            //将数据返回到Select.aspx。
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonSerializer.Serialize(Courses));

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        /// <summary>
        /// 实验课程的UI模型。
        /// </summary>
        protected class CourseToShow
        {            
            public string Name;

            public string TeacherName;

            public string Address;

            public int Id;
        }




    }
}