using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class CourseModify : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CourseInfo Course
        {
            get
            {
                return LabDB.CourseInfo.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["courseId"]);
            }
            set { }
        }
        /// <summary>
        /// 全体老师列表。
        /// </summary>
        protected IEnumerable<TeacherInfo> TeacherList
        {
            get
            {
                return LabDB.TeacherInfo;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {

                #region 检查输入是否完整且合法。

                //实验名称。
                if (Request.Form["Name"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('实验名称不能为空！');</script>");
                    return;
                }

                //学时。
                if (Request.Form["ClassHour"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('学时不能为空！');</script>");
                    return;
                }



                //指导老师。
                if (Request.Form["TeacherId"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('指导老师不能为空！');</script>");
                    return;
                }

                //实验简介。
                if (Request.Form["Introduction"].isNullorWhiteSpace())
                {
                    Response.Write("<script type=\"text/javascript\"> alert('实验简介不能为空！');</script>");
                    return;
                }

                ////照片。
                //if (Request.Files["Photo"] == null || Request.Files["Photo"].ContentLength == 0)
                //{
                //    Response.Write("<script type=\"text/javascript\"> alert('照片不能为空！');</script>");
                //    return;
                //}
            
                ////注意事项
                //if (Request.Form["Attention"].isNullorWhiteSpace())
                //{
                //    Response.Write("<script type=\"text/javascript\"> alert('注意事项不能为空！');</script>");
                //    return;
                //}


                #endregion



                string photoName = "";
                HttpPostedFile photo = null;
                if (Request.Files["Photo"] != null && Request.Files["Photo"].ContentLength != 0)
                {
                    photo = Request.Files["Photo"];
                    photoName = Request.Form["Name"] + DateTime.Now.ToString("yyyy-mm-dd-hh-mm-ss") + "." + photo.ContentType.Split('/')[1];
                }

                try
                {
                    Course.Name = Request.Form["Name"].Trim();
                    Course.Address = Request.Form["Address"].Trim();
                    Course.ClassHour = Convert.ToInt16(Request.Form["ClassHour"]);
                    Course.TeacherInfo = LabDB.TeacherInfo.SingleOrDefault(d => d.Id.ToString() == Request.Form["TeacherId"]);
                    Course.Introduction = Request.Form["Introduction"].Trim();
                    Course.Attention = Request.Form["Attention"].Trim();
                    //Course.ExperimentInfo = LabDB.ExperimentInfo.SingleOrDefault(d => d.Id.ToString() == Request.Form["ExperimentId"]);
                    if (photoName != "")
                    {
                        Course.PhotoUrl = "../Datas/Photos/Course/" + photoName;
                        photo.SaveAs(Request.PhysicalApplicationPath + "Datas\\Photos\\Course\\" + photoName);
                    }


                    LabDB.SubmitChanges();
                    Response.Write("<script type=\"text/javascript\"> alert('修改成功！');</script>");
                    Response.Write("<script type=\"text/javascript\"> window.location='DetailsOfCourse.aspx?courseId=" + Course.Id + "'</script>");
                    return;

                }
                catch
                {
                    Response.Write("<script type=\"text/javascript\"> alert('操作失败！请检查输入！');</script>");
                    return;
                }


            }

        }
    }
}
