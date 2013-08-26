using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class AddArrange : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();



        //protected CourseArrange Arrange
        //{
        //    get
        //    {
        //        return LabDB.CourseArrange.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["arrangeId"]);
        //    }
        //    set { }
        //}
        protected CourseArrange Arrange=null;


        protected CourseInfo Course
        {
            get
            {
                return LabDB.CourseInfo.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["courseId"]);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Arrange=LabDB.CourseArrange.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["arrangeId"]);

            if (!Common.isNullorWhiteSpace(Request["Capacity"]))
            {
                //添加新课堂时间安排。
                Arrange = LabDB.CourseArrange.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["arrangeId"]);

                //修改课堂时间安排。
                if (Arrange == null)
                {

                    
                    Arrange = new CourseArrange();
                    Arrange.CourseId = Course.Id;
                    Arrange.Capacity = Convert.ToInt32(Request["Capacity"]);
                    Arrange.Week = Convert.ToByte(Request["Week"]);
                    Arrange.WeekDay = Convert.ToByte(Request["WeekDay"]);
                    Arrange.BeginLesson = Convert.ToByte(Request["BeginLesson"]);
                    Arrange.EndLesson = Convert.ToByte(Request["EndLesson"]);
                    LabDB.CourseArrange.InsertOnSubmit(Arrange);
                }

                else
                {

                    Arrange.Capacity = Convert.ToInt32(Request["Capacity"]);
                    Arrange.Week = Convert.ToByte(Request["Week"]);
                    Arrange.WeekDay = Convert.ToByte(Request["WeekDay"]);
                    Arrange.BeginLesson = Convert.ToByte(Request["BeginLesson"]);
                    Arrange.EndLesson = Convert.ToByte(Request["EndLesson"]);
                }

                try
                {
                    LabDB.SubmitChanges();
                }


                catch
                {
                    return;
                }

                //页面跳回本课堂管理页面。
                string link = "../Manage/CourseArrangeManage.aspx?courseId=";
                if (Course != null) link += Course.Id;
                else link += Arrange.CourseId;

                Response.Redirect(link);

            }
        }
    }
}