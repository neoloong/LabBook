using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class ModifyBulletin : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected Bulletin BulletinToModify;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Request.QueryString["id"] != null)
            {
                try
                {
                    BulletinToModify = LabDB.Bulletin.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["id"]);
                    if (BulletinToModify == null)
                    {
                        Response.Write("<script type=\"text/javascript\"> alert('错误！该公告不存在!');</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script type=\"text/javascript\"> alert('错误！" + ex.Message + "');</script>");
                }
            }

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
                    BulletinToModify.Title = Request.Form["Title"].Trim();
                    BulletinToModify.Bulletiner = Request.Form["Bulletiner"];
                    BulletinToModify.Content = Request.Form["editorValue"];
                    BulletinToModify.Date = DateTime.Now;

                    LabDB.SubmitChanges();
                }
                catch (Exception ex)
                {
                    Response.Write("<script type=\"text/javascript\"> alert('" + ex.Message + "');</script>");
                    return;
                }

                Response.Redirect("../Bulletin.aspx?id="+BulletinToModify.Id);
            }

        }
    }
}