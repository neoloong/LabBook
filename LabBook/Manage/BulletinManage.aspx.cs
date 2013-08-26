using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    
    public partial class BulletinManage : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();
        protected IEnumerable<Bulletin> AllBulletin
        {
            get
            {
                return LabDB.Bulletin.OrderByDescending(d=>d.Date);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}