using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class ExperimentDetails : System.Web.UI.Page
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();
        protected ExperimentInfo Experiment
        {
            get { 
                return LabDB.ExperimentInfo.SingleOrDefault(d=>d.Id.ToString()==Request.QueryString["id"]);
            }
            
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}