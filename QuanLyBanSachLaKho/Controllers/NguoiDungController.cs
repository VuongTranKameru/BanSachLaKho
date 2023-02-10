using QuanLyBanSachLaKho.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace QuanLyBanSachLaKho.Controllers
{
    public class NguoiDungController : Controller
    {
        // Use DbContext to manage database
        QLLaKhoEntities db = new QLLaKhoEntities();

        //Phan dang ky (Signin)
        [HttpGet]
        public ActionResult DangKy()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DangKy(KhachHang kh)
        {
            if (ModelState.IsValid)
            {
                int tangKey = db.KhachHangs.Count() + 1;
                if (string.IsNullOrEmpty(kh.HoDemKH))
                    ModelState.AddModelError(string.Empty, "Họ và tên đệm không được để trống");
                if (string.IsNullOrEmpty(kh.TenKH))
                    ModelState.AddModelError(string.Empty, "Tên không được để trống");
                if (string.IsNullOrEmpty(kh.DiaChiKH))
                    ModelState.AddModelError(string.Empty, "Địa chỉ không được để trống");
                if (string.IsNullOrEmpty(kh.Email))
                    ModelState.AddModelError(string.Empty, "Email không được để trống");
                if (string.IsNullOrEmpty(kh.TaiKhoan))
                    ModelState.AddModelError(string.Empty, "Tên đăng nhập không được để trống");
                if (string.IsNullOrEmpty(kh.MatKhau))
                    ModelState.AddModelError(string.Empty, "Mật khẩu không được để trống");

                //Kiểm tra xem có người nào đã đăng kí với tên đăng nhập này hay chưa
                var khachhang = db.KhachHangs.FirstOrDefault(k => k.TaiKhoan == kh.TaiKhoan);
                if (khachhang != null)
                    ModelState.AddModelError(string.Empty, "Đã có người đăng kí tên này");
                if (ModelState.IsValid)
                {
                    kh.MaKH = TaoMaKH(tangKey); 
                    db.KhachHangs.Add(kh);
                    db.SaveChanges();
                }
                else
                {
                    return View();
                }
            }
            return RedirectToAction("DangNhap");
            //return View();
        }

        string TaoMaKH(int tangKey)
        {
            //MaKH = "KH000"
            if (0 < tangKey && tangKey < 9) { return "KH00" + tangKey; }
            if (10 <= tangKey && tangKey <= 99) { return "KH0" + tangKey; }
            if (100 <= tangKey && tangKey <= 999) { return "KH" + tangKey; }
            return "KH" + tangKey;
        }

        //Phan dang nhap (Login)
        //[HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult DangNhap(KhachHang kh)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(kh.TaiKhoan))
                    ModelState.AddModelError(string.Empty, "Tên đăng nhập không được để trống");
                if (string.IsNullOrEmpty(kh.MatKhau))
                    ModelState.AddModelError(string.Empty, "Mật khẩu không được để trống");

                if (ModelState.IsValid)
                {
                    //Tìm khách hàng có tên đăng nhập và password hợp lệ trong CSDL
                    var khach = db.KhachHangs.FirstOrDefault(k => k.TaiKhoan == kh.TaiKhoan && k.MatKhau == kh.MatKhau);
                    if (khach != null)
                    {
                        ViewBag.ThongBao = "Chúc mừng đăng nhập thành công";
                        FormsAuthentication.SetAuthCookie(kh.TaiKhoan, false);
                        //Lưu vào session
                        Session["TaiKhoan"] = khach;
                        //Xác nhận user đã đăng nhập
                    }
                    else
                        ViewBag.ThongBao = "Tên đăng nhập hoặc mật khẩu không đúng";
                }
            }
            //return RedirectToAction("Index", "Home");
            return View();
        }

        public ActionResult DangXuat()
        {
            FormsAuthentication.SignOut();
            //return RedirectToAction("DangNhap", "NguoiDung");
            return RedirectToAction("Index", "Home");
        }
        
        public ActionResult LichSuGiaoHang()
        {
            return View(db.DonHangs.ToList());
        }

        // GET: NguoiDung
        public ActionResult Index()
        {
            //Goi ten tai khoan cua nguoi dung, đưa UserName vào ViewBag thông qua User.Identity.Name
            ViewBag.UserName = User.Identity.Name;
            //Kiem tra xem co user khong
            ViewBag.UserLog = User.Identity.IsAuthenticated;
            return PartialView(db.KhachHangs.ToList());
        }
    }
}