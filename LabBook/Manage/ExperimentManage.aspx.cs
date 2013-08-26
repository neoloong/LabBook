using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class ExperimentManage : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 获取当前学期。
        /// 
        /// 注意：学期表Semester中并没有标注是否为当前学期的字段，只是通过一个合法的规则获取当前学期。
        /// </summary>
        protected Semester presentTerm
        {
            get
            {
                return LabDB.Semester.OrderByDescending(d => d.SchoolYear).ThenBy(d => d.Season).FirstOrDefault();
            }
        }
        /// <summary>
        /// 当前学期的实验大类列表。
        /// </summary>
        protected IEnumerable<ExperimentInfo> ExperimentList
        {
            get
            {
                return LabDB.ExperimentInfo.Where(d => d.SemesterId == presentTerm.Id);
            }
        }
        /// <summary>
        /// 学期列表。
        /// </summary>

        protected IEnumerable<Semester> SemesterList
        {
            get
            {
                return LabDB.Semester.OrderByDescending(d => d.SchoolYear).ThenBy(d => d.Season);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                #region 检查提交信息是否为空。

                //实验名称。
                if (Request.Form["Name"]=="")
                {
                    Response.Write("<script type=\"text/javascript\"> alert('实验大类名称不能为空！');</script>");
                    return;
                }

                //实验照片。
                if (Request.Files["Photo"] == null || Request.Files["Photo"].ContentLength == 0)
                {
                    Response.Write("<script type=\"text/javascript\"> alert('照片不能为空！');</script>");
                    return;
                }
                #endregion
                HttpPostedFile photo = Request.Files["Photo"];
                string photoName = Request.Form["Name"] + DateTime.Now.ToString("yyyy-mm-dd-hh-mm-ss") + "." + photo.ContentType.Split('/')[1];

                ExperimentInfo newExperiment = new ExperimentInfo
                {
                    Name = Request.Form["Name"].Trim(),
                    Semester = presentTerm,
                    //Order=
                    PhotoUrl = "../Datas/Photos/Experiment/" + photoName,
                };


                photo.SaveAs(Request.PhysicalApplicationPath + "Datas\\Photos\\Experiment\\" + photoName);
                LabDB.ExperimentInfo.InsertOnSubmit(newExperiment);
                try
                {
                    LabDB.SubmitChanges();
                    Response.Write("<script type=\"text/javascript\"> alert('添加成功！');</script>");
                    return;
                }
                catch
                {
                    Response.Write("<script type=\"text/javascript\"> alert('发生错误！请重试或联系管理员！');</script>");
                    return;
                }
            }
        }
    }
}