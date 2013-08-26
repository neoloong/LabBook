using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Script.Serialization;

namespace LabBook.Manage
{
    /// <summary>
    /// RefreshStudentList 的摘要说明
    /// </summary>
    public class RefreshStudentList : IHttpHandler
    {
        //protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected List<Student> StudentList;
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            StudentList = new List<Student>();
            using (LabBookDBDataContext db = new LabBookDBDataContext())
            {
                List<StudentInfo> students=null;
                if (context.Request.QueryString["class"] == "all")
                {
                    students = db.StudentInfo.Take(50).ToList();
                }
                else
                {
                    students = db.StudentInfo.Where(d => d.Class == context.Request.QueryString["class"]).ToList();
                }
                foreach (var student in students)
                {
                    StudentList.Add(new Student
                    {
                        Id = student.Id,
                        Name = student.Name,
                        Sex = (student.Sex ? "男" : "女"),
                        College=student.College,
                        Class=student.Class,
                        Tel=student.PhoneNumber==null?"暂缺":student.PhoneNumber
                    });
                }
            }

            //实例化json序列化对象。
            JavaScriptSerializer JsonSerializer = new JavaScriptSerializer();


            //将数据返回到StudentManage.aspx。
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonSerializer.Serialize(StudentList));
        }

        protected class Student
        {
            public string Id;
             
            public string Name;
             
            public string Sex;
          
            public string College;
      
            public string Class;

            public string Tel;


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