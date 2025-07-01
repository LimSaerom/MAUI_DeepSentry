using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MauiApp1.Models
{
    public class LogItem
    {
        public string LoginID { get; set; }
        public string DetDate { get; set; }
        public string DetTime { get; set; }
        public string DetAnimal { get; set; }
        public string DetLocation { get; set; }
        //public string VideoUrl { get; set; }
        public List<string> VideoUrls { get; set; } = new();          //cam별로 영상데이터를 받아오기 위해 배열로 수정
    }
}
