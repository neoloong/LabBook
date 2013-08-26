using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class AddNewTerm : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                Semester newTerm = new Semester
                {
                    SchoolYear = Request.Form["SchoolYear"],
                    Season = Request.Form["Season"],
                };

                LabDB.Semester.InsertOnSubmit(newTerm);
                try
                {
                    LabDB.SubmitChanges();
                }
                catch (Exception ex)
                {
                    Response.Write("<script type=\"text/javascript\"> alert('添加数据时发生错误！请重试或联系管理员！');</script>");
                    return;
                }

                Response.Write("<script type=\"text/javascript\"> alert('添加成功！');</script>");
                Response.Write("<script type=\"text/javascript\"> window.location='ExperimentManage.aspx'</script>");
            }

        }
    }
}