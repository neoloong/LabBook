using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class DetailsOfCourse : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();


        protected CourseInfo Course
        {
            get
            {
                return LabDB.CourseInfo.SingleOrDefault(d=>d.Id.ToString()==Request.QueryString["courseId"]);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}