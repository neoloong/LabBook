using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook.Manage
{
    /// <summary>
    /// AddPackage 的摘要说明
    /// </summary>
    public class AddPackage : IHttpHandler
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CoursePackage Package;

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            #region 检查输入是否完整且合法。

            //实验包名称。
            if (context.Request.Form["name"].isNullorWhiteSpace())
            {
                context.Response.Write("实验包名称不能为空");
                return;
            }

            //实验地点。
            if (context.Request.Form["address"].isNullorWhiteSpace())
            {
                context.Response.Write("实验地点不能为空！");
                return;
            }

            //学时。
            if (context.Request.Form["classHour"].isNullorWhiteSpace())
            {
                context.Response.Write("学时不能为空！");
                return;
            }



            //指导老师。
            if (context.Request.Form["teacherId"].isNullorWhiteSpace())
            {
                context.Response.Write("指导老师不能为空！");
                return;
            }


            #endregion


            if (context.Request.Form["packageId"].isNullorWhiteSpace())
            {
                Package = new CoursePackage     //课程包添加。
                {
                    ExperimentInfo = LabDB.ExperimentInfo.SingleOrDefault(d => d.Id.ToString() == context.Request.Form["experimentId"]),

                };

                LabDB.CoursePackage.InsertOnSubmit(Package);
            }
            else       //课程包修改。
            {
                Package = LabDB.CoursePackage.SingleOrDefault(d => d.Id.ToString() == context.Request.Form["packageId"]);
                foreach (var packageList in Package.PackagedCourse)
                {
                    LabDB.PackagedCourse.DeleteOnSubmit(packageList);
                }

            }


            Package.Name = context.Request.Form["name"];
            Package.ClassHour = Convert.ToByte(context.Request.Form["classHour"]);
            Package.TeacherInfo = LabDB.TeacherInfo.SingleOrDefault(d => d.Id.ToString() == context.Request.Form["teacherId"]);
            Package.Address = context.Request.Form["address"];



            foreach (var item in context.Request.Form)
            {
                if (Common.RegexValidate("^[0-9]*$", item.ToString()))
                {
                    PackagedCourse packageList = new PackagedCourse
                    {
                        CourseInfo = LabDB.CourseInfo.SingleOrDefault(d => d.Id.ToString() == item.ToString()),
                        CoursePackage = Package,
                    };

                    LabDB.PackagedCourse.InsertOnSubmit(packageList);
                }
            }

            //LabDB.CoursePackage.InsertOnSubmit(Package);

            try
            {
                LabDB.SubmitChanges();
                context.Response.Write("1");
            }
            catch (Exception ex)
            {
                context.Response.Write("错误！" + ex.Message);
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