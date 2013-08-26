using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook
{
    public partial class AllBulletins : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        /// <summary>
        /// 公告列表。
        /// </summary>
        protected IEnumerable<Bulletin> BulletinList
        {
            get
            {
                return LabDB.Bulletin.OrderByDescending(d => d.Date);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}