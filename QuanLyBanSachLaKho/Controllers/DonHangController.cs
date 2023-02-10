using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using QuanLyBanSachLaKho.Models;

namespace QuanLyBanSachLaKho.Controllers
{
    public class DonHangController : Controller
    {
        private QLLaKhoEntities db = new QLLaKhoEntities();

        // GET: DonHang
        public ActionResult Index()
        {
            var donHangs = db.DonHangs.Include(d => d.KhachHang).Include(d => d.ThanhToan);
            return View(donHangs.ToList());
        }

        // GET: DonHang/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang donHang = db.DonHangs.Find(id);
            db.Entry(donHang).Collection(c => c.CTDonHangs).Load();
            ViewBag.TongTien = db.CTDonHangs.Sum(c => c.ThanhTien);
            if (donHang == null)
            {
                return HttpNotFound();
            }
            return View(donHang);
        }

        /*khong xai
        // GET: DonHang/Create
        public ActionResult Create()
        {
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoDemKH");
            ViewBag.MaHTTT = new SelectList(db.ThanhToans, "MaHTTT", "TenHTTT");
            return View();
        }

        // POST: DonHang/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaDH,NgayDH,GiaDH,NgayGiaoHang,TenNguoiNhan,DiaChiGiao,SdtNguoiNhan,TenNguoiGiao,SdtNguoiGiao,HinhThucGiao,MaKH,MaHTTT")] DonHang donHang)
        {
            if (ModelState.IsValid)
            {
                db.DonHangs.Add(donHang);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoDemKH", donHang.MaKH);
            ViewBag.MaHTTT = new SelectList(db.ThanhToans, "MaHTTT", "TenHTTT", donHang.MaHTTT);
            return View(donHang);
        }

        // GET: DonHang/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang donHang = db.DonHangs.Find(id);
            if (donHang == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoDemKH", donHang.MaKH);
            ViewBag.MaHTTT = new SelectList(db.ThanhToans, "MaHTTT", "TenHTTT", donHang.MaHTTT);
            return View(donHang);
        }

        // POST: DonHang/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaDH,NgayDH,GiaDH,NgayGiaoHang,TenNguoiNhan,DiaChiGiao,SdtNguoiNhan,TenNguoiGiao,SdtNguoiGiao,HinhThucGiao,MaKH,MaHTTT")] DonHang donHang)
        {
            if (ModelState.IsValid)
            {
                db.Entry(donHang).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoDemKH", donHang.MaKH);
            ViewBag.MaHTTT = new SelectList(db.ThanhToans, "MaHTTT", "TenHTTT", donHang.MaHTTT);
            return View(donHang);
        }

        // GET: DonHang/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            DonHang donHang = db.DonHangs.Find(id);
            if (donHang == null)
            {
                return HttpNotFound();
            }
            return View(donHang);
        }

        // POST: DonHang/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            DonHang donHang = db.DonHangs.Find(id);
            db.DonHangs.Remove(donHang);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        */

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
