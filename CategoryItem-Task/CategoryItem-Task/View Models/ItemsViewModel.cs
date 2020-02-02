using CategoryItem_Task.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CategoryItem_Task.View_Models
{
    public class ItemsViewModel
    {
        public List<Item> items { get; set; }
        public int MyProperty { get; set; }
        public Item item { get; set; }
        public List<Category> categories { get; set; }
        public Category cate { get; set; }
    }




    public class ItemsViewModelIndex
    {

        public ItemsViewModelIndex()
        {
            this.item = new Item();    
        }

        public Item item { get; set; }

        public int ItemID { get; set; }
       
        public string Name { get; set; }
        public int Units { get; set; }
       public double PricePerUnit { get; set; }
        public int Quantity { get; set; }
        public int CatergoryID { get; set; }

        public string Category { get; set; }
    }




  
}