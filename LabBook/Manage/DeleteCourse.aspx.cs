using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class DeleteCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            try
            {
                using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
                {
                    CourseInfo course = LabDB.CourseInfo.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["courseId"]);

                    LabDB.CourseInfo.DeleteOnSubmit(course);
                    LabDB.SubmitChanges();

                    Response.Write("<script type=\"text/javascript\"> alert('删除成功！');</script>");
                    Response.Write("<script type=\"text/javascript\">window.location='CourseManage.aspx?id="+Request.QueryString["experimentId"]+"';</script>");
                }

            }
            catch
            {
                Response.Write("<script type=\"text/javascript\"> alert('发生错误！删除失败！请联系管理员。');</script>");
                Response.Write("<script type=\"text/javascript\">window.location='CourseManage.aspx?id="+Request.QueryString["experimentId"]+"';</script>");
            }
        }
    }
}