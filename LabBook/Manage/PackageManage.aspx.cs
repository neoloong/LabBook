using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class PackageManage : System.Web.UI.Page
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
        protected IEnumerable<CoursePackage> PackageList
        {
            get
            {
                return LabDB.CoursePackage.Where(d => d.ExperimentId == Experiment.Id);

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
            

        }
    }
}