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
    public class GioHangController : Controller
    {
        private QLLaKhoEntities db = new QLLaKhoEntities();

        public List<GioHang> LayGioHang()
        {
            List<GioHang> gioHang = Session["GioHang"] as List<GioHang>;
            //Neu gio hang chua ton tai thi tao moi va dua vao session
            if(gioHang == null)
            {
                gioHang = new List<GioHang>();
                Session["GioHang"] = gioHang;
            }
            return gioHang;
        }

        /*Chuyen thang den gio hang*/
        public ActionResult MuaNgay (string MaSP)
        {
            //Lay gio hang hien tai
            List<GioHang> tuGioHang = LayGioHang();

            GioHang sanPham = tuGioHang.FirstOrDefault(s => s.MaSach == MaSP);
            //Kiem tra xem co ton tai mat hang trong gio hay chua
            //Neu co thi tang so luong len 1, nguoc lai them vao gio
            if (sanPham == null)
            {
                sanPham = new GioHang(MaSP);
                tuGioHang.Add(sanPham);
            }
            else
            {
                sanPham.LuongMua++;
            }
            //cannot return in public void
            return RedirectToAction("HienThiGioHang", "GioHang");
        }

        /*Them 1 mat hang vao gio hang khi luot xem san pham, khong xay ra su kien chuyen trang*/
        public ActionResult ThemVaoGio(string MaSP)
        {
            //Lay gio hang hien tai
            List<GioHang> tuGioHang = LayGioHang();

            GioHang sanPham = tuGioHang.FirstOrDefault(s => s.MaSach == MaSP);
            //Kiem tra xem co ton tai mat hang trong gio hay chua
            //Neu co thi tang so luong len 1, nguoc lai them vao gio
            if (sanPham == null)
            {
                sanPham = new GioHang(MaSP);
                tuGioHang.Add(sanPham);
            }
            else
            {
                sanPham.LuongMua++;
            }
            //cannot return in public void
            return RedirectToAction("Index", "Home");
        }

        /*Van o lai trang, dong thoi lay dua theo so luong san pham*/
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ThemSanPhamVaoGio(string MaSP, int soSach)
        {
            //Lay value tu name cua soSach va MaSP de gan vao trong ham
            //Lay gio hang hien tai
            List<GioHang> tuGioHang = LayGioHang();

            GioHang sanPham = tuGioHang.FirstOrDefault(s => s.MaSach == MaSP);
            //Kiem tra xem co ton tai mat hang trong gio hay chua
            //Neu co thi tang so luong len tuong duong voi soSach duoc chon, nguoc lai them vao gio == soSach
            if (sanPham == null)
            {
                sanPham = new GioHang(MaSP);
                sanPham.LuongMua = soSach;
                tuGioHang.Add(sanPham);
            }
            else
            {
                sanPham.LuongMua = sanPham.LuongMua + soSach;
            }
            //cannot return in public void
            return RedirectToAction("Xem", "Sach", new { id = MaSP });
        }

        private int TinhTongSL()
        {
            int tongSL = 0;
            List<GioHang> gioHangs = LayGioHang();
            if (gioHangs != null)
                tongSL = gioHangs.Sum(sp => sp.LuongMua);
            return tongSL;
        }

        private decimal TinhTongTien()
        {
            decimal tongTien = 0;
            List<GioHang> gioHangs = LayGioHang();
            if (gioHangs != null)
                tongTien = gioHangs.Sum(sp => sp.TongTien());
            return tongTien;
        }

        public ActionResult HienThiGioHang()
        {
            List<GioHang> gioHangs = LayGioHang();
            
            if(gioHangs == null || gioHangs.Count == 0)
            {
                return RedirectToAction("Index", "Home");
            }

            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            return View(gioHangs);
        }

        public ActionResult NutGioHang()
        {
            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            return PartialView();
        }

        public ActionResult XoaGioHang(bool xoaSP)
        {
            //Lay du lieu tu name = "xoaSP" voi value = "true" dong nghia voi xoaSP = true
            //Khai bao moi gio hang, chen len gio hang cu. Sau khi xoa thi tro ve trang chu
            if (xoaSP)
            { 
                List<GioHang> gioHang = Session["GioHang"] as List<GioHang>;
                gioHang = new List<GioHang>();
                Session["GioHang"] = gioHang;
            }
            return RedirectToAction("Index", "Home");
        }

        public ActionResult XoaNgay(string MaSP, int soSach)
        {
            //Lay gio hang hien tai
            List<GioHang> tuGioHang = LayGioHang();

            GioHang sanPham = tuGioHang.FirstOrDefault(s => s.MaSach == MaSP);
            /*Lay san pham trong gio hang, neu xoa 
            if (soSach > 1) 
            {
                sanPham.LuongMua = sanPham.LuongMua - soSach;
            }
            else tuGioHang.Remove(sanPham);
            if (tuGioHang == null)
            {
                return RedirectToAction("Index", "Home");
            }*/
            //Xoa hoan toan mot mat hang bat ke so luong
            if (sanPham != null)
            {
                tuGioHang.RemoveAll(s => s.MaSach == MaSP);
                return RedirectToAction("HienThiGioHang"); //Quay về trang giỏ hàng
            }
            if (tuGioHang == null) //Quay về trang chủ nếu giỏ hàng không có gì
                return RedirectToAction("Index", "Home");
            return RedirectToAction("HienThiGioHang", "GioHang");
        }

        public ActionResult CapNhatMatHang(string MaSP, int soSach)
        {
            List<GioHang> tuGioHang = LayGioHang();

            //Lấy sản phẩm trong giỏ hàng
            var sanpham = tuGioHang.FirstOrDefault(s => s.MaSach == MaSP);
            if (sanpham != null)
            {
                //Cập nhật lại số lượng tương ứng 
                //Lưu ý số lượng phải lớn hơn hoặc bằng 1
                sanpham.LuongMua = soSach;
            }
            return RedirectToAction("HienThiGioHang"); //Quay về trang giỏ hàng
        }

        /*Mua hang co trong gio hang*/
        [Authorize]
        public ActionResult DatHang()
        {
            if (Session["TaiKhoan"] == null) //Chưa đăng nhập
                return RedirectToAction("DangNhap", "NguoiDung");
            List<GioHang> tuGioHang = LayGioHang();
            if (tuGioHang == null || tuGioHang.Count == 0) //Chưa có giỏ hàng hoặc chưa có sp
                return RedirectToAction("Index", "Home");
            ViewBag.TongSL = TinhTongSL();
            ViewBag.TongTien = TinhTongTien();
            return View(tuGioHang); //Trả về View hiển thị thông tin giỏ hàng
        }

        //Xác nhận đơn và lưu vào CSDL
        public ActionResult DongYDatHang()
        {
            int tangKey = db.DonHangs.Count() + 1;
            KhachHang khach = Session["TaiKhoan"] as KhachHang; //Khách
            List<GioHang> tuGioHang = LayGioHang(); //Giỏ hàng
            DonHang donHang = new DonHang(); //Tạo mới đơn đặt hàng
            donHang.MaDH = TaoMaDH(tangKey);
            donHang.MaKH = khach.MaKH;
            donHang.MaHTTT = "HT001";
            donHang.NgayDH = DateTime.Now;
            donHang.GiaDH = (decimal)TinhTongTien();
            donHang.NgayGiaoHang = DateTime.Now;
            donHang.TenNguoiNhan = khach.TenKH;
            donHang.DiaChiGiao = khach.DiaChiKH;
            donHang.SdtNguoiGiao = "" + khach.SdtKH;
            donHang.HinhThucGiao = "Xe";
            db.DonHangs.Add(donHang);
            db.SaveChanges();
            //Lần lượt thêm từng chi tiết cho đơn hàng trên
            foreach (var sanpham in tuGioHang)
            {
                CTDonHang chitiet = new CTDonHang();
                chitiet.MaSach = sanpham.MaSach;
                chitiet.MaDH = donHang.MaDH;
                chitiet.SoLuongMua = sanpham.LuongMua;
                chitiet.GiaTien = (decimal)sanpham.DonGia;
                db.CTDonHangs.Add(chitiet);
            }
            db.SaveChanges();
            //Xóa giỏ hàng
            Session["GioHang"] = null;
            //return RedirectToAction("Index", "Home");
            return RedirectToAction("HoanThanhDonHang");
        }

        public ActionResult HoanThanhDonHang()
        {
            return View();
        }

        string TaoMaDH(int tangKey)
        {
            //MaDH = "DH000"
            if (0 < tangKey && tangKey < 9) { return "DH00" + tangKey; }
            if (10 <= tangKey && tangKey <= 99) { return "DH0" + tangKey; }
            if (100 <= tangKey && tangKey <= 999) { return "DH" + tangKey; }
            return "DH" + tangKey;
        }

        // GET: GioHangs
        public ActionResult Index()
        {
            return RedirectToAction("HienThiGioHang", "GioHang");
        }        
    }
}
