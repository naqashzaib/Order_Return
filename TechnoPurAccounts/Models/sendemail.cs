using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace TechnoPurAccounts.Models
{
    public static class sendemail
    {
        public static string SendVerificationEmail(string body,string from,string to,string subject)
        {
            string showmesage = "";
            try
            {
                string htmlbody = body;
                SmtpClient client = new SmtpClient();
                client.Port = 587;
                client.Host = "smtp.gmail.com";
                client.EnableSsl = true;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential("genial365erp123@gmail.com", "chaudhary330");
                MailMessage mm = new MailMessage("genial365erp123@gmail.com", to, subject, htmlbody);
                mm.From = new MailAddress("info@Genial365.com", "Genial 365");
                mm.IsBodyHtml = true;
                mm.Priority = MailPriority.Normal;
                mm.ReplyToList.Add("genial365erp123@gmail.com");

                mm.BodyEncoding = Encoding.Default;
                mm.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
                client.Send(mm);

                showmesage = "Done";

            }
            catch (Exception e)
            {
                showmesage = e.ToString();
            }
            return showmesage;
        }




    }




}



