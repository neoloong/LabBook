using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class PackageModify : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CoursePackage Package
        {
            get
            {
                return LabDB.CoursePackage.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["packageId"]);
            }
        }

        protected IEnumerable<TeacherInfo> TeacherList
        {
            get
            {
                return LabDB.TeacherInfo.OrderBy(d => d.Id);
            }
        }

       

        protected IEnumerable<CourseInfo> AllCourseList
        {
            get
            {
                return LabDB.CourseInfo.Where(d => d.ExperimentId == Package.ExperimentId);
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}
