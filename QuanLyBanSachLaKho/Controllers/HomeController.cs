using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using QuanLyBanSachLaKho.Models;

namespace QuanLyBanSachLaKho.Controllers
{
    public class HomeController : Controller
    {
        // Dung DbContext quan ly database
        QLLaKhoEntities database = new QLLaKhoEntities();

        private List<Sach> LaySach(int soLuong)
        {
            //Lay thu tu sach giam dan (a-z). Muon lay thu tu tang dan thi OrderBy()
            return database.Saches.OrderByDescending
                (sach => sach.MaSach).Take(soLuong).ToList();
        }

        // GET: SachTrungBay
        public ActionResult Index()
        {
            var dsSachMoi = LaySach(3);
            return View(dsSachMoi);
        }

        public ActionResult Go()
        {
            return View();
        }

        //Partial
        //Lay sach co so luong sach it nhat, vi khi co nhieu nguoi mua thi so luong sach giam
        public ActionResult SachBanChay()
        {
            List<Sach> ChonSach = new List<Sach>();
            ChonSach = database.Saches.OrderByDescending
                (sach => sach.SoLuongSach).Take(4).ToList();
            return PartialView(ChonSach);
        }

        //Lay sach co ngay phat hanh gan day nhat
        public ActionResult SachMoi()
        {
            List<Sach> ChonSach = new List<Sach>();
            ChonSach = database.Saches.OrderByDescending
                (sach => sach.NgayPhatHanh).Take(4).ToList();
            return PartialView(ChonSach);
        }

        //Lay sach duoc giam gia
        public ActionResult SachGiamGia()
        {
            List<Sach> ChonSach = new List<Sach>();
            ChonSach = database.Saches.OrderByDescending
                (sach => sach.DonGia).Take(4).ToList();
            return PartialView(ChonSach);
        }

        //Lay sach random
        public ActionResult SachHayMoiTuan()
        {
            List<Sach> ChonSach = new List<Sach>();
            //Guid.NewGuid() lay du lieu random tu database
            ChonSach = database.Saches.OrderBy
                (sach => Guid.NewGuid()).Take(4).ToList();
            return PartialView(ChonSach);
        }

        public ActionResult MucTheLoai()
        {
            var dsTheLoai = database.TheLoais.ToList();
            return PartialView(dsTheLoai);
        }
    }
}