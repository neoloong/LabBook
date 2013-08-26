using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();
        protected StudentInfo Student
        {
            get
            {
                var entrant = (Account)Session["sid"];
                return LabDB.StudentInfo.SingleOrDefault(d => d.AccountId == entrant.Id);
            }
        }

        protected string Message = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                if (Request.Form["OldPwd"].ToMD5() == Student.Account.Password && Request.Form["NewPwd"].Length >= 6 && Request.Form["NewPwd"].Length <= 12 && Request.Form["NewPwd"] == Request.Form["ConfirmPwd"])
                {
                    Student.Account.Password = Request.Form["NewPwd"].ToMD5();

                    try
                    {
                        LabDB.SubmitChanges();
                    }
                    catch
                    {
                        Message = "密码修改失败，请检查输入";                        
                    }
                    Message = "修改成功!";
                    //SuccessMessage = "修改成功！";
                    //Response.Write("<script type=\"text/javascript\">alert(\"修改成功！\");</script>");
                    //Response.Write(" <script> window.location.href= 'Home.aspx ' </script> "); 
                    return;
                }
                else
                {
                    //FailMessage = "密码修改失败，请检查输入";
                    Message = "密码修改失败，请检查输入!";
                }
            }
        }
    }
}