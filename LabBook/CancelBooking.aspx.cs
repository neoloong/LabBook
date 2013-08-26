using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class CancelBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
                {
                    CourseBookInfo courseBookInfo = LabDB.CourseBookInfo.SingleOrDefault(d => d.CourseArrangeId.ToString() == Request.QueryString["arrangeId"].Trim() && d.StudentId == Request.QueryString["studentId"].Trim());
                    LabDB.CourseBookInfo.DeleteOnSubmit(courseBookInfo);
                    LabDB.SubmitChanges();
                }
            }
            catch { }

            //Response.Redirect("IndividualCenter.aspx");

            Response.Write("<script type=\"text/javascript\">alert(\"取消成功\");</script>");
            Response.Write(" <script> window.location.href= 'OrderState.aspx ' </script> ");

        }
    }
}