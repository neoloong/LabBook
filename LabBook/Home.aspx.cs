using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class Index : System.Web.UI.Page
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 公告列表。
        /// </summary>
        protected IEnumerable<Bulletin> BulletinList
        {
            get
            {
                return LabDB.Bulletin.Take(7).OrderByDescending(d => d.Date);
            }
        }


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
        /// 实验大类列表。
        /// </summary>
        protected IEnumerable<ExperimentInfo> ExperimentList
        {
            get
            {
                return LabDB.ExperimentInfo.Where(d => d.SemesterId == presentTerm.Id).OrderBy(d => d.Order);
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}