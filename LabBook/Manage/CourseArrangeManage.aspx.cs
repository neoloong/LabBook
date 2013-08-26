using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class CourseArrangeManage1 : System.Web.UI.Page
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CourseInfo Course
        {
            get
            {
                return LabDB.CourseInfo.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["courseId"]);
            }
        }
        protected List<CourseArrange> ArrangeList
        {
            get
            {
                //return LabDB.CourseArrange.Where(d => d.CourseId.ToString() == Request.QueryString["courseId"]).ToList().OrderBy(d => d.Week).ThenBy(d => d.WeekDay).ToList();
                var query = from arrange in LabDB.CourseArrange
                            where arrange.CourseId.ToString() == Request.QueryString["courseId"]
                            orderby arrange.Week ascending, arrange.WeekDay ascending, arrange.BeginLesson ascending
                            select arrange;
                          
               return query.ToList();
               

            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}