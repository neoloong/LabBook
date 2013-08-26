using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Script.Serialization;

namespace LabBook
{
    /// <summary>
    /// RefreshPackageTable 的摘要说明
    /// </summary>
    public class RefreshPackageTable : IHttpHandler
    {
        protected LabBookDBDataContext LabDB =new LabBookDBDataContext();

        public void ProcessRequest(HttpContext context)
        {
            var experiment = LabDB.ExperimentInfo.SingleOrDefault(d => d.Id.ToString() == context.Request.QueryString["exp"]);

            

            IEnumerable<CoursePackage> SelectPackages = LabDB.CoursePackage.Where(d => d.ExperimentId == experiment.Id);
            List<PackageToShow> Packages = new List<PackageToShow>();
            foreach (var package in SelectPackages)
            {
                Packages.Add(new PackageToShow()
                {
                    Name = package.Name,
                    TeacherName = package.TeacherId==null?"暂无":package.TeacherInfo.Name,
                    Address = package.Address,
                    Id=package.Id,

                });
            }

            JavaScriptSerializer JsonSerializer = new JavaScriptSerializer();
            context.Response.ContentType = "text/plain";
            context.Response.Write(JsonSerializer.Serialize(Packages));


        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }


        /// <summary>
        /// 实验包UI模型。
        /// </summary>
        protected class PackageToShow
        {
            public string Name;

            public string TeacherName;

            public string Address;

            public int Id;
        }
    }
}