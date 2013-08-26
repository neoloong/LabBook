using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class CourseManage : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 当前的实验大类。
        /// </summary>
        protected ExperimentInfo Experiment
        {
            get
            {
                string experimentId = Request.QueryString["id"] == null ? Request.Form["ExperimentId"] : Request.QueryString["id"];
                return LabDB.ExperimentInfo.SingleOrDefault(d => d.Id.ToString() == experimentId);
            }
        }

        /// <summary>
        /// 课程列表。
        /// </summary>
        protected IEnumerable<CourseInfo> CourseList
        {
            get
            {
                return LabDB.CourseInfo.Where(d => d.ExperimentId== Experiment.Id);

            }
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

                //照片。
                if (Request.Files["Photo"] == null || Request.Files["Photo"].ContentLength == 0)
                {
                    Response.Write("<script type=\"text/javascript\"> alert('照片不能为空！');</script>");
                    return;
                }

                #endregion
                HttpPostedFile photo = Request.Files["Photo"];
                string photoName = Request.Form["Name"] + DateTime.Now.ToString("yyyy-mm-dd-hh-mm-ss") + "." + photo.ContentType.Split('/')[1];

                try
                {
                    CourseInfo course = new CourseInfo
                    {
                        Name = Request.Form["Name"].Trim(),
                        Address = Request.Form["Address"].Trim(),
                        ClassHour = Convert.ToInt16(Request.Form["ClassHour"]),
                        TeacherInfo = LabDB.TeacherInfo.SingleOrDefault(d => d.Id.ToString() == Request.Form["TeacherId"]),
                        Introduction = Request.Form["Introduction"].Trim(),
                        ExperimentInfo = LabDB.ExperimentInfo.SingleOrDefault(d => d.Id.ToString() == Request.Form["ExperimentId"]),
                        PhotoUrl = "../Datas/Photos/Course/" + photoName,
                    };

                    photo.SaveAs(Request.PhysicalApplicationPath + "Datas\\Photos\\Course\\" + photoName);

                    LabDB.CourseInfo.InsertOnSubmit(course);
                    LabDB.SubmitChanges();
                    Response.Write("<script type=\"text/javascript\"> alert('操作成功！');</script>");
                    Response.Write("<script type=\"text/javascript\">window.location='CourseManage.aspx?id="+Experiment.Id+"'</script>");
                    //return;

                    //Response.Redirect("CourseManage.aspx", true);

                }
                catch
                {
                    Response.Write("<script type=\"text/javascript\"> alert('操作失败！请检查输入！');</script>");
                    Response.Write("<script type=\"text/javascript\">window.location='CourseManage.aspx?id=" + Experiment.Id + "'</script>");
                   // return;
                }


            }

        }
    }
}