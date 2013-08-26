using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class Manage : System.Web.UI.MasterPage
    {

        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected Account User;

        /// <summary>
        /// 载入页面前检查Session。
        /// </summary>
        /// <param name="e"></param>
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            Account entrant = (Account)Session["sid"];

            //Session过期，跳转回登录页面。
            if (entrant == null)
            {
                Response.Redirect("../Login.aspx");
            }

            User = LabDB.Account.SingleOrDefault(d => d == entrant);

            if (User == null || User.Type==1)
            {
                //检查不通过的相关操作预留。
                Response.Redirect("../Login.aspx");
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}