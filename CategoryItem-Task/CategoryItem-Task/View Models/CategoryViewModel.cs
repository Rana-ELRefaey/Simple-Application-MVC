using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CategoryItem_Task.Models;

namespace CategoryItem_Task.View_Models
{
    public class CategoryViewModel
    {
        public List<Category> categories { get; set; }
        public Category category { get; set; }


    }
}