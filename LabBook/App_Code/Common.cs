using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.Security;
using System.Text.RegularExpressions;

namespace LabBook
{
    public static class Common
    {

        public static void AddFlashMessage(HttpResponse res, string msg)
        {
            res.Cookies.Add(new HttpCookie("FlashMessage", msg) { Path = "/" });
        }

        //public static LabBookDBDataContext LabDB = new LabBookDBDataContext();

        public static string ToMD5(this string input)
        {
            return FormsAuthentication.HashPasswordForStoringInConfigFile(input, "MD5");
        }

        public static bool isNullorWhiteSpace(this string input)
        {
            if (string.IsNullOrEmpty(input)) return true;
            input = input.Trim();
            if (string.IsNullOrEmpty(input)) return true;
            return false;
        }

        public static bool IsPhoneNumber(this string input)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(input, @"((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)"))
            {
                return true;
            }
            else
            {
                return false;
            }
           
        }

        public static bool IsEmailAddress(this string input)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(input, "^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$"))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        

        //使用正则进行验证。
        public static bool RegexValidate(string regexString, string validateString)
        {
            Regex regex = new Regex(regexString);
            return regex.IsMatch(validateString.Trim());
        }

    }


   
}