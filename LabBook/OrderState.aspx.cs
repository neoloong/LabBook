using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class OrderState : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 与当前学生关联的实验课程预约安排。
        /// </summary>
        protected List<CourseArrange> CourseArrangeList;

        /// <summary>
        /// 与当前学生关联的实验包预约安排。
        /// </summary>
        protected List<PackageArrange> PackageArrangeList;

        protected StudentInfo Student
        {
            get
            {
                //获取学生信息。
                var entrant = (Account)Session["sid"];
                return LabDB.StudentInfo.FirstOrDefault(d => d.AccountId == entrant.Id); 
            }
        }

        

        protected void Page_Load(object sender, EventArgs e)
        {
            

            //获取当前学生课程预约信息。
            IEnumerable<CourseBookInfo> courseBookList = LabDB.CourseBookInfo.Where(d => d.StudentId == Student.Id);
            CourseArrangeList = new List<CourseArrange>();
            foreach (var bookInfo in courseBookList)
            {
                CourseArrangeList.Add(LabDB.CourseArrange.SingleOrDefault(d => d.Id == bookInfo.CourseArrangeId));
            }

            //获取当前学生实验包预约信息。
            IEnumerable<PackageBookInfo> packageBookList = LabDB.PackageBookInfo.Where(d => d.StudentId == Student.Id);
            PackageArrangeList = new List<PackageArrange>();
            foreach (var bookInfo in packageBookList)
            {
                PackageArrangeList.Add(LabDB.PackageArrange.SingleOrDefault(d => d.Id == bookInfo.PackageArrangeId));
            }

        }
    }
}