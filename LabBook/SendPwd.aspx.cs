using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Net.Mail;

namespace LabBook
{
    public partial class SendPwd : System.Web.UI.Page
    {
        protected string Message = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
                {
                    var Student = LabDB.StudentInfo.SingleOrDefault(d => d.Id == Request.Form["Id"]);
                    if (Student == null || Student.Name.Trim() != Request.Form["Name"].Trim())
                    {
                        Message = "该用户不存在！请检查输入！";
                        Response.Redirect("SendPwd.aspx");
                    }

                    if (Student.Email == null)
                    {
                        Message = "您没有设置安全邮箱！无法找回密码！请联系管理员！";
                        Response.Redirect("SendPwd.aspx");
                    }


                    //发送邮件。

                    MailMessage mail = new MailMessage(new MailAddress("labbook@126.com", "光电学院实验预约系统"), new MailAddress(Student.Email, Student.Name));

                                     
                    //邮件编码格式。
                    mail.BodyEncoding = System.Text.Encoding.UTF8;
                    mail.IsBodyHtml = true;

                    //邮件内容。
                    mail.Subject = "光电子科学与工程学院实验预约系统密码找回";

                    
                    mail.Body = Student.Name + "：您好！ 您在光电学院实验预约系统上申请了找回密码，请点击以下链接确认更改。" + Request.Url.GetLeftPart(UriPartial.Authority) + "/ResetPwd.aspx?resetId=" + Student.Id + "请在20分钟内完成密码重置。";
                    //mail.Body = Student.Name + "：您好！ 您在光电学院实验预约系统上申请了找回密码，请点击以下链接确认更改。" + Request.PhysicalApplicationPath + "/ResetPwd.aspx?resetId=" + Student.Id + "请在20分钟内完成密码重置。";
                    mail.Priority = MailPriority.Normal;

                    SmtpClient client = new SmtpClient();

                    client.Host = "smtp.126.com";

                    client.UseDefaultCredentials = false;
                    client.Credentials = new System.Net.NetworkCredential("labbook", "~!@#$%^&*()_+");
                    client.DeliveryMethod = SmtpDeliveryMethod.Network;
                    client.Send(mail);

                    //设置Session。
                    Session["resetId"] = Student.Id;
                }
            }
        }
    }
}