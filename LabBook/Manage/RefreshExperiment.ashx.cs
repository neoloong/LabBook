using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Web.Script.Serialization;

namespace LabBook.Manage
{
    /// <summary>
    /// RefreshExperiment 的摘要说明
    /// </summary>
    public class RefreshExperiment : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                List<ExperimentToManage> ExperimentList = new List<ExperimentToManage>();
                using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
                {
                    var experiments = LabDB.ExperimentInfo.Where(d => d.SemesterId.ToString() == context.Request.QueryString["termId"]);
                    foreach (var experiment in experiments)
                    {
                        ExperimentList.Add(new ExperimentToManage
                        {
                            Id = experiment.Id,
                            Name = experiment.Name,
                        });
                    }
                }
                //实例化json序列化对象。
                JavaScriptSerializer JsonSerializer = new JavaScriptSerializer();

                //System.Threading.Thread.Sleep(3000);
                //将数据返回到Select.aspx。
                context.Response.ContentType = "text/plain";
                context.Response.Write(JsonSerializer.Serialize(ExperimentList));
            }

            catch (Exception ex)
            {
                context.Response.Write("<script type=\"text/javascript\">alert(" + ex.Message + ")</script>");
            }

        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public class ExperimentToManage
        {
            public string Name;

            public int Id;
        }

    }
}