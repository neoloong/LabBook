using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class AddPackageArrange : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();


        protected CoursePackage Package;


        protected PackageArrange Arrange = null;



        protected void Page_Load(object sender, EventArgs e)
        {


            //修改安排。
            if (Request.QueryString["packageId"].isNullorWhiteSpace())
            {
                Arrange = LabDB.PackageArrange.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["arrangeId"]);
                Package = Arrange.CoursePackage;

            }
            //添加新安排。    
            else
            {
                Package = LabDB.CoursePackage.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["packageId"]);

            }

            if (Request.HttpMethod == "POST")
            {
                if (Arrange == null)
                {
                    Arrange = new PackageArrange { CoursePackage = Package };
                    LabDB.PackageArrange.InsertOnSubmit(Arrange);
                }

                //收集安排信息。
                Arrange.CustomTime = Request.Form["CustomTime"];

                try
                {
                    Arrange.Capacity = Int32.Parse(Request.Form["Capacity"]);//Int32的Parse方法可能会抛出错误。

                    LabDB.SubmitChanges();
                }
                catch
                {

                }

                Response.Redirect("PackageArrangeManage.aspx?packageId="+Package.Id);
            }
        }
    }
}