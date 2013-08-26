using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class personalInfo : System.Web.UI.Page
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 获取学生信息。
        /// </summary>
        protected StudentInfo Student
        {
            get
            {
                //获取学生信息。
                var entrant = (Account)Session["sid"];
                return LabDB.StudentInfo.SingleOrDefault(d => d.AccountId == entrant.Id);
            }
        }
        protected string Message="";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                if (Request.Form["Sex"] != null)
                {
                    Student.Sex = Request.Form["Sex"] == "male";// 男性保存为真，女性保存为假。
                }
                //表单信息格式验证。
                if (!Request.Form["PhoneNumber"].IsPhoneNumber())
                {
                    //Response.Write("<script type=\"text/javascript\"> alert('电话号码格式错误！请检查输入！');</script>");
                    Message = "电话号码格式错误！请检查输入！";
                    return;
                }

                if (!Request.Form["Email"].IsEmailAddress())
                {
                    //Response.Write("<script type=\"text/javascript\"> alert('电子邮件格式错误！请检查输入！');</script>");
                    Message = "电子邮件格式错误！请检查输入！";
                    return;
                }

                Student.PhoneNumber = Request.Form["PhoneNumber"];
                Student.Email = Request.Form["Email"];
                try
                {
                    LabDB.SubmitChanges();
                    Message = "个人信息修改成功！";
                }
                catch 
                {
                    Message = "发生错误！请检查输入后重试！";   
                }
            }
        }
    }
}