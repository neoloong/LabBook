using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
	public partial class Bulletin : System.Web.UI.Page
	{
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected Bulletin bulletin 
        {
            get
            {
                return LabDB.Bulletin.SingleOrDefault(d => d.Id.ToString() == Request.QueryString["id"]);
            }
        }

		protected void Page_Load(object sender, EventArgs e)
		{
            
		}
	}
}