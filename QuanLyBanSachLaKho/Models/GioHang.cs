using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace QuanLyBanSachLaKho.Models
{
    public class GioHang
    {
        QLLaKhoEntities db = new QLLaKhoEntities();
        [Key]
        public string MaSach { get; set; }
        public string TenSach { get; set; }
        public string HinhSach { get; set; }
        public decimal DonGia { get; set; }
        public int LuongMua { get; set; }

        //Tinh tong tien = DonGia * SoLuong
        public decimal TongTien()
        {
            return DonGia * LuongMua;
        }

        public GioHang(string MaSach)
        {
            this.MaSach = MaSach;
            var sach = db.Saches.Single(s => s.MaSach == this.MaSach);
            this.TenSach = sach.TenSach;
            this.HinhSach = sach.HinhSach;
            this.DonGia = sach.DonGia;
            this.LuongMua = 1; //so luong mua ban dau khi click vao
        }
    }
}