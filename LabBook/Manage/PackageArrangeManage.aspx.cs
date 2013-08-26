using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class PackageArrangeManage : System.Web.UI.Page
    {

        LabBookDBDataContext LabDB = new LabBookDBDataContext();
        protected CoursePackage Package
        {
            get
            {
                return LabDB.CoursePackage.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["packageId"]);
            }
        }

        protected List<PackageArrangeToShow> PackageArrangeList = new List<PackageArrangeToShow>();



        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (var arrange in LabDB.PackageArrange.Where(d => d.CoursePackageId == Package.Id))
            {
                PackageArrangeList.Add(new PackageArrangeToShow
                {
                    Id = arrange.Id,
                    CustomTime=arrange.CustomTime,
                    Capacity=arrange.Capacity,
                    HaveBooked=LabDB.PackageBookInfo.Where(d=>d.PackageArrangeId==arrange.Id).Count(),

                });
            }
        }


        public class PackageArrangeToShow
        {
            public int Id;

            public string CustomTime;

            public int Capacity;

            public int HaveBooked;

        }
    }
}