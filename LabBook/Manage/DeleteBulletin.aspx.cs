using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class DeleteBulletin : System.Web.UI.Page
    {
        protected Bulletin BulletinToDelete;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
            {
                try
                {
                    BulletinToDelete = LabDB.Bulletin.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["id"]);
                    if (BulletinToDelete != null)
                    {
                        LabDB.Bulletin.DeleteOnSubmit(BulletinToDelete);
                        LabDB.SubmitChanges();
                        //Response.Write("<script type=\"text/javascript\"> alert('删除成功！');</script>");
                        //Response.Write("<script type=\"text/javascript\"> window.location='BulletinManage.aspx'</script>");
                        Response.Write("1");
                        //return;
                        //Response.Redirect("BulletinManage.aspx");

                    }

                }

                catch (Exception ex)
                {
                    //Response.Write("<script type=\"text/javascript\"> alert('"+ex.Message+"');</script>");
                    //Response.Write("<script type=\"text/javascript\"> window.location='BulletinManage.aspx'</script>");

                    Response.Write("0");
                    //return;
                    //Response.Redirect("BulletinManage.aspx");
                }
            }
        }
    }
}