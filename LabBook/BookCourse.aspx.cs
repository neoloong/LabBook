using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class Reservation : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CourseInfo Course
        {
            get
            {
                return LabDB.CourseInfo.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["id"]);
            }
        }

        protected StudentInfo Student
        {
            get
            {
                //通过缺省值的设定，使老师也能访问这个页面
                return LabDB.StudentInfo.SingleOrDefault(d => d.Account == (Account)Session["sid"]) ?? new StudentInfo();
            }
        }

        protected bool IsBooked
        {
            get
            {
                if (LabDB.CourseBookInfo.FirstOrDefault(d => d.StudentInfo == Student && d.CourseArrange.CourseInfo == Course) != null)
                    return true;
                else
                    return false;
            }
        }
     

        protected void Page_Load(object sender, EventArgs e)
        {

        }

    }
}