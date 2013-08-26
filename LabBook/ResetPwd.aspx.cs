using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class ResetPwd : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected StudentInfo Student;
        

        protected void Page_Load(object sender, EventArgs e)
        {
                            

            if (Request.HttpMethod == "POST")
            {
                Student = LabDB.StudentInfo.SingleOrDefault(d => d.Id == Request.Form["resetId"]);

                
                if (Student == null)
                {
                    Response.Redirect("Login.aspx");
                }

                if (Request.Form["NewPwd"].Length >= 4 && Request.Form["NewPwd"] == Request.Form["ConfirmPwd"])
                {
                    Student.Account.Password = Request.Form["NewPwd"].ToMD5();
                    LabDB.SubmitChanges();
                    Response.Write("<script type=\"text/javascript\">alert(\"修改成功！\");</script>");

                }
                else
                {
                    Response.Write("<script type=\"text/javascript\">alert(\"修改失败！请检查输入\");</script>");
                }
                Response.Write(" <script type=\"text/javascript\"> window.location.href= 'Login.aspx ' </script> ");

            }

        }
    }
}