using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class TeacherInfo : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 获取教师信息。
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