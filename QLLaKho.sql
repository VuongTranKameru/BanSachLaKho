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

--Vietnamese - Vietnam	SELECT FORMAT (200.364, 'c', 'vi-VN') as date	200,36 ???
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

INSERT INTO TheLoai VALUES ('TL001TTh', N'Ti???u thuy???t')
INSERT INTO TheLoai VALUES ('TL002TNg', N'Truy???n ng???n')
INSERT INTO TheLoai VALUES ('TL003Tho', N'Th??')
INSERT INTO TheLoai VALUES ('TL004Kys', N'K??')
INSERT INTO TheLoai VALUES ('TL005TrT', N'Truy???n tranh')

INSERT INTO NhaXuatBan VALUES ('NXB001TE', N'Tr???', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB002KD', N'Kim ?????ng', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB003VH', N'V??n H???c', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB004TG', N'Th??? Gi???i', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB005DT', N'D??n Tr??', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB006UX', N'Uranix', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB007VV', N'V??n H??a - V??n Ngh???', ' ', ' ')
INSERT INTO NhaXuatBan VALUES ('NXB008NN', N'Nh?? Nam', ' ', ' ')

INSERT INTO TacGia VALUES ('TG001', N'Nguy???n ??i Qu???c', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG002', N'H??? Ch?? Minh', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG003', N'Nguy???n Tu??n', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG004', N'Nguy???n D???', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG005', N'Th???ch Lam', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG006', N'Ho??ng ph??? Ng???c T?????ng', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG007', N'Nam Cao', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG008', N'??o??n Gi???i', ' ', ' ', ' ')
INSERT INTO TacGia VALUES ('TG999', N'V?? danh', ' ', N'(Annonymous) kh??ng c?? danh t??nh r?? r??ng, kh??ng c?? d??? li???u v??? t??c gi???, vi???t b???i ng?????i ???n danh', ' ')

INSERT INTO Sach VALUES ('S001', N'?????t r???ng ph????ng nam', '14.5 x 20.5 cm', 304, '2020-04-22', 81.000, 72.900, 999, 
	N'??????????c vi???t b???ng tr??i tim nh???y c???m, t??i quan s??t tinh t???, hi???u bi???t s??u s???c v?? v???n s???ng d???i d??o, ?????t r???ng ph????ng Nam l?? m???t trong nh???ng t??c ph???m vi???t v??? Nam b??? xu???t s???c nh???t, l??m b???t l??n tr???n v???n v??? ?????p con ng?????i v?? thi??n nhi??n n??i ????y. M???i l???n ?????c l?? m???i l???n t??nh y??u x??? s??? ???????c kh??i g???i ?????n nao l??ng.???
	(Nh?? v??n Anh ?????c)

	C??i ch???t th?? m?? ??o??n Gi???i g???i v??o t???ng trang b??t k??, v???n b???t ngu???n t??? t??nh y??u ?????i v???i m???nh ?????t v?? con ng?????i Nam B??? v?? ???????c th??? hi???n trong t???ng chi ti???t mi??u t???, trong ng??n ng??? v?? t??nh c??ch nh??n v???t. C??i ???ch???t li???u Mi???n Nam??? ???y ???? ??em t???i n???n v??n h???c c???a ch??ng ta trong nh???ng n??m 50, 60 ng??y ???y m???t s??? kh???i s???c ?????y ???n t?????ng m???i m???, h???p d???n, m???t th??? b??? sung cho c??ch nh??n v??? con ng?????i v?? thi??n nhi??n v??ng ?????t ph????ng Nam.
	
	T??c ph???m l??m n??n t??n tu???i nh?? v??n ??o??n Gi???i, g???n li???n v???i th???i ??i???m ra ?????i c???a NXB Kim ?????ng (th??ng 6 n??m 1957)

	T??c ph???m t??i b???n nhi???u l???n, d???ch ra nhi???u th??? ti???ng v?? ???????c d???ng th??nh phim truy???n h??nh nhi???u t???p ?????t ph????ng Nam.', 
	'dat-rung-phuong-nam.jpg', 'NXB002KD', 'TG008', 'TL001TTh')
INSERT INTO Sach VALUES ('S002', N'Ch?? Ph??o', ' ', 331, '2020', 81.000, 64.800, 999, null, 'chi-pheo.jpg', 'NXB003VH', 'TG007', 'TL002TNg')
INSERT INTO Sach VALUES ('S003', N'Truy???n Ki???u', '', 292, '2018', 65.000, 52.000, 999, null, 'truyen-kieu.jpg', 'NXB003VH', 'TG999', 'TL003Tho')
INSERT INTO Sach VALUES ('S004', N'Vang b??ng m???t th???i', '', 212, '2018', 70.000, 58.000, 999, null, 'vang-bong-mot-thoi.jpg', 'NXB003VH', 'TG003', 'TL004Kys')
INSERT INTO Sach VALUES ('S005', N'M?????i b???y n??m ??nh s??ng', '', 280, '2016', 86.000, 68.700, 999, null, 'muoi-bay-nam-anh-sang.jpg', 'NXB005DT', 'TG999', 'TL005TrT')
INSERT INTO Sach VALUES ('S006', N'T??i th???y hoa v??ng tr??n c??? xanh', '', 378, '2018', 112.000, 100.000, 999, null, 'toi-thay-hoa-vang-tren-co-xanh.jpg', 'NXB001TE', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S007', N'Tu???i th?? d??? d???i', '', 400, '2020-04-22', 80.000, 72.000, 999, null, 'tuoi-tho-du-doi-t1.jpg', 'NXB002KD', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S008', N'B???n kh??ng ch???ng', '', 352, '2015-05-01', 85.000, 63.750, 999, null, 'ben-khong-chong.jpg', 'NXB001TE', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S009', N'T???t ????n', '', 216, '2020-05-01', 50.000, 40.000, 999, null, 'tat-den.jpg', 'NXB003VH', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S010', N'S??? ?????', '', 244, '2020-02-01', 65.000, 48.000, 999, null, 'so-do.jpg', 'NXB003VH', 'TG999', 'TL001TTh')
INSERT INTO Sach VALUES ('S021', N'Truy???n k??? m???n l???c', '', null, null, 53.000, 43.500, 999, null, 'truyen-ky-man-luc.jpg', 'NXB008NN', 'TG004', 'TL004Kys')
INSERT INTO Sach VALUES ('S022', N'H?? N???i b??m s??u ph??? ph?????ng', '', 128, '2018-05-01', 70.000, 50.700, 999, null, 'ha-noi-bam-sau-pho-phuong.jpg', 'NXB008NN', 'TG005', 'TL004Kys')
INSERT INTO Sach VALUES ('S023', N'L???i t??? t??? g???i m???t d??ng s??ng', '', null, null, 45.000, 30.000, 999, null, 'loi-ta-tu-gui-mot-dong-song.jpg', 'NXB001TE', 'TG006', 'TL004Kys')
INSERT INTO Sach VALUES ('S024', N'Nh???t k?? trong t??', '', null, null, 80.000, 61.750, 999, null, 'nhat-ky-trong-tu.jpg', 'NXB003VH', 'TG002', 'TL004Kys')
INSERT INTO Sach VALUES ('S025', N'B???n ??n ch??? ????? th???c d??n Ph??p', '', null, null, 200.000, 151.000, 999, null, 'ban-an-che-do-thuc-dan-phap.jpg', 'NXB001TE', 'TG001', 'TL004Kys')