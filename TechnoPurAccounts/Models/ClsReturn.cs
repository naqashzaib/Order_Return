using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TechnoPurAccounts.Models
{
    public class ClsReturn
    {
        public int company_id { get; set; }
        //public int created_by { get; set; }
        public string customer_name { get; set; }
        public string rma { get; set; }
        public string note { get; set; }
        public string attachment { get; set; }
        public DateTime created_time { get; set; }
    }
}