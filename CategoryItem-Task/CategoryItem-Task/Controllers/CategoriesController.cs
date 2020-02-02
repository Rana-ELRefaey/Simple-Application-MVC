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
    public class CategoriesController : Controller
    {
         CategoriesEntities db = new CategoriesEntities();

        // GET: Categories
        public ActionResult Index()
        {
            CategoryViewModel catgViewModel = new CategoryViewModel() { 
            categories = db.Categories.ToList() ,
            };
            return View(catgViewModel);
        }

        // GET: Categories/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }
            return View(category);
        }

        [HttpGet]
        public ActionResult Create()
        {
            return PartialView();
        }
        [HttpPost]
        public ActionResult Create(Category category)
        {
            if (ModelState.IsValid)
            {
                db.Categories.Add(category);
                db.SaveChanges();
                return PartialView("_PartialCreateCtegory", category);
            }

            return View("Error");
        }

        // GET: Items/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Category category = db.Categories.Find(id);
            if (category == null)
            {
                return HttpNotFound();
            }
            return View(category);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Category category)
        {
            if (ModelState.IsValid)
            {
                db.Entry(category).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View("Error");
        }

       
            
        public bool Delete(int id) {

            Category cat = db.Categories.FirstOrDefault(e=>e.CategoryID == id);
            var itm = db.Items.Where(e => e.CatergoryID == id).ToList();

            if (cat == null)
            {
                return false;
            }
            else
            {
                foreach (var item in itm)
                {
                    item.CatergoryID = null;
                    db.SaveChanges();
                }

                db.Categories.Remove(cat);
                db.SaveChanges();
                return true;
            }
        }


        public ActionResult ExportCategory()
        {
            List<Category> allCategories = new List<Category>();
            allCategories = db.Categories.ToList();


            ReportDocument rd = new ReportDocument();
            rd.Load(Path.Combine(Server.MapPath("~/Report"), "CategoryReport.rpt"));

            rd.SetDataSource(allCategories);

            Response.Buffer = false;
            Response.ClearContent();
            Response.ClearHeaders();


            Stream stream = rd.ExportToStream(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat);
            stream.Seek(0, SeekOrigin.Begin);
            return File(stream, "application/pdf", "all.pdf");
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
