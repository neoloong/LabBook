using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class TeachersManage : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected IEnumerable<TeacherInfo> TeacherList
        {
            get
            {
                return LabDB.TeacherInfo;
            }
        }

        protected TeacherInfo Teacher;

        protected Account TeacherAccount;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {

                #region 检查用户信息是否合法
                if (LabDB.Account.Where(d => d.UserName == Request.Form["Name"].Trim()).Count() >= 1)
                {
                    Response.Write("<script type=\"text/javascript\"> alert('该用户名已经存在！');</script>");
                    return;
                }
                #endregion

                #region 检查提交的信息是否完整。
                if (Request.HttpMethod == "POST")
                {
                    //姓名。
                    if (Request.Form["Name"].isNullorWhiteSpace())
                    {
                        Response.Write("<script type=\"text/javascript\"> alert('教师姓名不能为空！');</script>");
                        return;
                    }

                    //用户名。
                    if (Request.Form["Account"].isNullorWhiteSpace())
                    {
                        Response.Write("<script type=\"text/javascript\"> alert('用户名不能为空！');</script>");
                        return;
                    }

                    //密码。
                    if (Request.Form["Password"].isNullorWhiteSpace())
                    {
                        Response.Write("<script type=\"text/javascript\"> alert('密码不能为空！');</script>");
                        return;
                    }
                    //电话。
                    if (Request.Form["Tel"].isNullorWhiteSpace())
                    {
                        Response.Write("<script type=\"text/javascript\"> alert('电话号码不能为空！');</script>");
                        return;
                    }

                    if (Request.Form["Sex"].isNullorWhiteSpace())
                    {
                        Response.Write("<script type=\"text/javascript\"> alert('性别不能为空！');</script>");
                        return;
                    }
                    //照片。
                    if (Request.Files["Photo"] == null || Request.Files["Photo"].ContentLength == 0)
                    {
                        Response.Write("<script type=\"text/javascript\"> alert('照片不能为空！');</script>");
                        return;
                    }


                }
                #endregion

                #region 检查信息电话格式合法性。
                if (!Request.Form["Tel"].IsPhoneNumber())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('电话号码格式不正确！请检查输入！');</script>");
                    return;
                }

                #endregion
               
                    
                

                #region 新建教师信息并存入数据库。
                try
                {
                    TeacherAccount = new Account
                    {
                        UserName = Request.Form["Account"].Trim(),
                        Password = Request.Form["Password"].Trim().ToMD5(),
                        Type = 3,
                    };
                    LabDB.Account.InsertOnSubmit(TeacherAccount);


                    HttpPostedFile photo = Request.Files["Photo"];

                    string photoName = Request.Form["Name"] + DateTime.Now.ToString("yyyy-mm-dd-hh-mm-ss") + "." + photo.ContentType.Split('/')[1];

                    Teacher = new TeacherInfo
                    {
                        Name = Request.Form["Name"].Trim(),
                        Sex = Request.Form["Sex"] == "male" ? true : false,
                        Account = TeacherAccount,
                        PhoneNumber = Request.Form["Tel"].Trim(),
                        Remarks = Request.Form["Remarks"].Trim(),
                        PhotoUrl = "Datas/Photos/Teacher/" + photoName,
                    };

                    photo.SaveAs(Request.PhysicalApplicationPath + "Datas\\Photos\\Teacher\\" + photoName);

                    LabDB.TeacherInfo.InsertOnSubmit(Teacher);
                    LabDB.SubmitChanges();
                }
                catch
                {
                    Response.Write("<script type=\"text/javascript\"> alert('发生错误！请检查信息录入是否合法！');</script>");
                    return;
                }
                return;
                #endregion
            }
        }
    }
}