using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class BookPackage : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected CoursePackage Package
        {
            get
            {
                return LabDB.CoursePackage.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["id"]);
            }
        }

        protected StudentInfo Student
        {
            get
            {
                return LabDB.StudentInfo.SingleOrDefault(d => d.Account == (Account)Session["sid"]);
            }
        }

        protected PackageArrange Arrange;




        protected void Page_Load(object sender, EventArgs e)
        {

            //if (Request.HttpMethod == "POST")
            //{

            //    Arrange = LabDB.PackageArrange.SingleOrDefault(d => d.Id.ToString() == Request.Form["arrangeId"]);

               

            //    PackageBookInfo bookInfo = new PackageBookInfo
            //    {
            //        StudentInfo = Student,
            //        PackageArrange = Arrange,
            //        BookTime = DateTime.Now,
            //        UserAgent = Request.UserAgent.ToString(),
            //    };

            //    LabDB.PackageBookInfo.InsertOnSubmit(bookInfo);
            //    try
            //    {
            //        LabDB.SubmitChanges();
            //        Response.Write("<script type=\"text/javascript\">alert('预约成功!请到个人中心查看！')</script>");
            //    }

            //    catch
            //    {
            //        Response.Write("<script type=\"text/javascript\">alert('预约失败!')</script>");
            //    }

            //    //Common.AddFlashMessage(Response, "预约成功！");
            //    //Response.Cookies.Add(new HttpCookie("FlashMessage", "预约成功！") { Path="/"});

            //    //Response.Redirect("IndividualCenter.aspx");

            //    //Page.ClientScript.RegisterStartupScript(this.GetType(), "", "<script>alert('用这种方法合适点')<script>");

            //    Response.Write("<script type=\"text/javascript\">window.location='IndividualCenter.aspx'</script>");

            //}
        }

        /// <summary>
        /// 此课堂能否预约。
        /// </summary>
        /// <param name="arrange"></param>
        /// <param name="student"></param>
        /// <returns></returns>
        protected bool CanBeBooked(PackageArrange arrange, StudentInfo student)
        {
            if (student == null || arrange == null || arrange.Capacity <= arrange.PackageBookInfo.Count || IsBooked(student, arrange.CoursePackage))
                return false;
            else return true;
        }

        /// <summary>
        /// 是否此实验已经预约过。
        /// </summary>
        /// <param name="student"></param>
        /// <param name="package"></param>
        /// <returns></returns>
        protected bool IsBooked(StudentInfo student, CoursePackage package)
        {
            PackageBookInfo info = LabDB.PackageBookInfo.FirstOrDefault(d => d.StudentInfo == student && d.PackageArrange.CoursePackage == package);
            if (info != null)
                return true;
            else return false;
        }
    }
}