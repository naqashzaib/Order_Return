using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TechnoPurAccounts.Models
{
    public class FileUpload1
    {
        public int imageid
        {
            get;
            set;
        }
        public string imagename
        {
            get;
            set;
        }
        public byte[] imagedata
        {
            get;
            set;
        }
    }
}