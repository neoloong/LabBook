﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook.Manage
{
    /// <summary>
    /// DeletePackage 的摘要说明
    /// </summary>
    public class DeletePackage : IHttpHandler
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";


            //PackageArrange arrange = LabDB.PackageArrange.SingleOrDefault(d => d.Id.ToString() == context.Request["arrangeId"]);
            CoursePackage package = LabDB.CoursePackage.SingleOrDefault(d => d.Id.ToString() == context.Request["packageId"]);

            LabDB.CoursePackage.DeleteOnSubmit(package);

            try
            {
                LabDB.SubmitChanges();
                LabDB.Connection.Close();                
            }
            catch (Exception ex)
            {
                //删除失败返回错误信息。
                context.Response.Write(ex.Message);
                return;
            }

            //删除成功返回1。
            context.Response.Write("1");

        }

        public bool IsReusable

        {
            get
            {
                return false;
            }
        }
    }
}