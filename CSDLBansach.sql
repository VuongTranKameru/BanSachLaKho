use master
--Tao CSDL
create database QLBANSACH
GO
use QLBANSACH
GO
Create Table CHUDE
(
	MaCD int Identity(1,1),
	TenChuDe nvarchar(50) NOT NULL,
	CONSTRAINT PK_ChuDe PRIMARY KEY(MaCD)
)
GO
Create Table NHAXUATBAN
(
	MaNXB int identity(1,1),
	TenNXB nvarchar(100) NOT NULL,
	Diachi NVARCHAR(150),
	DienThoai NVARCHAR(15),
	CONSTRAINT PK_NhaXuatBan PRIMARY KEY(MaNXB)
)
GO

CREATE TABLE SACH
(
	Masach INT IDENTITY(1,1),
	Tensach NVARCHAR(100) NOT NULL,
	Donvitinh NVARCHAR(50) DEFAULT 'cuốn',
	Dongia MONEY CHECK (Dongia>=0),
	Mota NTEXT,
	Hinhminhhoa VARCHAR(50),
	MaCD INT,
	MaNXB INT,
	Ngaycapnhat SMALLDATETIME,
	Soluongban INT CHECK(Soluongban>0),
	solanxem INT DEFAULT 0,
	CONSTRAINT PK_Sach PRIMARY KEY(Masach)
)
GO

CREATE TABLE TACGIA
(
	MaTG INT IDENTITY(1,1),
	TenTG NVARCHAR(50) NOT NULL,
	DiachiTG NVARCHAR(100),
	DienthoaiTG VARCHAR(15),
	CONSTRAINT PK_TacGia PRIMARY KEY(MaTG)
)
GO

CREATE TABLE VIETSACH
(
	MaTG INT,
	Masach INT,
	Vaitro NVARCHAR(30),
	CONSTRAINT PK_VietSach PRIMARY KEY(MaTG,Masach)
)
GO

CREATE TABLE KHACHHANG
(
	MaKH INT IDENTITY(1,1),
	HoTenKH nVarchar(50) NOT NULL,
	DiachiKH nVarchar(50),
	DienthoaiKH Varchar(10),
	TenDN Varchar(15) UNIQUE,
	Matkhau Varchar(15) NOT NULL,
	Ngaysinh SMALLDATETIME,
	Gioitinh Bit Default 1,
	Email Varchar(50) UNIQUE,
	Daduyet Bit Default 0,
	CONSTRAINT PK_KhachHang PRIMARY KEY(MaKH)
)
GO

CREATE TABLE DONDATHANG
(
	SoDH INT IDENTITY(1,1),
	MaKH INT,
	NgayDH SMALLDATETIME,
	Trigia Money Check (Trigia>0),
	Dagiao Bit Default 0,
	Ngaygiaohang SMALLDATETIME,
	Tennguoinhan nvarchar(50),
	Diachinhan nvarchar(50),
	Dienthoainhan Varchar(15),
	HTThanhtoan Bit Default 0,
	HTGiaohang Bit Default 0,
	CONSTRAINT PK_DonDatHang PRIMARY KEY(SoDH)
)
GO

CREATE TABLE CTDATHANG
(
	SoDH INT,
	Masach INT,
	Soluong Int Check(Soluong>0),
	Dongia Decimal(9,2) Check(Dongia>=0),
	Thanhtien AS SoLuong*Dongia ,
	CONSTRAINT PK_CTDatHang PRIMARY KEY(SoDH,Masach)
)
GO

CREATE TABLE THAMDO
(
	MaCH INT IDENTITY(1,1),
	Ngaydang SMALLDATETIME,
	Noidungthamdo nVarchar(255) NOT NULL,
	Tongsobinhchon Int Default 0,
	CONSTRAINT PK_ThamDo PRIMARY KEY(MaCH)
)
GO

CREATE TABLE CTTHAMDO
(
	MaCH INT,
	STT INT,
	Noidungtraloi nVarchar(255) NOT NULL,
	Solanbinhchon Int Default 0,
	CONSTRAINT PK_CTThamDo PRIMARY KEY(MaCH,STT)
)
GO


CREATE TABLE QUANGCAO
(
	STT INT IDENTITY(1,1),
	TenCty nVarchar(200) NOT NULL,
	Hinhminhhoa Varchar(20),
	Href Varchar(100),
	Ngaybatdau SMALLDATETIME,
	Ngayhethan SMALLDATETIME,
	CONSTRAINT PK_QuangCao PRIMARY KEY(STT)
)
GO

ALTER TABLE SACH ADD CONSTRAINT FK_Sach_ChuDe FOREIGN KEY (MaCD) REFERENCES CHUDE(MaCD)
ALTER TABLE SACH ADD CONSTRAINT FK_Sach_NhaXuatBan FOREIGN KEY (MaNXB) REFERENCES NHAXUATBAN(MaNXB)
ALTER TABLE VIETSACH ADD CONSTRAINT FK_VietSach_TacGia FOREIGN KEY (MaTG) REFERENCES TACGIA(MaTG)
ALTER TABLE VIETSACH ADD CONSTRAINT FK_VietSach_Sach FOREIGN KEY (Masach) REFERENCES SACH(Masach)
ALTER TABLE DONDATHANG ADD CONSTRAINT FK_DonDatHang_KhachHang FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
ALTER TABLE CTDATHANG ADD CONSTRAINT FK_CTDatHang_DonDatHang FOREIGN KEY (SoDH) REFERENCES DONDATHANG(SoDH)
ALTER TABLE CTDATHANG ADD CONSTRAINT FK_CTDatHang_Sach FOREIGN KEY (SoDH) REFERENCES SACH(Masach)
ALTER TABLE CTTHAMDO ADD CONSTRAINT FK_CTThamDo_ThamDo FOREIGN KEY (MaCH) REFERENCES THAMDO(MaCH)
GO

/****** Object:  Table [dbo].[CHUDE]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[CHUDE] ON
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (1, N'Ngoại ngữ')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (2, N'Công nghệ thông tin')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (3, N'Luật')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (4, N'Văn học')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (5, N'Khoa học kỹ thuật')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (6, N'Nông nghiệp')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (7, N'Triết học-Chính trị')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (8, N'Lịch sử, địa lý')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (9, N'Kinh tế')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (10, N'Sách giáo khoa')
INSERT [dbo].[CHUDE] ([MaCD], [Tenchude]) VALUES (11, N'Nghệ thuật sống')
SET IDENTITY_INSERT [dbo].[CHUDE] OFF

/****** Object:  Table [dbo].[KHACHHANG]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[KHACHHANG] ON
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (1, N'Dương Thành Phết', N'Trần Huy Liệu', N'0918062755', N'phetcm', N'123', CAST(0x59310000 AS SmallDateTime), 1, N'pvkhoa@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (2, N'Nguyễn Tiến Luân', N'Quận 6', N'Chua có', N'thang', N'123456', CAST(0x6A570000 AS SmallDateTime), 1, N'ntluan@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (3, N'Đặng Quốc Hòa', N'Sư Vạn Hạnh', N'Chua có', N'dqhoa', N'hoa', CAST(0x5D890000 AS SmallDateTime), 1, N'dqhoa@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (4, N'Ngô Ngọc Ngân', N'Khu chung cư', N'0918544699', N'nnngan', N'ngan', CAST(0x42830000 AS SmallDateTime), 1, N'nnngan@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (5, N'Đỗ Quỳnh Hương', N'Cống Quỳnh', N'0908123456', N'dqhuong', N'huong', CAST(0x75500000 AS SmallDateTime), 0, N'dqhuong@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (6, N'Trần Thị Thu Trang', N'Nơ Trang Long', N'Chua có', N'ttttrang       ', N'trang          ', CAST(0x594D0000 AS SmallDateTime), 0, N'ttrang@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (7, N'Nguyễn Thiên Thanh', N'Hai Bà Trưng', N'0908320111', N'ntthanh', N'thanh', CAST(0x71130000 AS SmallDateTime), 0, N'ntthanh@t3h.hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (8, N'Trần Thị Hải Yến', N'Trần Hưng Đạo', N'8111111   ', N'tthyen', N'yen', CAST(0x6BC40000 AS SmallDateTime), 0, N'tthyan@vol.vnn.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (9, N'Nguyễn Thị Thanh Mai', N'Trần Quang Diệu', N'81111222', N'nttmai         ', N'mai            ', CAST(0x75FF0000 AS SmallDateTime), 0, NULL)
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (10, N'Nguyễn Thành Danh', N'Cộng Hòa', N'8103751   ', N'ntdanh', N'danh', CAST(0x6EA00000 AS SmallDateTime), 1, N'ntdanh@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (11, N'Phạm Thị Nga', N'Q6 - Tp.HCM', N'0831564512', N'ptnga', N'nga', CAST(0x93D90000 AS SmallDateTime), 0, N'ptnhung@hcmuns.edu.vn')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (12, N'Lê Doanh Doanh', N'2Bis Hùng Vương', N'07077865', N'lddoanh', N'doanh', CAST(0x6E590000 AS SmallDateTime), 0, N'lddoanh@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (13, N'Đòan Ngọc Minh Tâm', N'2 Đinh Tiên Hòang', N'0909092222', N'dnmtam', N'tam', CAST(0x6FCF0000 AS SmallDateTime), 0, N'ndmtam@yahoo.com')
INSERT [dbo].[KHACHHANG] ([MaKH], [HotenKH], [DiachiKH], [DienthoaiKH], [TenDN], [Matkhau], [Ngaysinh], [Gioitinh], [Email]) VALUES (14, N'Trần Khải Nhi', N'3 Bùi Hữu Nghĩa', N'0909095555', N'tknhi', N'nhi', CAST(0x727E0000 AS SmallDateTime), 1, N'tknhi@yahoo.com')
SET IDENTITY_INSERT [dbo].[KHACHHANG] OFF

/****** Object:  Table [dbo].[QUANGCAO]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[QUANGCAO] ON
INSERT [dbo].[QUANGCAO] ([STT], [TenCTy], [HinhMinhHoa], [HREF], [Ngaybatdau], [Ngayhethan]) VALUES (1, N'Thời trang Việt Nam', N'Thoitrang.gif', N'http://www.vietfashion.vn/', CAST(0x96500000 AS SmallDateTime), CAST(0x9CBD0000 AS SmallDateTime))
INSERT [dbo].[QUANGCAO] ([STT], [TenCTy], [HinhMinhHoa], [HREF], [Ngaybatdau], [Ngayhethan]) VALUES (2, N'Bột giặt Omo', N'Omo.gif', N'http://www.haydetretudo.com.vn/', CAST(0x96500000 AS SmallDateTime), CAST(0x9EFE0000 AS SmallDateTime))
INSERT [dbo].[QUANGCAO] ([STT], [TenCTy], [HinhMinhHoa], [HREF], [Ngaybatdau], [Ngayhethan]) VALUES (3, N'Bánh Trung thu', N'Trungthu.gif', N'http://demo10.webinvietnam.com/For_Ad/h/hanobaco/', CAST(0x96500000 AS SmallDateTime), CAST(0x9E480000 AS SmallDateTime))
INSERT [dbo].[QUANGCAO] ([STT], [TenCTy], [HinhMinhHoa], [HREF], [Ngaybatdau], [Ngayhethan]) VALUES (4, N'Sữa Cô gái Hà Lan', N'Fristi.gif', N'http://www.dutchlady.com.vn', CAST(0x96500000 AS SmallDateTime), CAST(0x9E2A0000 AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[QUANGCAO] OFF

/****** Object:  Table [dbo].[TACGIA]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[TACGIA] ON
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (1, N'Phạm Công Anh', N'197 Trần Hưng Đạo', N'98877668')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (2, N'Nguyễn Thế Giang', N'179 Chánh hưng - F.4 - Q.8 Tp.HCM', N'19001611')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (3, N'Lê Việt Nhân', N'45 Lý Thái Tổ-F2.Q.3 Tp.HCM', N'19001570')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (4, N'Hồng Phúc', N'', N'')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (5, N'Ks.Phạm Quang Huy', N'', N'')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (6, N'Nguyễn Bá Tiến', N'', N'')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (7, N'Phạm Hữu Khang', N'', N'')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (8, N'Nguyễn Minh Đức', NULL, NULL)
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (9, N'Trần Văn Lăng', NULL, NULL)
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (10, N'Quách Tuấn Ngọc', NULL, NULL)
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (11, N'Nguyễn Xuân Huy', NULL, NULL)
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (12, N'Đoàn Khắc Độ', NULL, NULL)
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (13, N'Nguyễn Tấn Tín', N'179 Chánh Hưng F.4 Q.8 Tp.HCM', N'8504122')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (14, N'Phạm Phan Trung', N'124 Bắc Hải P.6 Q.TB', N'0918121188')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (15, N'TS. Nguyễn Phương Liên', N'', N'')
INSERT [dbo].[TACGIA] ([MaTG], [TenTG], [DiachiTG], [DienthoaiTG]) VALUES (16, N'BS. Vũ Thị Uyên Thanh', N'', N'')
SET IDENTITY_INSERT [dbo].[TACGIA] OFF


/****** Object:  Table [dbo].[NHAXUATBAN]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[NHAXUATBAN] ON
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (1, N'Nhà xuất bản Trẻ', N'124 Nguyễn Văn Cừ Q.1 Tp.HCM', N'19001560')
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (2, N'NXB Thống kê', N'Đồng Nai', N'19001511')
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (3, N'Kim đồng', N'Tp.HCM', N'19001570')
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (4, N'Đại học quốc gia', N'Tp.HCM', N'0908419981')
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (5, N'Văn hóa nghệ thuật', N'Đà Nẵng', N'0903118833')
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (6, N'Văn hóa', N'Bình Dương', N'0913336677')
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (7, N'Lao động - Xã hội', N'Tp.HCM', N'0989888888')
INSERT [dbo].[NHAXUATBAN] ([MaNXB], [TenNXB], [Diachi], [Dienthoai]) VALUES (8, N'Khoa Học & Kỹ Thuật', N'Hà Nội', N'8351056')
SET IDENTITY_INSERT [dbo].[NHAXUATBAN] OFF

/****** Object:  Table [dbo].[SACH]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[SACH] ON
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (1, N'Giáo trình Tin học cơ bản', 26000, N'Cuốn', N'Nội dung của cuốn: Tin Học Cơ Bản Windows XP gồm có 7 chương:
Chương 1: Một số vấn đề cơ bản. 
Chương 2: Sử dụng nhanh thanh công cụ và thanh thực đơn trong My Computer và Windows Explorer. 
Chương 3: Các thao tác trong windows XP. 
Chương 4: Các thiết lập trong Windows XP. 
Chương 5: Bảo trì máy tính. 
Chương 6: Các phím tắt 
Chương 7: Hỏi và đáp các thắc mắc.
Xin trân trọng giới thiệu cuốn sách cùng bạn', N'Book01.jpg', 7, 1, CAST(0x95270000 AS SmallDateTime), 120, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (2, N'Giáo trình Tin học văn phòng', 12000, N'Cuốn', N'Cuốn sách này gồm 3 phần sau:
Phần 1: Xử lý văn bản trong Microsoft Office Word 2007. 
Phần 2: Xử lý bảng tính trong Microsoft Office Excel 2007. 
Phần 3: Quản lý cơ sở dữ liệu trong Microsoft Office Access 2007.
Xin trân trọng giới thiệu cùng các bạn.', N'TH004.jpg', 3, 2, CAST(0x94FD0000 AS SmallDateTime), 25, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (3, N'Lập Trình Cơ Sở Dữ Liệu Với Visual Basic 2005 Và ADO.NET 2.0', 11500, N'Cuốn', N'Cuốn sách "Lập Trình Cơ Sở Dữ Liệu Với Visual Basic 2005 Và ADO.NET 2.0" này giới thiệu các nội dung sau:
Chương 1: Căn bản về cơ sở dữ liệu.
Chương 2: Các bộ kết nối và tương tác dữ liệu.
Chương 3: Bộ chứa dữ liệu DataSet.
Chương 4: Bộ điều hợp dữ liệu DataAdapter.
Chương 5: Sử dụng các điều khiển ràng buộc dữ liệu.
Chương 6: Tạo báo cáo với Crystal Report.
Chương 7: ADO.NET và XML.
Xin trân trọng giới thiệu cùng các bạn.', N'Gt_Thcb.jpg', 7, 3, CAST(0x95220000 AS SmallDateTime), 23, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (4, N'Visual Basic 2005 Tập 3, Quyển 2: Lập Trình Web', 20000, N'Cuốn', N'"Visual Basic 2005 Tập 3, Quyển 2: Lập Trình Web Với Cơ Sở Dữ Liệu" sẽ cung cấp kỹ thuật và hướng dẫn bạn:
Tự học xây dựng ứng dụng Web quản lý CSDL toàn diện với ADO.NET 2.0 và ASP.NET. 
Khai thác các đối tượng và nguồn dữ liệu dành cho WebForm. 
Sử dụng các điều khiển dữ liệu đặc thù dành riêng cho ASP.NET và Web. 
Làm quen với những khái niệm xử lý dữ liệu hoàn toàn mới. 
Ràng buộc dữ liệu với các thành phần giao diện Web Forms. 
Thiết kế ứng dụng Web "Quản lý CD Shop" trực quan và thực tế. 
Cung cấp một kiến thức hoàn chỉnh về Web cho các bạn yêu thích ngôn ngữ Visual Basic và .NET Framework.
Sách có kèm theo CD-ROM bài tập.
Xin trân trọng giới thiệu cùng các bạn.', N'Book01.jpg', 8, 4, CAST(0x95280000 AS SmallDateTime), 240, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (5, N'Giáo trình Tin học quản lý 1', 21000, N'Cuốn', N'Mạng Máy Tính Và Hệ Thống Bảo Mật gồm 7 chương:
Chương I: Tổng quan về công nghệ mạng máy tính và mạng cục bộ.
Chương II: Các thiết bị mạng thông dụng và các chuẩn kết nối vật lý.
Chương III: TCP/IP và mạng Internet.
Chương IV: Hệ điều hành mạng đặc điểm của hệ điều hành mạng.
Chương V: Một số vấn đề an toàn và bảo mật thông tin trên mạng máy tính.
Chương VI: Giới thiệu hệ điều hành Windows NT.
Chương VII: Giới thiệu hệ điều hành UNIX.
Trân trọng giới thiệu.', N'TH001.jpg', 3, 1, CAST(0x950A0000 AS SmallDateTime), 16, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (6, N'Giáo trình Tin học quản lý 2', 21000, N'Cuốn', N'Mục đích của bộ sách này giúp bạn trở nên thành thạo cơ sở dữ liệu (CSDL) Oracle9i, đề cập đến tất cả những kiến thức cần thiết từ mô hình dữ liệu, quản trị CSDL, sao lưu phục hồi, mạng và xử lý sự cố cũng như hiệu chỉnh hiệu suất thực thi..., với sự kết hợp lý thuyết và thực hành về điều mà Nhà quản trị CSDL Oracle9i cần biết để sử dụng CSDL Oracle9i một cách hiệu quả từ chính bộ sách này.
Bộ sách được chia làm 2 tập, tập 1 đề cập các kiến thức cơ bản về CSDL, mô hình dữ liệu. Bạn sẽ được biết về hệ quản trị CSDL Oracle9i, tạo CSDL, kết nối và quản lý người dùng. Tập 2 hướng dẫn bạn cách nạp, sao lưu và phục hồi dữ liệu, quản lý hoạt động CSDL Oracle9i, thực hiện hiệu chỉnh hiệu suất thực thi và xử lý sự cố cho CSDL.
Xin trân trọng giới thiệu Tập 1 cùng các bạn.', N'Book01.jpg', 10, 5, CAST(0x94E80000 AS SmallDateTime), 65, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (7, N'Giáo trình SQL Server', 18000, N'Cuốn', N'Hệ quản trị cơ sở dữ liệu SQl Server 2003
Test thu', N'Book01.jpg', 3, 6, CAST(0x95450000 AS SmallDateTime), 5, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (8, N'Phong Cách Quản Lý Kinh Doanh Hiện Đại ', 61000, N'Cuốn', N'Cuốn sách này không đi vào chi tiết những chủ đề quản lý cổ điển đã được nhắc đến trong nhiều cuốn sách khác như tổ chức cuộc họp, cung cấp số liệu, quản lý thời gian. Mục đích của cuốn sách này là mang lại cho bạn "nhiều hơn", một giá trị gia tăng so với những gì bạn đã biết và đã áp dụng, và giúp bạn tối ưu hóa việc quản lý chuyên môn và quản lý nhân sự.
Nội dung sách bao gồm 9 chương:
Chương 1: Bốn cách nhìn quản lý theo sắc màu.
Chương 2: Quản lý các sắc màu của một cộng tác viên.
Chương 3: Quản lý nhóm theo màu sắc.
Chương 4: Quyết định cách thích hợp dựa vào bản thân, người khác và hoàn cảnh.
Chương 5: Phát triển hiệu quả tối ưu theo sắc màu.
Chương 6: Hiểu rõ những sai lệch trong cách quản lý của mình.
Chương 7: Nền tảng cơ sở của hệ thống Success Insights: Bốn màu với tám kiểu.
Chương 8: Nhận biết và quản lý tám kiểu cộng tác viên.
Chương 9: Cải thiện người quản lý.
Xin trân trọng giới thiệu. 
', N'Book01.jpg', 9, 8, CAST(0x93F60000 AS SmallDateTime), 5, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (10, N'Cán Bộ Quản Lý Trong Sản Xuất Công Nghiệp', 25000, N'Cuốn', N'Cuốn sách này gồm những nội dung chính sau:
Phần 1: Quản lý sản xuất công nghiệp trong kinh tế thị trường
- Kinh doanh sản xuất công nghiệp trong kinh tế thị trường
- Sự cần thiết và các chức năng của quản lý nhà nước đối với doanh nghiệp sản xuất công nghiệp
- Nội dung và tính chất của những công việc mà cán bộ quản lý sản xuất công nghiệp phải đảm nhiệm, hoàn thành.
- Kinh nghiệm đào tạo và đánh giá cán bộ quản lý kinh doanh ở Nhật.
Phần 2: Thực trạng và một số giải pháp nhằm nâng cao chất lượng đội ngũ cán bộ quản lý sản xuất công nghiệp Việt Nam
- Thực trạng cán bộ quản lý doanh nghiệp công nghiệp của Việt Nam
- Tiêu chuẩn hóa cán bộ quản lý sản xuất công nghiệp Việt Nam
- Đổi mới căn bản nội dung và phương pháp đào tạo cán bộ quản lý sản xuất công nghiệp Việt Nam
Xin trân trọng giới thiệu. 
 
', N'Book01.jpg', 5, 6, CAST(0x93E20000 AS SmallDateTime), 89, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (11, N'Tư Duy Chiến Lược (Quản Lý - Tại Sao? Thế Nào?', 18000, N'Cuốn', N'Khả năng hoạch định dài hạn đồng thời tối ưu hóa tình hình hoạt động ngắn hạn là một yêu cầu bắt buộc phải có đối với các nhà quản lý.Tư Duy Chiến Lược sẽ giúp bạn vạch ra con đường đến thành công đồng thời giúp hình thành các kỹ năng phân tích và hoạch định theo nhóm. Tất cả các lĩnh vực then chốt để hình thành và thực thi một chiến lược đều được trình bày cặn kẽ trong cuốn sách này, từ việc nghiên cứu và thu thập thông tin nền tảng, hình thành một chiến lược mới đến việc xem xét và ứng dụng chiến lược ấy. Cả thảy có 101 chỉ dẫn nhằm cung cấp cho các bạn những lời khuyên thực tiễn hơn, đồng thời bài tập tự đánh giá sẽ giúp bạn xác định xem mình là một nhà tư duy chiến lược hiệu quả đến mức nào. Khi bạn có nhiều tham vọng hơn về việc hoạch định cho tương lai, cẩm nang này sẽ là quyển sách tham khảo không thể thiếu, giúp suy nghĩ của bạn đi đúng hướng.
Xin trân trọng giới thiệu cuốn sách cùng bạn. ', N'Book01.jpg', 11, 3, CAST(0x93F90000 AS SmallDateTime), 8, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (12, N'Quản Lý Dự Án (Quản Lý - Tại Sao? Thế Nào?) ', 61000, N'Cuốn', N'Để thành công trong môi trường kinh doanh cạnh tranh hiện nay, các giám đốc dự án phải đạt được kết quả trong phạm thời gian và ngân sách đưa ra. Biết cách áp dụng các quy trình, phương pháp và kỹ thuật chỉ dẫn trong cuốn Quản Lý Dự Án này, bạn sẽ tăng tối đa khả năng thực hiện công việc và đảm bảo đạt kết quả tối ưu khi thực hiện dự án.
Được thiết kế phù hợp với tất cả các nhà quản lý ở đủ mọi trình độ, cẩm nang này sẽ trang bị cho bạn những kiến thức cần thiết trong việc quản lý mọi dự án, dù lớn hay nhỏ, để đạt đến thành công. Từ việc khởi xướng một dự án, thúc đẩy, phát triển nhóm dự án đến việc vượt qua những khó khăn, trở ngại; mỗi một khía cạnh của quản lý dự án chuyện nghiệp đều được trình bày một cách rõ nét. Cẩm nang bao gồm các hướng dẫn từng bước về hoạch định dự án và 101 mẹo vặt cung cấp cho bạn những lời khuyên thực tế. 
', N'Book01.jpg', 4, 8, CAST(0x93B70000 AS SmallDateTime), 4, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (13, N'Điều Chỉnh Một Số Chính Sách Kinh Tế Ở Trung Quốc (Giai Đoạn 1992 - 2010)', 21000, N'Cuốn', N'Cuốn sách này tập trung vào một số nội dung chính sau đây:

Tìm hiểu về những nhân tố đòi hỏi Trung Quốc phải điều chỉnh chính sách kinh tế.

Tìm hiểu về những nội dung chính trong điều chỉnh kinh tế ở Trung Quốc giai đoạn từ năm 1992 - 2010.

Tìm hiểu về tác động của việc điều chỉnh chính sách kinh tế của Trung Quốc đối với thế giới và khu vực trong đó có Việt Nam, sau đó rút tỉa một số kinh nghiệm của Trung Quốc trong quá trình điều chỉnh chính sách kinh tế mà Việt Nam có thể tham khảo.
Tập thể tác giả tham gia công trình này đều là những người chuyên nghiên cứu về Trung Quốc, hy vọng sẽ đem lại cho các bạn nhiều thông tin bổ ích.', N'Book01.jpg', 1, 7, CAST(0x94E80000 AS SmallDateTime), 19, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (14, N'30 phút mỗi ngày để luyện kỹ năng viết câu tiếng Anh', 85000, N'Cuốn', N'30 phút mỗi ngày để luyện kỹ năng viết câu tiếng Anh là một cuốn sách bài tập dành cho những học sinh/sinh viên nghiêm túc quan tâm đến tầm quan trọng của việc nâng cao những yếu tố kỹ thuật cho kỹ năng viết của mình. Rèn luyện để viết cho tốt chẳng khác gì tự trang bị cho mình một sức mạnh cần thiết để thành công - khi đi học cũng như khi ra ngoài xã hội. Trui rèn được một trình độ viết “cứng” không hề là chuyện bỗng nhiên trời cho mà có được; đó phải là kết quả của một quá trình phấn đấu bền bỉ và rèn luyện chăm chỉ.

Đặc nét của sách này là sử dụng cách tiếp cận những kỹ thuật kết hợp câu cơ bản, có nghĩa là, sách không chỉ quan tâm đến việc tránh những sai lỗi, mà còn đặt mục tiêu tạo dựng được những câu hay, linh hoạt, và thể hiện một phong cách riêng. Cạnh đó, sách còn có những điểm đáng lưu ý như: 

- Bàn thảo rõ ràng về những qui tắc và kỹ thuật giúp viết tốt.

- Giải thích súc tích, hạn chế dùng những thuật ngữ ngữ pháp.

- Lương bài tập phong phú, đa dạng, từ những câu hỏi điền vào chỗ trống với mục đích xác định các từ loại cho đến những câu hỏi kết hợp những câu ngắn thành những câu văn dài hơn, ý tứ “duyên” hơn.

- Đáp án cuối sách nhằm giúp học sinh/sinh viên học và nghiên cứu nhanh chậm theo trình độ và ý thích của mình, đồng thời kiểm tra được bài làm trong quá trình học tập.

Học sinh/sinh viên tiếp thu tốt nhất khi họ tham gia tích cực và quá trình học. Họ rất thích những bài tập nào rèn cho họ được những kỹ năng viết họ cần đồng thời có giá trị thông tin nào đó hoặc vui vui. Đó chính là lý do cuốn sách này sử dụng đủ loại chủ đề thú vị trong các bài tập. Cũng vì lý do tương tự, sách có phần trình bày và giảng giải rất ngắn gọn những đưa ra rất nhiều những ví dụ và minh họa mở rộng.

Sử dụng cuốn 30 phút mỗi ngày để luyện kỹ năng viết câu tiếng Anh này sẽ giúp học sinh/sinh viên viết “có nghề” và tự tin hơn".', N'Book01.jpg', 2, 1, CAST(0x8FB30000 AS SmallDateTime), 7, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (15, N'Tin Học Ứng Dụng: Thành Thạo Oracle 9i - Quản Trị Cơ Sở Dữ Liệu (Tập 1) ', 21000, N'Cuốn', N'Mục đích của bộ sách này giúp bạn trở nên thành thạo cơ sở dữ liệu (CSDL) Oracle9i, đề cập đến tất cả những kiến thức cần thiết từ mô hình dữ liệu, quản trị CSDL, sao lưu phục hồi, mạng và xử lý sự cố cũng như hiệu chỉnh hiệu suất thực thi..., với sự kết hợp lý thuyết và thực hành về điều mà Nhà quản trị CSDL Oracle9i cần biết để sử dụng CSDL Oracle9i một cách hiệu quả từ chính bộ sách này.
Bộ sách được chia làm 2 tập, tập 1 đề cập các kiến thức cơ bản về CSDL, mô hình dữ liệu. Bạn sẽ được biết về hệ quản trị CSDL Oracle9i, tạo CSDL, kết nối và quản lý người dùng. Tập 2 hướng dẫn bạn cách nạp, sao lưu và phục hồi dữ liệu, quản lý hoạt động CSDL Oracle9i, thực hiện hiệu chỉnh hiệu suất thực thi và xử lý sự cố cho CSDL.
Xin trân trọng giới thiệu Tập 1 cùng các bạn. ', N'Book01.jpg', 1, 2, CAST(0x93F60000 AS SmallDateTime), 28, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (16, N'Mạng Máy Tính Và Hệ Thống Bảo Mật ', 23000, N'Cuốn', N'Mạng Máy Tính Và Hệ Thống Bảo Mật gồm 7 chương:
Chương I: Tổng quan về công nghệ mạng máy tính và mạng cục bộ.
Chương II: Các thiết bị mạng thông dụng và các chuẩn kết nối vật lý.
Chương III: TCP/IP và mạng Internet.
Chương IV: Hệ điều hành mạng đặc điểm của hệ điều hành mạng.
Chương V: Một số vấn đề an toàn và bảo mật thông tin trên mạng máy tính.
Chương VI: Giới thiệu hệ điều hành Windows NT.
Chương VII: Giới thiệu hệ điều hành UNIX.
Trân trọng giới thiệu. 
', N'Book01.jpg', 4, 1, CAST(0x924B0000 AS SmallDateTime), 4, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (17, N'Thủ Thuật Lập Trình Visual Basic 6 ', 18000, N'Cuốn', N'Mục Lục:
Chương 1: Multimedia.
Chương 2: String.
Chương 3: Form.
Chương 4:Windows Control.
Chương 5: Common Control.
Chương 6: System.
Chương 7: Disk - File.
Chương 8: Graphics.
Chương 9: Internet.
Chương 10: Microsoft Office.
Chương 11: Database.
Chương 12: Clipboard.
Chương 13: Các vấn đề khác.
Phụ lục A: Giới thiệu một số ActiveX Control.
Phụ lục B: Một số tiện ích hỗ trợ lập trình Win32 API.
Phụ lục C: Một số vấn đề về đóng gói phần mềm.
Phụ lục D: Giới thiệu một số Website về Visual Basic.
Trân trọng giới thiệu. 
', N'Book01.jpg', 6, 7, CAST(0x955F0000 AS SmallDateTime), 5, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (18, N'Lập Trình Mạng Trên Windows (Ấn bản dành cho sinh viên) ', 16800, N'Cuốn', N'Chào mừng đến với "Lập Trình Mạng Trên Windows (Ấn bản dành cho sinh viên)". Quyển sách này sẽ hướng dẫn bạn sử dụng một cách hiệu quả bao gồm một số lượng lớn và đa dạng các hàm mạng sẵn có trong Windows 95, Windows 98, Windows NT 4, Windows CE, và Windows 2000/XP/. NET. Sách được chủ định viết dành cho những lập trình viên từ trung cấp đến cao cấp, tuy nhiên những lập trình viên mới bắt đầu tìm hiểu lập trình mạng cũng sẽ nhận thấy đây là một quyển sách không thể thiếu cho các bước xây dựng ứng dụng mạng sau này.
', N'Book01.jpg', 5, 5, CAST(0x94E80000 AS SmallDateTime), 8, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (19, N'Căn Bản Về Photoshop CS Tinh Chỉnh Và Xử Lý Màu ', 25000, N'Cuốn', N'"Căn Bản Về Photoshop CS Tinh Chỉnh Và Xử Lý Màu" gồm 12 chương:
Chương 1: Những điểm cơ bản.
Chương 2: Màu Photoshop.
Chương 3: Các tác vụ xử lý ảnh căn bản.
Chương 4: Các điểm cơ bản về pixel.
Chương 5: Các điểm cơ bản về lớp.
Chương 6: Làm việc với các công cụ chọn.
Chương 7: Ghép ảnh.
Chương 8: Làm việc với các palette History.
Chương 9: Các kỹ thuật điều chỉnh hình ảnh.
Chương 10: Chọn các màu.
Chương 11: Tô màu lại.
Chương 12: Làm việc với các công cụ tô vẽ.
Xin trân trọng giới thiệu. ', N'Book01.jpg', 1, 6, CAST(0x95450000 AS SmallDateTime), 56, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (20, N' Hướng Dẫn Sử Dụng Norton AntiVirus 2004 (Hướng dẫn bằng hình)  
 ', 16800, N'Cuốn', N'"Hướng Dẫn Sử Dụng Norton AntiVirus 2004 (Hướng dẫn bằng hình)" bao gồm 6 phần, 23 chương:
Phần I: Bắt đầu với Norton AntiVirus 2004.
Chương 1: Bắt đầu với Norton AntiVirus 2004.
Chương 2: Cài đặt Norton System Works Professional.
Chương 3: Các điểm cơ bản về Norton AntiVirus 2004.
Chương 4: Các tùy chọn trong Norton SystemWorks.
Chương 5: Cải tiến sự trình duyệt Web và phục hồi đĩa cứng.
Chương 6: Duy trì tính bảo mật password và cập nhật với LiveUpdate.
Phần II: Làm việc với Norton AntiVirus 2004.
Chương 7: Bảo vệ đĩa, file và dữ liệu để tránh bị nhiễm Virus.
Chương 8: Những điều cần làm nếu phát hiện virus.
', N'Book01.jpg', 5, 7, CAST(0x93B70000 AS SmallDateTime), 4, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (21, N'Tin Học Văn Phòng - Microsoft Word 2000 (Tái Bản Lần Thứ Nhất) ', 15600, N'Cuốn', N' ', N'Book01.jpg', 2, 8, CAST(0x931D0000 AS SmallDateTime), 6, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (22, N'Adobe Photoshop 6.0 và ImageReady 3.0 ', 21000, N'Cuốn', N'Cuốn sách Adobe Photoshop 6.0 và ImageReady 3.0 này sẽ giúp bạn tìm hiểu những tính năng tuyệt vời của phiên bản 6.0, nó cũng là con đường ngắn nhất cho những người mới sử dụng Photoshop lần đầu. Với bạn đọc đã sử dụng cuốn sách "Adobe Photoshop 5.5 và ImageReady 2.0" do MK.PUB biên soạn trước đây, cuốn sách này là một cách cập nhật nhanh chóng nhất.
Adobe Photoshop 6.0 và ImageReady 3.0 gồm hai phần chính, đan xen nhau: 

Adobe Photoshop 6.0: trình bày các kỹ thuật xử lý ảnh cao cấp, các tính năng mới, giúp bạn tạo được các ảnh đẹp, rõ nét và mang tính mỹ thuật cao, hỗ trợ đắc lực cho các chương trình dàn trang và tách màu điện tử. Đặc biệt trong phiên bản này, để đáp ứng cho mong mỏi từ lâu của người dùng, các hình thể vector bắt đầu được đưa vào sử dụng trong môi trường Photoshop.

', N'Book01.jpg', 5, 5, CAST(0x91EC0000 AS SmallDateTime), 8, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (23, N'Hướng Dẫn Tự Học Photoshop CS (Photoshop 8.0) ', 25000, N'Cuốn', N' ', N'Book01.jpg', 8, 4, CAST(0x983E0000 AS SmallDateTime), 9, 0)
INSERT [dbo].[SACH] ([Masach], [Tensach], [Dongia], [Donvitinh], [Mota], [Hinhminhhoa], [MaCD], [MaNXB], [Ngaycapnhat], [Soluongban], [Solanxem]) VALUES (24, N'Tin Học Văn Phòng - Microsoft Excel 2000 (Tái Bản Lần Thứ Nhất)  
 
 
', 16800, N'Cuốn', N'Cuốn sách này gồm những nội dung chính sau:
Chương 1: Giới thiệu
Chương 2: Soạn thảo văn bản
Chương 3: Trình bày Font chữ
Chương 4: Trình bày Paragraph
Chương 5: Trình bày trang in
Chương 6: Bảng biểu - Table
Chương 7: Cột chữ - Column
Chương 8: Hình vẽ
Chương 9: Microsoft Equation
Chương 10: Trình bày văn bản nhanh
Chương 11: Bài tập mẫu
Xin trân trọng giới thiệu. 
', N'Book01.jpg', 6, 5, CAST(0x93830000 AS SmallDateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[SACH] OFF

/****** Object:  Table [dbo].[THAMGIA]    Script Date: 10/19/2010 13:14:22 ******/
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (1, 1, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (1, 3, N'Đồng tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (1, 4, N'Hiệu đính')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (1, 10, N'Chủ biên')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (2, 3, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (2, 14, N'Đồng tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (3, 5, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (3, 6, N'Hiệu đính')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (4, 5, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (5, 6, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (5, 12, N'Chủ biên')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (6, 14, N'Sưu tầm và biên soạn')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (7, 8, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (8, 7, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (10, 11, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (11, 6, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (12, 13, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (13, 16, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (14, 7, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (15, 12, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (16, 14, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (17, 14, N'Chủ biên')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (17, 15, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (18, 15, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (19, 5, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (20, 8, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (21, 13, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (22, 10, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (23, 11, N'Tác giả')
INSERT [dbo].[VIETSACH] ([Masach], [MaTG], [Vaitro]) VALUES (24, 2, N'Tác giả')


/****** Object:  Table [dbo].[DONDATHANG]    Script Date: 10/19/2010 13:14:22 ******/
SET IDENTITY_INSERT [dbo].[DONDATHANG] ON
INSERT [dbo].[DONDATHANG] ([SoDH], [MaKH], [NgayDH], [Trigia], [Dagiao], [Ngaygiaohang]) VALUES (1, 1, CAST(0x9D500000 AS SmallDateTime),  CAST(75000.00 AS Decimal(9, 2)), 0, CAST(0x9D500000 AS SmallDateTime))
INSERT [dbo].[DONDATHANG] ([SoDH], [MaKH], [NgayDH], [Trigia], [Dagiao], [Ngaygiaohang]) VALUES (2, 1, CAST(0x9DA30000 AS SmallDateTime),  CAST(80000.00 AS Decimal(9, 2)), 0, CAST(0x9DA30000 AS SmallDateTime))
SET IDENTITY_INSERT [dbo].[DONDATHANG] OFF

/****** Object:  Table [dbo].[CTDATHANG]    Script Date: 10/19/2010 13:14:22 ******/
INSERT [dbo].[CTDATHANG] ([SoDH], [Masach], [Soluong], [Dongia]) VALUES (1, 19, 1, 25000)
INSERT [dbo].[CTDATHANG] ([SoDH], [Masach], [Soluong], [Dongia]) VALUES (1, 23, 2, 25000)
INSERT [dbo].[CTDATHANG] ([SoDH], [Masach], [Soluong], [Dongia]) VALUES (2, 1, 1, 26000)
INSERT [dbo].[CTDATHANG] ([SoDH], [Masach], [Soluong], [Dongia]) VALUES (2, 17, 3, 18000)


