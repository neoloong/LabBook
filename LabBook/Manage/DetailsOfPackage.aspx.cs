using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class DetailsOfPackage : System.Web.UI.Page
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CoursePackage Package
        {
            get
            {
                return LabDB.CoursePackage.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["packageId"]);
            }
        }


        protected List<CourseInfo> CourseList
        {
            get
            {
                var packageList = LabDB.PackagedCourse.Where(d => d.PackageId == Package.Id);
                List<CourseInfo> courseList = new List<CourseInfo>();
                foreach (var package in packageList)
                {
                    courseList.Add(LabDB.CourseInfo.SingleOrDefault(d => d.Id == package.CourseId));

                }
                return courseList;
                //return LabDB.CourseInfo.Where(d => d.PackageList == Package.PackageList);

            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}