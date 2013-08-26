/**************************************************
 * 作者: Neo @ Sicun Studio
 * 完成日期: 2012年4月19日
 * 描述: 登录页面的定义。
 * 版权: (C) 2012 Sicun Studio.
 * 
 * 声名: 未经作者允许，请勿擅自传播或转载本程序
 * 
 * 修订记录:
 *
 **************************************************/


using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

namespace LabBook
{
    public partial class Login : System.Web.UI.Page
    {
        /// <summary>
        /// 建立数据库连接。
        /// </summary>
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.HttpMethod == "POST")
            {
                try
                {
                    Account user;
                    if (Request.Form["UserName"] == "" && Request.Form["Password"] == "")
                    {
                        user = LabDB.Account.FirstOrDefault(d => d.UserName == "visitor" && d.Password == "visitor");
                        Session["sid"] = user; //设置Session访问权限。
                        Response.Redirect("Home.aspx", true);
                    }
                    else
                    {

                        user = LabDB.Account.FirstOrDefault(d => d.UserName == Request.Form["UserName"]);


                        if (user == null)
                        {
                            //user wrong
                            Response.Redirect("Login.aspx");
                        }
                        else
                        {
                            string psw = FormsAuthentication.HashPasswordForStoringInConfigFile(Request.Form["Password"], "MD5");
                            if (user.Password != psw)
                            {
                                //psw wrong
                                Response.Redirect("Login.aspx");
                            }

                            Session["sid"] = user; //设置Session访问权限。
                            Response.Redirect("Home.aspx", true);
                        }
                    }
                }
                catch(Exception ex)
                {
                    return;
                }

            }
        }
    }
}
