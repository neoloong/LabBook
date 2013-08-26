using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class ArrangeDetails : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CourseArrange Arrange
        {
            get
            {
                return LabDB.CourseArrange.SingleOrDefault(d=>d.Id.ToString()==Request.QueryString["arrangeId"]);
            }
        }

        //protected IEnumerable<CourseBookInfo> BookInfoList
        //{
        //    get
        //    {
        //        return LabDB.CourseBookInfo.Where(d => d.CourseArrangeId.ToString() == Request.QueryString["arrangeId"]);
        //    }

        //}

        protected void Page_Load(object sender, EventArgs e)
        {

        }


    }
}