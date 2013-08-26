using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class PackageArrangeDetails : System.Web.UI.Page
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected PackageArrange Arrange
        {
            get
            {
                return LabDB.PackageArrange.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["arrangeId"]);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}