using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class IndividualCenter : System.Web.UI.Page
    {
        /// <summary>
        /// 弹窗消息。
        /// </summary>
        //protected string Message = "";
        protected string SuccessMessage = "";
        protected string FailMessage = "";

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();
       
        protected StudentInfo Student;

        /// <summary>
        /// 与当前学生关联的实验课程预约安排。
        /// </summary>
        protected List<CourseArrange> CourseArrangeList;

        /// <summary>
        /// 与当前学生关联的实验包预约安排。
        /// </summary>
        protected List<PackageArrange> PackageArrangeList;

        protected void Page_Load(object sender, EventArgs e)
        {
            //获取学生信息。
            var entrant = (Account)Session["sid"];
            Student = LabDB.StudentInfo.SingleOrDefault(d => d.AccountId == entrant.Id);

            //获取当前学生课程预约信息。
            IEnumerable<CourseBookInfo> courseBookList = LabDB.CourseBookInfo.Where(d => d.StudentId == Student.Id);
            CourseArrangeList = new List<CourseArrange>();
            foreach (var bookInfo in courseBookList)
            {
                CourseArrangeList.Add(LabDB.CourseArrange.SingleOrDefault(d => d.Id == bookInfo.CourseArrangeId));
            }

            //获取当前学生实验包预约信息。
            IEnumerable<PackageBookInfo> packageBookList = LabDB.PackageBookInfo.Where(d => d.StudentId == Student.Id);
            PackageArrangeList = new List<PackageArrange>();
            foreach (var bookInfo in packageBookList)
            {
                PackageArrangeList.Add(LabDB.PackageArrange.SingleOrDefault(d=>d.Id==bookInfo.PackageArrangeId));
            }


            //相应表单提交操作。
            if (Request.HttpMethod == "POST")
            {
                switch (Request.QueryString["id"])
                {
                    case "1"://个人信息表单。
                        if (Request.Form["Sex"] != null)
                        {
                            Student.Sex = Request.Form["Sex"] == "male";// 男性保存为真，女性保存为假。
                        }
                        //表单信息格式验证。
                        if (!Request.Form["PhoneNumber"].IsPhoneNumber())
                        {
                            Response.Write("<script type=\"text/javascript\"> alert('电话号码格式错误！请检查输入！');</script>");
                            return;
                        }

                        if (!Request.Form["Email"].IsEmailAddress())
                        {
                            Response.Write("<script type=\"text/javascript\"> alert('电子邮件格式错误！请检查输入！');</script>");
                            return;
                        }

                        Student.PhoneNumber = Request.Form["PhoneNumber"];
                        Student.Email = Request.Form["Email"];

                        LabDB.SubmitChanges();
                        SuccessMessage = "个人信息保存成功";
                        break;

                    case "2"://预约信息表单。  
                        break;

                    case "3"://修改密码表单。
                        //新密码验证。

                        if (Request.Form["OldPwd"].ToMD5() == entrant.Password && Request.Form["NewPwd"].Length >= 4 && Request.Form["NewPwd"] == Request.Form["ConfirmPwd"])
                        {
                            Student.Account.Password = Request.Form["NewPwd"].ToMD5();
                            LabDB.SubmitChanges();
                            SuccessMessage = "修改成功！";
                            //Response.Write("<script type=\"text/javascript\">alert(\"修改成功！\");</script>");
                            //Response.Write(" <script> window.location.href= 'Home.aspx ' </script> "); 
                            return;
                        }
                        else
                        {
                            FailMessage = "密码修改失败，请检查输入";
                        }
                        break;
                    default: break;
                }
            }

        }
    }
}