using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class AddBulletin : System.Web.UI.Page
    {
        //protected string Message = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.HttpMethod == "POST")
            {
                if (Request.Form["Title"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('公告标题不能为空！');</script>");
                    return;
                } if (Request.Form["Bulletiner"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('发布人不能为空！');</script>");
                    return;
                }
                if (Request.Form["editorValue"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('公告内容不能为空！');</script>");
                    return;
                }

                try
                {
                    Bulletin bulletin = new Bulletin
                    {
                        Title = Request.Form["Title"].Trim(),
                        Bulletiner = Request.Form["Bulletiner"].Trim(),
                        Content = Request.Form["editorValue"],
                        Date = DateTime.Now,
                    };

                    using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
                    {
                        LabDB.Bulletin.InsertOnSubmit(bulletin);
                        LabDB.SubmitChanges();
                    }

                     Response.Redirect("../Bulletin.aspx?id="+bulletin.Id);
                }
                catch (Exception ex)
                {
                    Response.Write("<script type=\"text/javascript\"> alert('" + ex.Message + "');</script>");
                    return;
                }

               
            }

        }
    }
}