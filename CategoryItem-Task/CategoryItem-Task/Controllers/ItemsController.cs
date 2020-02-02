using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using CategoryItem_Task.Models;
using CategoryItem_Task.View_Models;
using CrystalDecisions.CrystalReports.Engine;

namespace CategoryItem_Task.Controllers
{
    public class ItemsController : Controller
    {
         CategoriesEntities db = new CategoriesEntities();

        
        public ActionResult Index()
        {

            ViewBag.x= db.Items.Include("Categories").Select(a => new ItemsViewModelIndex { ItemID = a.ItemID, Name = a.Name, PricePerUnit = a.PricePerUnit == null ? 0 : a.PricePerUnit.Value, Quantity = a.Quantity == null ? 0 : a.Quantity.Value, Category = a.Category==null?"": a.Category.Name }).ToList();

            var result = new ItemsViewModel(); 

            //ViewBag.CatergoryID = new SelectList(db.Categories, "CategoryID", "Name");
            ViewBag.categoriesList = new SelectList(db.Categories.ToList<Category>(), "CategoryID", "Name");
            ViewBag.CategoryName = (from n in db.Items
                                    join s in db.Categories
                                    on n.CatergoryID equals s.CategoryID
                                    select s.Name).FirstOrDefault();
            //ViewBag.CategoryName = db.Items.Where(x => x.CatergoryID == x.Category.CategoryID).Select(x => x.Category.Name).FirstOrDefault();
            return View(result);
        }

      
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Item item = db.Items.Find(id);
            if (item == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoryName = (from n in db.Categories
                                   join s in db.Items
                                   on n.CategoryID equals s.CatergoryID
                                   select n.Name).FirstOrDefault();
            return View(item);
        }


     

        [HttpPost]
        public ActionResult Create(Item item, int? CategoryID)
        {
            //ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "Name", item.CatergoryID);
            if (ModelState.IsValid)
            {
                item.CatergoryID = CategoryID; 
                    db.Items.Add(item);
                    db.SaveChanges();
                    return PartialView("_PartialCreateItem", item);
               
            }

            //ViewBag.CatergoryID = new SelectList(db.Categories, "CategoryID", "Name", item.CatergoryID);
            return View("Error");
        }


        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Item item = db.Items.Find(id);
            if (item == null)
            {
                return HttpNotFound();
            }
            ViewBag.CatergoryID = new SelectList(db.Categories, "CategoryID", "Name", item.CatergoryID);
            return View(item);
        }

     
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ItemID,Name,Units,PricePerUnit,Quantity,CatergoryID")] Item item)
        {
            if (ModelState.IsValid)
            {
                db.Entry(item).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CatergoryID = new SelectList(db.Categories, "CategoryID", "Name");
            return View(item);
        }

    
        public bool Delete(int id)
        {
            Item item = db.Items.FirstOrDefault(e=>e.ItemID == id);
            if (item == null)
            {
                return false;
            }
            else
            {
                db.Items.Remove(item);
                db.SaveChanges();
                return true;
            }
        }

        public ActionResult ExportItem()
        {
           // List<Item> allofItems = new List<Item>();
           var  allofItems = db.Items.Select(a=> new    { 
                Name=a.Name , PricePerUnit=a.PricePerUnit==null?0:a.PricePerUnit.Value,
             Units = a.Units == null ? 0 : a.Units.Value,
                Quantity = a.Quantity == null ? 0 : a.Quantity.Value,
                Category = a.Category.Name ,
                a.ItemID
            } ).ToList();


            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Report"), "ItemReport.rpt"));

            rd.SetDataSource(allofItems);

            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();


            Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            stream.Seek(0, SeekOrigin.Begin);
            return File(stream, "application/pdf", "Item.pdf");
        }


        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
