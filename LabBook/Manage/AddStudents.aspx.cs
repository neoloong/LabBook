using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;

namespace LabBook.Manage
{
    public partial class AddStudents : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 学生账户列表。
        /// </summary>
        protected List<Account> StudentsAccountList = new List<Account>();

        /// <summary>
        /// 需要上传的学生名单。
        /// </summary>
        protected List<StudentInfo> StudentsToUpload = new List<StudentInfo>();

        /// <summary>
        /// 班级名称。
        /// </summary>
        protected string ClassName;

        /// <summary>
        /// 学院名称。
        /// </summary>
        protected string CollegeName
        {
            get
            {
                return Request.Form["College"];
            }
        }

        protected string Message = "";

        /// <summary>
        /// 默认密码。
        /// </summary>
        protected string DefaultPwd
        {
            get
            {
                return Request.Form["DefaultPwd"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST" && Request.Files["StudentInfoList"] != null)
            {
                //检查学院名是否为空。
                if (Request.Form["College"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\">alert('学院名不能为空！')</script>");
                    return;
                }

                //检查默认密码是否为空。
                if (Request.Form["DefaultPwd"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\">alert('默认密码不能为空！')</script>");
                    return;
                }

                //检查上传的学生名单是够为空。
                var uploadFile = Request.Files["StudentInfoList"];
                if (uploadFile.ContentLength == 0)
                {
                    Response.Write("<script type=\"text/javascript\">alert('学生名单不能为空！')</script>");
                    return;
                }

                try
                {

                    if (uploadFile.ContentLength > 100000)
                    {
                        throw new Exception("");
                    }

                    #region 读取学生名单。
                    //实例化文件读取对象。
                    Stream fileStream = uploadFile.InputStream;
                    StreamReader streamReader = new StreamReader(fileStream, System.Text.Encoding.Default);

                    string line = streamReader.ReadLine();
                    string[] words;
                    while (line != null)
                    {
                        words = line.Trim().Split('\t');

                        switch (words.Count())
                        {
                            case 3:
                                {
                                    ClassName = words[0].Trim();
                                    NewStudent(words[1], words[2]);
                                    break;
                                }
                            case 2:
                                {
                                    NewStudent(words[0], words[1]);
                                    break;
                                }
                            default:
                                //提示文件格式错误预留。
                                break;
                        }
                        line = streamReader.ReadLine();
                    }
                    streamReader.Close();
                }
                catch (Exception exp)
                {
                    Response.Write("<script type=\"text/javascript\">alert('文件格式错误！" + exp.Message + "')</script>");
                    return;
                }

                    #endregion



                LabDB.Account.InsertAllOnSubmit(StudentsAccountList);
                LabDB.StudentInfo.InsertAllOnSubmit(StudentsToUpload);

                try
                {
                    LabDB.SubmitChanges();
                }
                catch (Exception exp)
                {
                    Response.Write("<script type=\"text/javascript\">alert('请检查是否上传了已有的学生信息！')</script>");
                    return;
                }

                Response.Write("<script type=\"text/javascript\"> alert('学生上传成功！" + Message + "');</script>");
                Response.Write("<script type=\"text/javascript\">window.location=AddStudent.aspx;</script>");
                //return;

            }
        }

        /// <summary>
        /// 新建学生信息。
        /// </summary>
        /// <param name="id">学号。</param>
        /// <param name="name">姓名。</param>
        private void NewStudent(string id, string name)
        {
            //判断StudentInfo表里是否含有此学生信息，如果已经存在，则退出。
            if (LabDB.StudentInfo.FirstOrDefault(d => d.Id == id.Trim()) != null)
            {
                Message = "但上传的名单中包含已有学生";
                return;
            }

            //判断Account表里是否含有此学生信息,如果有的话，直接作为其账户。
            Account account = LabDB.Account.FirstOrDefault(d => d.UserName == id.Trim());            
            if (account != null)
            {
                StudentsAccountList.Add(account);
            }
            else
            {
                StudentsAccountList.Add(new Account()
                {
                    UserName = id.Trim(),
                    Password = DefaultPwd.ToMD5(),
                    Type = 1,
                });
            }
            StudentsToUpload.Add(new StudentInfo()
            {
                College = CollegeName,
                Class = ClassName,
                Id = id.Trim(),
                Name = name,
                Account = StudentsAccountList.Last(),
            });
        }
    }
}