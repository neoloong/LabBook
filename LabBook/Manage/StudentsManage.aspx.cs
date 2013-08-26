using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LabBook.Manage
{
    public partial class StudentsManage : System.Web.UI.Page
    {
        protected LabBookDBDataContext LabDB = new LabBookDBDataContext();

        protected IEnumerable<StudentInfo> StudentList;

        protected string[] Classes=new string[500];


        //protected IEnumerable<string> Colleges
        //{ 
        //    return 
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            int num = 0;
            foreach (var student in LabDB.StudentInfo.OrderBy(d=>d.Class))
            {
                if (num==0||!Classes.Contains(student.Class))
                {
                    Classes[num] = student.Class;
                    num++;
                }
            }
            


            if (Request.HttpMethod == "POST")
            {
                string key = Request.Form["key"].Trim();
                StudentList = LabDB.StudentInfo.Where(d => d.Id.Contains(key) || d.Name.Contains(key) || d.College.Contains(key) || d.Class.Contains(key)).OrderBy(d=>d.Class).Take(50);

            }
            else StudentList = LabDB.StudentInfo.Take(50);
            LabDB.Connection.Close();
        }

    }
}