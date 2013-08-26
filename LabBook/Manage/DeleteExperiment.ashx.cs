using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LabBook.Manage
{
    /// <summary>
    /// DeleteExperiment 的摘要说明
    /// </summary>
    public class DeleteExperiment : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            using (LabBookDBDataContext LabDB = new LabBookDBDataContext())
            {
                ExperimentInfo experiment = LabDB.ExperimentInfo.SingleOrDefault(d=>d.Id.ToString()==context.Request.QueryString["id"]);
                LabDB.ExperimentInfo.DeleteOnSubmit(experiment);
                LabDB.SubmitChanges();
            }

            context.Response.ContentType = "text/plain";
            
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