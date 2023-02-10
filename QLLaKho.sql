Create database QLLaKho
Go
Use QLLaKho
Go

Create table [Sach]
(
	--S001TLXB (S = sach, 001 = stt, TL = the loai, XB = xuat ban)
	[MaSach] Varchar(10) NOT NULL UNIQUE,
	[TenSach] Nvarchar(100) NOT NULL,
	--width x height
	[KichThuoc] Varchar(20),
	[SoTrang] Int,
	[NgayPhatHanh] Smalldatetime,
	[GiaBia] Decimal(7, 3) NOT NULL check (GiaBia >=0),
	[DonGia] Decimal(7, 3) NOT NULL check (DonGia >=0),
	[SoLuongSach] Integer NOT NULL,
	[MoTaSach] Ntext NOT NULL,
	[HinhSach] Varchar(50) NOT NULL,
	[MaNXB] Varchar(9) NOT NULL,
	[MaTG] Varchar(5) NOT NULL,
	[MaTheLoai] Varchar(8) NOT NULL,
	Constraint PK_Sach Primary Key (MaSach)
) 
go

Create table [TheLoai]
(
	--TL001ten (TL = the loai, 001 = stt, ten = vd: TTh)
	[MaTheLoai] Varchar(8) NOT NULL UNIQUE,
	[TenTheLoai] Nvarchar(20) NOT NULL,
	Constraint PK_TheLoai Primary Key (MaTheLoai)
) 
go

Create table [NhaXuatBan]
(
	--NXB001ten (NXB = nha xuat ban, 001 = stt, ten = vd: KD)
	[MaNXB] Varchar(9) NOT NULL UNIQUE,
	[TenNXB] Nvarchar(20) NOT NULL,
	[DiaChiNXB] Nvarchar(80),
	[SdtNXB] Integer,
	Constraint PK_NhaXuatBan Primary Key (MaNXB)
) 
go

Create table [TacGia]
(
	--TG001 (TG = tac gia, 001 = stt)
	[MaTG] Varchar(5) NOT NULL UNIQUE,
	[TenTG] Nvarchar(50) NOT NULL,
	[NgaySinhTG] Datetime,
	[MoTaTG] Nvarchar(500),
	[SdtTG] Integer,
	Constraint PK_TacGia Primary Key (MaTG)
) 
go

Create table [KhachHang]
(
	--KH001
	[MaKH] Varchar(5) NOT NULL UNIQUE,
	[HoDemKH] Nvarchar(30) NOT NULL,
	[TenKH] Nvarchar(20) NOT NULL,
	[DiaChiKH] Nvarchar(80) NOT NULL,
	[SdtKH] Integer NOT NULL,
	[Email] Nvarchar(50) NOT NULL,
	[NgaySinh] Datetime,
	[GioiTinh] Nvarchar(5),
	[TaiKhoan] Varchar(15) NOT NULL UNIQUE,
	[MatKhau] Varchar(20) NOT NULL,
	Constraint PK_KhachHang Primary Key (MaKH)
) 
go

Create table [DonHang]
(
	--DH001
	[MaDH] Varchar(5) NOT NULL UNIQUE,
	[NgayDH] Datetime NOT NULL,
	[GiaDH] Decimal(7, 3) NOT NULL check (GiaDH >= 0),
	[NgayGiaoHang] Datetime NOT NULL,
	[TenNguoiNhan] Nvarchar(50) NOT NULL,
	[DiaChiGiao] Nvarchar(100) NOT NULL,
	[SdtNguoiNhan] Integer NOT NULL,
	[TenNguoiGiao] Nvarchar(50),
	[SdtNguoiGiao] Char(10),
	[HinhThucGiao] Char(10),
	[MaKH] Varchar(5) NOT NULL,
	--Hinh thuc Thanh toan: tra truc tiep, tra online
	[MaHTTT] Varchar(5) NOT NULL,
	Constraint PK_DonHang Primary Key (MaDH)
) 
go

Create table [ThanhToan]
(
	--TT001 (HTTT = hinh thuc thanh toan)
	[MaHTTT] Varchar(5) NOT NULL UNIQUE,
	[TenHTTT] Nvarchar(20) NOT NULL,
	Constraint PK_ThanhToan Primary Key (MaHTTT)
) 
go

Create table [CTDonHang]
(
	[MaSach] Varchar(10) NOT NULL,
	[MaDH] Varchar(5) NOT NULL,
	[SoLuongMua] Integer NOT NULL check (SoLuongMua > 0),
	[GiaTien] Decimal(7, 3) NOT NULL check (GiaTien >= 0),
	[ThanhTien] AS SoLuongMua*GiaTien,
	Constraint PK_CTDH Primary Key (MaSach, MaDH)
) 
go

--Vietnamese - Vietnam	SELECT FORMAT (200.364, 'c', 'vi-VN') as date	200,36 ₫
--xoa du lieu bang de chinh rang buoc, xem rang buoc (CONSTRAINT) o dbo. > Constraints
alter table CTDonHang
add constraint LK_ThanhTien_CK check (thanhtien > 0)

alter table Sach
drop FK_Sach_NhaXuatBan

Drop table CTDonHang
go

ALTER TABLE Sach ADD CONSTRAINT FK_Sach_TheLoai FOREIGN KEY (MaTheLoai) REFERENCES TheLoai(MaTheLoai)
ALTER TABLE Sach ADD CONSTRAINT FK_Sach_NhaXuatBan FOREIGN KEY (MaNXB) REFERENCES NhaXuatBan(MaNXB)
ALTER TABLE Sach ADD CONSTRAINT FK_Sach_TacGia FOREIGN KEY (MaTG) REFERENCES TacGia(MaTG)
ALTER TABLE DonHang ADD CONSTRAINT FK_DonHang_MaHTTT FOREIGN KEY (MaHTTT) REFERENCES ThanhToan(MaHTTT)
ALTER TABLE DonHang ADD CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
ALTER TABLE CTDonHang ADD CONSTRAINT FK_CTDonHang_DonHang FOREIGN KEY (MaDH) REFERENCES DonHang(MaDH)
ALTER TABLE CTDonHang ADD CONSTRAINT FK_CTDonHang_Sach FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)

INSERT INTO TheLoai VALUES ('TL001TTh', N'Tiểu thuyết')
INSERT INTO TheLoai VALUES ('TL002TNg', N'Truyện ngắn')
INSERT INTO TheLoai VALUES ('TL003Tho', N'Thơ')
INSERT INTO TheLoai VALUES ('TL004Kys', N'Ký')
INSERT INTO TheLoai VALUES ('TL005TrT', N'Truyện tranh')

INSERT INTO NhaXuatBan VALUES ('NXB001TE', N'Trẻ', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB002KD', N'Kim Đồng', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB003VH', N'Văn Học', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB004TG', N'Thế Giới', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB005DT', N'Dân Trí', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB006UX', N'Uranix', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB007VV', N'Văn Hóa - Văn Nghệ', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB008NN', N'Nhã Nam', ' ', ' ')

INSERT INTO TacGia VALUES ('TG001', N'Nguyễn Ái Quốc', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG002', N'Hồ Chí Minh', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG003', N'Nguyễn Tuân', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG004', N'Nguyễn Dữ', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG005', N'Thạch Lam', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG006', N'Hoàng phủ Ngọc Tường', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG007', N'Nam Cao', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG008', N'Đoàn Giỏi', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG999', N'Vô danh', ' ', N'(Annonymous) không có danh tính rõ ràng, không có dữ liệu về tác giả, viết bởi người ẩn danh', ' ')

INSERT INTO Sach VALUES ('S001', N'Đất rừng phương nam', '14.5 x 20.5 cm', 304, '2020-04-22', 81.000, 72.900, 999, 
	N'“Được viết bằng trái tim nhạy cảm, tài quan sát tinh tế, hiểu biết sâu sắc và vốn sống dồi dào, Đất rừng phương Nam là một trong những tác phẩm viết về Nam bộ xuất sắc nhất, làm bật lên trọn vẹn vẻ đẹp con người và thiên nhiên nơi đây. Mỗi lần đọc là mỗi lần tình yêu xứ sở được khơi gợi đến nao lòng.”
	(Nhà văn Anh Đức)

	Cái chất thơ mà Đoàn Giỏi gửi vào từng trang bút ký, vốn bắt nguồn từ tình yêu đối với mảnh đất và con người Nam Bộ và được thể hiện trong từng chi tiết miêu tả, trong ngôn ngữ và tính cách nhân vật. Cái “chất liệu Miền Nam” ấy đã đem tới nền văn học của chúng ta trong những năm 50, 60 ngày ấy một sự khởi sắc đầy ấn tượng mới mẻ, hấp dẫn, một thứ bổ sung cho cách nhìn về con người và thiên nhiên vùng đất phương Nam.
	
	Tác phẩm làm nên tên tuổi nhà văn Đoàn Giỏi, gắn liền với thời điểm ra đời của NXB Kim Đồng (tháng 6 năm 1957)

	Tác phẩm tái bản nhiều lần, dịch ra nhiều thứ tiếng và được dựng thành phim truyền hình nhiều tập Đất phương Nam.', 
	'dat-rung-phuong-nam.jpg', 'NXB002KD', 'TG008', 'TL001TTh')
INSERT INTO Sach VALUES ('S002', N'Chí Phèo', ' ', 331, '2020', 81.000, 64.800, 999, null, 'chi-pheo.jpg', 'NXB003VH', 'TG007', 'TL002TNg')
INSERT INTO Sach VALUES ('S003', N'Truyện Kiều', '', 292, '2018', 65.000, 52.000, 999, null, 'truyen-kieu.jpg', 'NXB003VH', 'TG999', 'TL003Tho')
INSERT INTO Sach VALUES ('S004', N'Vang bóng một thời', '', 212, '2018', 70.000, 58.000, 999, null, 'vang-bong-mot-thoi.jpg', 'NXB003VH', 'TG003', 'TL004Kys')
INSERT INTO Sach VALUES ('S005', N'Mười bảy năm ánh sáng', '', 280, '2016', 86.000, 68.700, 999, null, 'muoi-bay-nam-anh-sang.jpg', 'NXB005DT', 'TG999', 'TL005TrT')
INSERT INTO Sach VALUES ('S006', N'Tôi thấy hoa vàng trên cỏ xanh', '', 378, '2018', 112.000, 100.000, 999, null, 'toi-thay-hoa-vang-tren-co-xanh.jpg', 'NXB001TE', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S007', N'Tuổi thơ dữ dội', '', 400, '2020-04-22', 80.000, 72.000, 999, null, 'tuoi-tho-du-doi-t1.jpg', 'NXB002KD', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S008', N'Bến không chồng', '', 352, '2015-05-01', 85.000, 63.750, 999, null, 'ben-khong-chong.jpg', 'NXB001TE', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S009', N'Tắt đèn', '', 216, '2020-05-01', 50.000, 40.000, 999, null, 'tat-den.jpg', 'NXB003VH', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S010', N'Số đỏ', '', 244, '2020-02-01', 65.000, 48.000, 999, null, 'so-do.jpg', 'NXB003VH', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S021', N'Truyền kỳ mạn lục', '', null, null, 53.000, 43.500, 999, null, 'truyen-ky-man-luc.jpg', 'NXB008NN', 'TG004', 'TL004Kys')
INSERT INTO Sach VALUES ('S022', N'Hà Nội băm sáu phố phường', '', 128, '2018-05-01', 70.000, 50.700, 999, null, 'ha-noi-bam-sau-pho-phuong.jpg', 'NXB008NN', 'TG005', 'TL004Kys')
INSERT INTO Sach VALUES ('S023', N'Lời tạ từ gửi một dòng sông', '', null, null, 45.000, 30.000, 999, null, 'loi-ta-tu-gui-mot-dong-song.jpg', 'NXB001TE', 'TG006', 'TL004Kys')
INSERT INTO Sach VALUES ('S024', N'Nhật ký trong tù', '', null, null, 80.000, 61.750, 999, null, 'nhat-ky-trong-tu.jpg', 'NXB003VH', 'TG002', 'TL004Kys')
INSERT INTO Sach VALUES ('S025', N'Bản án chế độ thực dân Pháp', '', null, null, 200.000, 151.000, 999, null, 'ban-an-che-do-thuc-dan-phap.jpg', 'NXB001TE', 'TG001', 'TL004Kys')