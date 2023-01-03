create database BaiTapLon_TKCSDL_Nhom07
use BaiTapLon_TKCSDL_Nhom07
go

/*Tạo bảng*/
-- Nhà cung cấp
create TABLE NhaCungCap 
(
  MaNhaCungCap nvarchar(255) NOT NULL,
  TenNhaCungCap nvarchar(255) NOT NULL,
  CONSTRAINT pk_NhaCungCap PRIMARY KEY (MaNhaCungCap)
);
-- Chức vụ
CREATE TABLE ChucVu 
(
  MaChucVu nvarchar(255) NOT NULL,
  TenChucVu nvarchar(255) NOT NULL,
  CONSTRAINT pk_ChucVu PRIMARY KEY (MaChucVu)
);
-- Nhân Viên
CREATE TABLE NhanVien 
(
  MaNhanVien nvarchar(255) NOT NULL,
  TenNhanVien nvarchar(255) NOT NULL,
  MaChucVu nvarchar(255) NOT NULL,
  NgaySinh date NOT NULL,
  GioiTinh nvarchar(255) NOT NULL,
  SoDienThoai nvarchar(255) NOT NULL,
  DiaChi nvarchar(255) NOT NULL,

  CONSTRAINT PK_NhanVien_MaNV PRIMARY KEY (MaNhanVien),
  CONSTRAINT FK_NhanVien_MaCV FOREIGN KEY (MaChucVu) REFERENCES ChucVu (MaChucVu)
)
-- Linh kiện
CREATE TABLE LinhKien (
  MaLinhKien nvarchar(255) NOT NULL,
  TenLinhKien nvarchar(255) NOT NULL,
  CONSTRAINT pk_linhkien PRIMARY KEY (MaLinhKien)
)
-- Hãng
CREATE TABLE Hang (
  MaHang nvarchar(255) NOT NULL,
  TenHang nvarchar(255) NOT NULL,
  CONSTRAINT pk_hang PRIMARY KEY (MaHang)
)
-- Sản phẩm
CREATE TABLE SanPham (
  MaSanPham nvarchar(255) NOT NULL,
  TenSanPham nvarchar(255) NOT NULL,
  MaHang nvarchar(255) NOT NULL,
  BaoHanh int, 
  DoiTra int,
  CONSTRAINT pk_sanpham PRIMARY KEY (MaSanPham),
  CONSTRAINT fk_malinhkien_Hang FOREIGN KEY (MaHang)
  REFERENCES Hang (MaHang)
)
-- KhachHang
CREATE TABLE KhachHang (
  MaKhachHang nvarchar(255) NOT NULL,
  TenKhachHang nvarchar(255) NOT NULL,
  NgaySinh datetime NOT NULL,
  GioiTinh nvarchar(255) NOT NULL,
  SoDienThoai nvarchar(255) NOT NULL,
  DiaChi nvarchar(255) NOT NULL,
  CONSTRAINT pk_makhachhang PRIMARY KEY (MaKhachHang)
);
-- ChiTietSanPham
create table ChiTietSanPham
(
	MaChiTietSP nvarchar(255) not null,
	MaSanPham nvarchar(255) not null,
	MauSac nvarchar(255),
	KichThuoc nvarchar(255),
	ChatLieu nvarchar(255),
	DonGiaNhap money,
	DonGiaBan money,
	SoLuong int,
	Constraint pk_chitietsanpham primary key (MaChiTietSP),
	constraint fk_chitietsanpham_masp foreign key (MaSanPham) references SanPham(MaSanPham)
)
-- HoaDonNhap
CREATE TABLE HoaDonNhap (
  MaHDN nvarchar(255) NOT NULL,
  MaNhaCungCap nvarchar(255) NOT NULL,
  MaNhanVien nvarchar(255) NOT NULL,
  NgayNhap datetime NOT NULL,
  TongTienHDN money,
  CONSTRAINT pk_hoadonnhap PRIMARY KEY (MaHDN),
  CONSTRAINT fk_hoadonnhap_manhanvien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien (MaNhanVien),
  CONSTRAINT fk_hoadonnhap_manhacungcap FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap (MaNhaCungCap),
);
-- Voucher
create table Voucher
(
	MaVoucher nvarchar(255) not null,
	TenVoucher nvarchar(255) not null,
	PhanTram int not null,
	SoLuong int not null,
	NgayBatDau datetime,
	NgayKetThuc datetime
	constraint pk_voucher primary key (mavoucher),
)

-- HoaDonBan
create TABLE HoaDonBan 
(
  MaHDB nvarchar(255) NOT NULL,
  MaNhanVien nvarchar(255) NOT NULL,
  MaKhachHang nvarchar(255) NOT NULL,
  MaVoucher nvarchar(255) not null,
  NgayBan datetime NOT NULL,
  TongTienHDB money,

  CONSTRAINT pk_hoadonban PRIMARY KEY (MaHDB),
  CONSTRAINT fk_hoadonban_manhanvien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien (MaNhanVien),
  CONSTRAINT fk_hoadonban_makhachang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang (MaKhachHang),
  CONSTRAINT fk_hoadonban_mavoucher FOREIGN KEY (MaVoucher) REFERENCES Voucher (MaVoucher),
);
-- PhieuDoiTra
create table PhieuDoiTra
(
	MaPhieuDoiTra nvarchar(255) not null,
	MaHDB nvarchar(255) not null,
	MaChiTietSP nvarchar(255) not null,
	NgayDoiTra datetime,
	constraint pk_phieudoitra primary key (MaPhieuDoiTra),
	constraint fk_phieudoitra_mahdb foreign key (MaHDB) references HoaDonBan (MaHDB)
)
-- PhieuBaoHanh
create table PhieuBaoHanh
(
	MaPhieuBaohanh nvarchar(255) not null,
	MaHDB nvarchar(255) not null,
	MaChiTietSP nvarchar(255) not null,
	NgayBaoHanh datetime,
	constraint pk_phieubaohanh primary key (MaPhieuBaoHanh),
	constraint fk_phieubaohanh_mahdb foreign key (MaHDB) references HoaDonBan (MaHDB)
)
-- ChiTietHDN
create TABLE ChiTietHDN 
(
  MaHDN nvarchar(255) NOT NULL,
  MaChiTietSP nvarchar(255) NOT NULL,
  SoLuongNhap int NOT NULL,
  ThanhTienHDN money,
  CONSTRAINT pk_mahdn PRIMARY KEY (MaHDN, MaChiTietSP),
  CONSTRAINT fk_mahdn_hdn FOREIGN KEY (MaHDN)
  REFERENCES HoaDonNhap (MaHDN),
  CONSTRAINT fkh_masanpam_sanpham FOREIGN KEY (MaChiTietSP)
  REFERENCES ChiTietSanPham (MaChiTietSP)
)
-- ChiTietHDB
create TABLE ChiTietHDB 
(
  MaHDB nvarchar(255) NOT NULL,
  MaChiTietSP nvarchar(255) NOT NULL,
  SoLuongBan int NOT NULL,
  NgayKetThucDoiTra datetime,
  NgayKetThucBaoHanh datetime,
  ThanhTienHDB money,
  CONSTRAINT pk_chitiethdb PRIMARY KEY (MaHDB, MaChiTietSP),
  CONSTRAINT fk_chitiethdb_mahdb FOREIGN KEY (MaHDB) REFERENCES HoaDonBan (MaHDB),
  CONSTRAINT fk_chitiethdb_masanpham FOREIGN KEY (MaChiTietSP) REFERENCES ChiTietSanPham (MaChiTietSP),
)
-- Trung gian giữa Chi tiết sản phẩm và linh kiện
create TABLE SanPham_LinhKien 
(
  MaChiTietSP nvarchar(255) NOT NULL,
  MaLinhKien nvarchar(255) NOT NULL
  CONSTRAINT pk_splk PRIMARY KEY (MaChiTietSP, MaLinhKien),
  CONSTRAINT fk_sanpham_linhkien_masp FOREIGN KEY (MaChiTietSP) REFERENCES ChiTietSanPham (MaChiTietSP),
  CONSTRAINT fk_sanpham_linhkien_malk FOREIGN KEY (MaLinhKien) REFERENCES LinhKien (MaLinhKien)
)


											/*CÂU LỆNH*/


---------------------------------------------------- TRIGGER ----------------------------------------------------

-- Câu 1: Tạo Trigger cập nhật tự động cho TongTienHDB của HoaDonBan
-- Trigger ThanhTienHDB của ChiTietHDB
create trigger ThanhTienHDB on dbo.ChiTietHDB
for insert, update
as
begin
		-- Cập nhật tự động Thành Tiền HĐB
		declare @mahdb_in nvarchar(30), @machitietsp_in nvarchar(30), @dongiaban money, @soluongban int
		select @mahdb_in = MaHDB, @machitietsp_in = MaChiTietSP, @soluongban = SoLuongBan from inserted
		select @dongiaban = DonGiaBan from ChiTietSanPham where MaChiTietSP = @machitietsp_in

		Update ChiTietHDB set ThanhTienHDB = @soluongban * @dongiaban
		where MaChiTietSP = @machitietsp_in and MaHDB = @mahdb_in
		
		-- Trigger NgayKetThucDoiTra và NgayKetThucBaoHanh
		declare @mahdb_ngay nvarchar(30), @machitietsp_ngay nvarchar(30)
		select @mahdb_ngay = MaHDB, @machitietsp_ngay = MaChiTietSP from inserted

		declare @ngayban datetime
		select @ngayban = NgayBan from HoaDonBan where MaHDB = @mahdb_ngay
		declare @masanpham nvarchar(30)
		select @masanpham = MaSanPham from ChiTietSanPham where MaChiTietSP = @machitietsp_ngay
		
		declare @baohanh int, @doitra int
		select @baohanh = BaoHanh, @doitra = DoiTra from SanPham where MaSanPham = @masanpham

		-- Tính
		Update ChiTietHDB set NgayKetThucDoiTra = Dateadd(day, @doitra, @ngayban)
		where MaHDB = @mahdb_ngay and MaChiTietSP = @machitietsp_ngay
		Update ChiTietHDB set NgayKetThucBaoHanh = Dateadd(month, @baohanh, @ngayban)
		where MaHDB = @mahdb_ngay and MaChiTietSP = @machitietsp_ngay
end



-- Trigger TongTienHDB của HoaDonBan
create trigger TongTienHDB on dbo.ChiTietHDB
for insert, update, delete
as
begin
	declare @mahdbthem nvarchar(30), @thanhtienthem money, @mahdbxoa nvarchar(30), @thanhtienxoa money
	select @mahdbthem = MaHDB, @thanhtienthem = ThanhTienHDB from inserted
	select @mahdbxoa = MahDB, @thanhtienxoa = ThanhTienHDB from deleted

	Update HoaDonBan set TongTienHDB = isnull(TongTienHDB, 0) + isnull(@thanhtienthem, 0)
	where MaHDB = @mahdbthem
	Update HoaDonBan set TongTienHDB = isnull(TongTienHDB, 0) - isnull(@thanhtienxoa, 0)
	where MaHDB = @mahdbxoa
end

-- Câu 2: Tạo Trigger cập nhật tự động cho TongTienHDN của HoaDonNhap
-- Trigger ThanhTienHDN của ChiTietHDN
create trigger ThanhTienHDN on dbo.ChiTietHDN
for insert, update
as
begin
	declare @mahdn nvarchar(30), @soluongthem int, @masanpham nvarchar(30), @dongia money
	select @mahdn = MaHDN, @soluongthem = SoLuongNhap, @masanpham = MaChiTietSP from inserted
	select @dongia = DonGiaNhap from ChiTietSanPham where MaChiTietSP = @masanpham
	Update ChiTietHDN set ThanhTienHDN = @soluongthem * @dongia 
	where MaHDN = @mahdn and MaChiTietSP = @masanpham
end
-- Trigger TongTienHDN của HoaDonNhap
create trigger TongTienHDN on dbo.ChiTietHDN
for insert, update, delete
as
begin
	declare @mahdnthem nvarchar(30), @thanhtienthem money, @mahdnxoa nvarchar(30), @thanhtienxoa money
	select @mahdnthem = MaHDN, @thanhtienthem = ThanhTienHDN from inserted
	select @mahdnxoa = MaHDN, @thanhtienxoa = ThanhTienHDN from deleted

	Update HoaDonNhap set TongTienHDN = isnull(TongTienHDN, 0) + isnull(@thanhtienthem, 0)
	where MaHDN = @mahdnthem
	Update HoaDonNhap set TongTienHDN = isnull(TongTienHDN, 0) - isnull(@thanhtienxoa, 0)
	where MaHDN = @mahdnxoa
end


-- Câu 3: Tạo trigger cập nhật số lượng máy tính trong bảng sản phẩm mỗi khi nhập thêm hoặc bán ra
-- ChiTietHDN
create trigger SoLuongMayTinh_Nhap on dbo.ChiTietHDN
for insert, update, delete as
begin
	declare @maspthem nvarchar(30), @soluongthem int
	declare @maspxoa nvarchar(30), @soluongxoa int
	select @maspthem = MaChiTietSP, @soluongthem = SoLuongNhap from inserted
	select @maspxoa = MaChiTietSP, @soluongxoa = SoLuongNhap from deleted
	Update ChiTietSanPham set SoLuong = isnull(SoLuong, 0) + isnull(@soluongthem, 0)
	where MaChiTietSP = @maspthem
	Update ChiTietSanPham set SoLuong = isnull(SoLuong, 0) - isnull(@soluongxoa, 0)
	where MaChiTietSP = @maspxoa	
end
-- ChiTietHDB
create trigger SoLuongMayTinh_Ban on dbo.ChiTietHDB
for insert, update, delete as
begin
	declare @maspthem nvarchar(30), @soluongthem int
	declare @maspxoa nvarchar(30), @soluongxoa int
	select @maspthem = MaChiTietSP, @soluongthem = SoLuongBan from inserted
	select @maspxoa = MaChiTietSP, @soluongxoa = SoLuongBan from deleted
	Update ChiTietSanPham set SoLuong = isnull(SoLuong, 0) - isnull(@soluongthem, 0)
	where MaChiTietSP = @maspthem
	Update ChiTietSanPham set SoLuong = isnull(SoLuong, 0) + isnull(@soluongxoa, 0)
	where MaChiTietSP = @maspxoa
end

-- Câu 4: Thêm trường Số Máy Tính cho bảng Nhà Cung Cấp, cập nhật tự động số máy tính của nhà cung cấp 
-- đã cung cấp cho cửa hàng

alter table NhaCungCap
add SoMayTinh int

create trigger SoLuongNCC on dbo.ChiTietHDN
for insert, update, delete as
begin
	declare @soluongnhap_in int, @mancc_in nvarchar(30)
	declare @soluongnhap_de int, @mancc_de nvarchar(30)
	select @soluongnhap_in = SoLuongNhap, @mancc_in = MaNhaCungCap
	from inserted inner join HoaDonNhap on inserted.MaHDN = HoaDonNhap.MaHDN
	select @soluongnhap_de = SoLuongNhap, @mancc_de = MaNhaCungCap
	from deleted inner join HoaDonNhap on deleted.MaHDN = HoaDonNhap.MaHDN
	Update NhaCungCap set SoMayTinh = isnull(SoMayTinh, 0) + isnull(@soluongnhap_in, 0)
	where MaNhaCungCap = @mancc_in
	Update NhaCungCap set SoMayTinh = isnull(SoMayTinh, 0) - isnull(@soluongnhap_de, 0)
	where MaNhaCungCap = @mancc_de
end

-- Câu 5: Trigger tự động xóa các ChiTietHDB khi xóa HoaDonBan. Xóa ChiTietHDN khi xóa HoaDonNhap
-- HoaDonBan
create trigger XoaHoaDonBan on dbo.HoaDonBan
instead of
delete as
begin
	declare @sohdb nvarchar(10)
	select @sohdb = MaHDB from deleted
	Delete from ChiTietHDB where MaHDB = @sohdb
	Delete from HoaDonBan where MaHDB = @sohdb
end
-- HoaDonNhap
create trigger XoaHoaDonNhap on dbo.HoaDonNhap
instead of
delete as
begin
	declare @sohdn nvarchar(10)
	select @sohdn = MaHDN from deleted
	Delete from ChiTietHDN where MaHDN = @sohdn
	Delete from HoaDonNhap where MaHDN = @sohdn
end

-- Câu 6: Thêm trường SoLuongHDB vào bảng NhanVien. Cập nhật SoLuongHDB của nhân viên theo số lượng HĐB mà nhân viên đã lập (thêm, sửa, xóa)

alter table NhanVien
add SoLuongHDB int

create trigger SoLuongHDB on dbo.HoaDonBan
for insert, update, delete as
begin
	declare @manv_in nvarchar(30), @manv_de nvarchar(30)
	select @manv_in = MaNhanVien from inserted
	select @manv_de = MaNhanVien from deleted
	Update NhanVien set SoLuongHDB = isnull(SoLuongHDB,0) + 1
	where MaNhanVien = @manv_in
	Update NhanVien set SoLuongHDB = isnull(SoLuongHDB,0) - 1
	where MaNhanVien = @manv_de
end

-- Câu 7: 
-- Thêm trường SoLuongHD vào bảng KhachHang, cập nhật tự động trường này mỗi khi thêm, sửa, xóa HoaDonBan
alter table KhachHang
add SoLuongHD int

create Trigger SoLuongHD_KH on dbo.HoaDonBan
for insert, update, delete as
begin
	declare @makh_in nvarchar(30), @makh_de nvarchar(30)
	select @makh_in = MaKhachHang from inserted
	select @makh_de = MaKhachHang from deleted
	Update KhachHang set SoLuongHD = isnull(SoLuongHD, 0) + 1
	where MaKhachHang = @makh_in
	Update KhachHang set SoLuongHD = isnull(SoLuongHD, 0) - 1
	where MaKhachHang = @makh_de
end

-- Câu 8:
-- Tự động cập nhật ngày kết thúc đổi trả
-- Tự động cập nhật ngày kết thúc bảo hành

--drop Trigger NgayKetThuc on dbo.ChiTietHDB
--for insert, update as
--begin
--	-- Trigger NgayKetThucDoiTra và NgayKetThucBaoHanh
--		declare @mahdb_ngay nvarchar(30), @machitietsp_ngay nvarchar(30)
--		select @mahdb_ngay = MaHDB, @machitietsp_ngay = MaChiTietSP from inserted

--		declare @ngayban datetime
--		select @ngayban = NgayBan from HoaDonBan where MaHDB = @mahdb_ngay
--		declare @masanpham nvarchar(30)
--		select @masanpham = MaSanPham from ChiTietSanPham where MaChiTietSP = @machitietsp_ngay
		
--		declare @baohanh int, @doitra int
--		select @baohanh = BaoHanh, @doitra = DoiTra from SanPham where MaSanPham = @masanpham

--		-- Tính
--		Update ChiTietHDB set NgayKetThucDoiTra = Dateadd(day, @doitra, @ngayban)
--		where MaHDB = @mahdb_ngay and MaChiTietSP = @machitietsp_ngay
--		Update ChiTietHDB set NgayKetThucBaoHanh = Dateadd(month, @baohanh, @ngayban)
--		where MaHDB = @mahdb_ngay and MaChiTietSP = @machitietsp_ngay
--end

--------------------------------------------------------- INSERT -----------------------------------------------------------------------------------
-- Nhà cung cấp
INSERT INTO NhaCungCap([MaNhaCungCap], [TenNhaCungCap])
	VALUES ('NCC01', N'Công ty TNHH Văn Toàn')
INSERT INTO NhaCungCap([MaNhaCungCap], [TenNhaCungCap])
	VALUES ('NCC02', N'Công ty TNHH Khánh Vân')
INSERT INTO NhaCungCap([MaNhaCungCap], [TenNhaCungCap])
	VALUES ('NCC03', N'Công ty TNHH Linh Anh')
INSERT INTO NhaCungCap([MaNhaCungCap], [TenNhaCungCap])
	VALUES ('NCC04', N'Công ty CP Tiến Thịnh')
INSERT INTO NhaCungCap([MaNhaCungCap], [TenNhaCungCap])
	VALUES ('NCC05', N'Công ty CP Thanh Xuân')
-- Chức vụ
INSERT INTO ChucVu([MaChucVu],[TenChucVu]) VALUES (N'CV01', N'Quản Lý')
INSERT INTO ChucVu([MaChucVu],[TenChucVu]) VALUES (N'CV02', N'Nhân Viên')
-- Nhân Viên
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV01', N'Trung Anh', N'CV02',N'2002-05-10', N'Nam', N'0963282831', N'Hà Nội')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV02', N'Nguyễn Hoàng', N'CV01',N'1993-04-21', N'Nam', N'0937228362', N'Hà Nam')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV03', N'Đỗ Quỳnh', N'CV02',N'2000-02-19', N'Nữ', N'0936272354', N'Hà Nội')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV04', N'Thành Đạt', N'CV01',N'1998-06-14', N'Nam', N'0984626425', N'Nghệ An')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV05', N'Nguyễn Ngọc', N'CV02',N'2002-05-10', N'Nữ', N'0933027376', N'Quảng Ninh')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV06', N'Lê Trung', N'CV02',N'1995-10-21', N'Nam', N'0936747264', N'Đà Nẵng')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV07', N'Văn Bảo', N'CV02',N'1999-11-01', N'Nam', N'0937743728', N'Hải Phòng')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV08', N'Trần Nam', N'CV02',N'1999-08-20', N'Nam', N'0936276574', N'Hải Phòng')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV09', N'Ngọc Anh', N'CV01',N'1988-02-22', N'Nữ', N'0938836279', N'Hà Nam')
INSERT INTO NhanVien([MaNhanVien], [TenNhanVien], [MaChucVu], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'NV10', N'Trung Nam', N'CV02',N'2003-01-01', N'Nam', N'0982323699', N'Nghệ An')
-- Linh kiện
INSERT dbo.LinhKien
  VALUES ('LK01', N'CPU CORE I3')
INSERT dbo.LinhKien
  VALUES ('LK02', N'CPU CORE I5')
INSERT dbo.LinhKien
  VALUES ('LK03', N'CPU CORE I7')
INSERT dbo.LinhKien
  VALUES ('LK04', N'CPU CORE I9')
INSERT dbo.LinhKien
  VALUES ('LK05', N'CPU AMD RYZEN5')
INSERT dbo.LinhKien
  VALUES ('LK06', N'CPU AMD RYZEN7')
INSERT dbo.LinhKien
  VALUES ('LK07', N'Ram DDR 4G')
INSERT dbo.LinhKien
  VALUES ('LK08', N'Ram DDR 8G')
INSERT dbo.LinhKien
  VALUES ('LK09', N'Ram DDR 16G')
INSERT dbo.LinhKien
  VALUES ('LK10', N'Ram DDR 32G')
INSERT dbo.LinhKien
  VALUES ('LK11', N'Ổ Cứng SSD')
INSERT dbo.LinhKien
  VALUES ('LK12', N'Ổ Cứng HDD')
INSERT dbo.LinhKien
  VALUES ('LK13', N'Bàn Phím')
INSERT dbo.LinhKien
  VALUES ('LK14', N'Chuột')
INSERT dbo.LinhKien
  VALUES ('LK15', N'VGA')
INSERT dbo.LinhKien
  VALUES ('LK16', N'Màn hình HD')
INSERT dbo.LinhKien
  VALUES ('LK17', N'Màn hình FullHD')
INSERT dbo.LinhKien
  VALUES ('LK18', N'Sạc')
INSERT dbo.LinhKien
  VALUES ('LK19', N'Tai Nghe')
INSERT dbo.LinhKien
  VALUES ('LK20', N'Chíp M1')
INSERT dbo.LinhKien
  VALUES ('LK21', N'Chíp M2')
-- Hãng
INSERT dbo.Hang
  VALUES ('H01', N'MacBook')
INSERT dbo.Hang
  VALUES ('H02', N'Dell')
INSERT dbo.Hang
  VALUES ('H03', N'HP')
INSERT dbo.Hang
  VALUES ('H04', N'Asus')
INSERT dbo.Hang
  VALUES ('H05', N'Lenovo')
INSERT dbo.Hang
  VALUES ('H06', N'Acer')
INSERT dbo.Hang
  VALUES ('H07', N'MSI')
-- Sản phẩm
INSERT SanPham
VALUES('SP01', N'Bravo 15', 'H07', 6, 7)
INSERT SanPham
VALUES('SP02', N'Lenovo IdeaPad', 'H05', 12, 7)
INSERT SanPham
VALUES('SP03', N'MacBook Air M1', 'H01', 24, 7)
INSERT SanPham
VALUES('SP04', N'Acer TravelMate', 'H06', 6, 7)
INSERT SanPham
VALUES('SP05', N'Dell Gaming G15', 'H02', 12, 7)
INSERT SanPham
VALUES('SP06', N'HP 340s G7', 'H03', 12, 7)
INSERT SanPham
VALUES('SP07', N'Asus VivoBook S14', 'H04', 6, 7)
INSERT SanPham
VALUES('SP08', N'Dell XPS 9310', 'H02', 24, 7)
INSERT SanPham
VALUES('SP09', N'MSI Modern 14 B11MO', 'H07', 12, 7)
INSERT SanPham
VALUES('SP10', N'Asus Zenbook 14 Q409 ZA', 'H04', 12, 7)
-- KhachHang
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH01', N'Nguyễn Sơn', N'1987-07-17', N'Nam', N'0936728321', N'Hà Nội')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH02', N'Nguyễn Nhung', N'1999-04-24', N'Nữ', N'0261732826', N'Hà Nam')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH03', N'Trần Hùng', N'1994-03-21', N'Nam', N'0842862363', N'Hà Tĩnh')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH04', N'Mai Anh', N'2000-02-10', N'Nữ', N'0383472744', N'Quảng Nam')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH05', N'Tùng Anh', N'1997-03-13', N'Nam', N'0927237485', N'Lào Cai')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH06', N'Trung Sơn', N'1998-02-01', N'Nam', N'0372832642', N'Hải Phòng')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH07', N'Mai Tiến', N'1985-08-26', N'Nam', N'0926328584', N'Lào Cai')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH08', N'Ngọc Ánh', N'1994-02-15', N'Nữ', N'0826322748', N'Hải Phòng')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH09', N'Bảo Châu', N'1999-03-19', N'Nữ', N'0983428943', N'Đà Nẵng')
INSERT INTO KhachHang([MaKhachHang], [TenKhachHang], [NgaySinh], [GioiTinh], [SoDienThoai], [DiaChi]) 
	VALUES (N'KH10', N'Văn Tâm', N'1992-06-27', N'Nam', N'0834792948', N'Quảng Nam')
-- ChiTietSanPham
INSERT ChiTietSanPham
VALUES('CTSP01', N'SP01', N'Đen', '15.6 inh', N'Nhựa', 15000000, 22000000, 0)
INSERT ChiTietSanPham
VALUES('CTSP02', N'SP01', N'Trắng', '14 inh', N'Nhôm', 10000000, 15000000, 0)
INSERT ChiTietSanPham
VALUES('CTSP03', N'SP02', N'Đỏ-Đen', '14.6 inh', N'CacBon', 12000000, 17390000, 0)
INSERT ChiTietSanPham
VALUES('CTSP04', N'SP02', N'Trăng-Đen', '16.6 inh', N'CacBon', 15000000, 20390000, 0)
INSERT ChiTietSanPham
VALUES('CTSP05', N'SP03', N'Vàng', '15.6 inh', N'Nhôm', 19000000, 27990000, 0)
INSERT ChiTietSanPham
VALUES('CTSP06', N'SP03', N'Đen', '14.6 inh', N'Nhôm', 16000000, 24990000, 0)
INSERT ChiTietSanPham
VALUES('CTSP07', N'SP04', N'Đen', '15.6 inh', N'CacBon', 9000000, 13990000, 0)
INSERT ChiTietSanPham
VALUES('CTSP08', N'SP05', N'Trắng', '15.6 inh', N'CacBon', 18000000, 30190000, 0)
INSERT ChiTietSanPham
VALUES('CTSP09', N'SP06', N'Trắng', '15.6 inh', N'CacBon', 5000000, 9000000, 0)
INSERT ChiTietSanPham
VALUES('CTSP10', N'SP07', N'Đen', '15.6 inh', N'Nhựa', 10000000, 14990000, 0)
INSERT ChiTietSanPham
VALUES('CTSP11', N'SP08', N'Đen', '17.2 inh', N'Nhựa', 22000000, 28990000, 0)
INSERT ChiTietSanPham
VALUES('CTSP12', N'SP09', N'Đen', '13.2 inh', N'Nhựa', 11000000, 15690000, 0)
INSERT ChiTietSanPham
VALUES('CTSP13', N'SP10', N'Đen', '15.6 inh', N'CacBon', 12000000, 17690000, 0)
-- HoaDonNhap
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN01', 'NCC02', 'NV03', '2022-08-19', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN02', 'NCC04', 'NV01', '2022-06-20', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN03', 'NCC01', 'NV03', '2022-07-11', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN04', 'NCC02', 'NV02', '2021-01-19', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN05', 'NCC02', 'NV03', '2022-11-19', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN06', 'NCC03', 'NV04', '2022-11-12', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN07', 'NCC05', 'NV05', '2020-12-11', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN08', 'NCC02', 'NV07', '2022-08-19', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN09', 'NCC02', 'NV03', '2022-02-19', '')
INSERT INTO HoaDonNhap([MaHDN], [MaNhaCungCap], [MaNhanVien], [NgayNhap], [TongTienHDN])
	VALUES ('HDN10', 'NCC01', 'NV09', '2021-04-30', '')
-- Voucher
INSERT INTO Voucher([MaVoucher], [TenVoucher], [PhanTram], [SoLuong]) VALUES (N'VC01', N'Voucher giảm 50%', 50, 20)
INSERT INTO Voucher([MaVoucher], [TenVoucher], [PhanTram], [SoLuong]) VALUES (N'VC02', N'Voucher giảm 25%', 25, 50)
INSERT INTO Voucher([MaVoucher], [TenVoucher], [PhanTram], [SoLuong]) VALUES (N'VC03', N'Voucher giảm 10%', 10, 100)
INSERT INTO Voucher([MaVoucher], [TenVoucher], [PhanTram], [SoLuong]) VALUES (N'VC04', N'Voucher giảm 60%', 60, 15)
INSERT INTO Voucher([MaVoucher], [TenVoucher], [PhanTram], [SoLuong]) VALUES (N'VC05', N'Voucher giảm 80%', 80, 5)
-- HoaDonBan
INSERT INTO HoaDonBan
  VALUES ('HDB01', 'NV01', 'KH01', 'VC01', '2022-10-10', '')
INSERT INTO HoaDonBan
  VALUES ('HDB02', 'NV02', 'KH02', 'VC02', '2022-9-10', '')
INSERT INTO HoaDonBan
  VALUES ('HDB03', 'NV03', 'KH03', 'VC03', '2022-5-10', '')
INSERT INTO HoaDonBan
  VALUES ('HDB04', 'NV04', 'KH04', 'VC02', '2022-10-10', '')
INSERT INTO HoaDonBan
  VALUES ('HDB05', 'NV05', 'KH05', 'VC05', '2022-11-10', '')
INSERT INTO HoaDonBan
  VALUES ('HDB06', 'NV06', 'KH06', 'VC04', '2022-1-8', '')
INSERT INTO HoaDonBan
  VALUES ('HDB07', 'NV07', 'KH07', 'VC01', '2022-12-12', '')
INSERT INTO HoaDonBan
  VALUES ('HDB08', 'NV08', 'KH01', 'VC01', '2022-10-3', '')
INSERT INTO HoaDonBan
  VALUES ('HDB09', 'NV09', 'KH02', 'VC03', '2022-3-10', '')
INSERT INTO HoaDonBan
  VALUES ('HDB10', 'NV10', 'KH03', 'VC02', '2022-7-11', '')
-- PhieuDoiTra
INSERT PhieuDoiTra
Values ('PDT01', 'HDB05', 'CTSP05', '2022-11-13')
INSERT PhieuDoiTra
Values ('PDT02', 'HDB02', 'CTSP01', '2022-9-12')
INSERT PhieuDoiTra
Values ('PDT03', 'HDB02', 'CTSP03', '2022-9-15')
INSERT PhieuDoiTra
Values ('PDT04', 'HDB07', 'CTSP02', '2022-12-17')
INSERT PhieuDoiTra
Values ('PDT05', 'HDB04', 'CTSP03', '2022-10-11')
INSERT PhieuDoiTra
Values ('PDT06', 'HDB06', 'CTSP01', '2022-1-10')
INSERT PhieuDoiTra
Values ('PDT07', 'HDB01', 'CTSP05', '2022-10-16')
INSERT PhieuDoiTra
Values ('PDT08', 'HDB02', 'CTSP03', '2022-9-13')
INSERT PhieuDoiTra
Values ('PDT09', 'HDB08', 'CTSP09', '2022-10-7')
INSERT PhieuDoiTra
Values ('PDT10', 'HDB05', 'CTSP06', '2022-11-12')
-- PhieuBaoHanh
INSERT PhieuBaoHanh
Values ('PBH01', 'HDB01', 'CTSP02', '2022-12-21')
INSERT PhieuBaoHanh
Values ('PBH02', 'HDB01', 'CTSP01', '2022-11-11')
INSERT PhieuBaoHanh
Values ('PBH03', 'HDB02', 'CTSP03', '2022-12-21')
INSERT PhieuBaoHanh
Values ('PBH04', 'HDB03', 'CTSP01', '2022-09-05')
INSERT PhieuBaoHanh
Values ('PBH05', 'HDB03', 'CTSP04', '2022-12-21')
INSERT PhieuBaoHanh
Values ('PBH06', 'HDB02', 'CTSP09', '2022-11-25')
INSERT PhieuBaoHanh
Values ('PBH07', 'HDB05', 'CTSP05', '2023-05-10')
INSERT PhieuBaoHanh
Values ('PBH08', 'HDB06', 'CTSP03', '2022-03-17')
INSERT PhieuBaoHanh
Values ('PBH09', 'HDB09', 'CTSP07', '2022-10-10')
INSERT PhieuBaoHanh
Values ('PBH10', 'HDB10', 'CTSP02', '2022-09-28')
-- ChiTietHDN
insert into ChiTietHDN
values('HDN01','CTSP01',400,null)
insert into ChiTietHDN
values('HDN01','CTSP02',550,null)
insert into ChiTietHDN
values('HDN01','CTSP03',420,null)

insert into ChiTietHDN
values('HDN02','CTSP07',760,null)
insert into ChiTietHDN
values('HDN02','CTSP13',508,null)
insert into ChiTietHDN
values('HDN02','CTSP03',806,null)

insert into ChiTietHDN
values('HDN03','CTSP04',400,null)
insert into ChiTietHDN
values('HDN03','CTSP09',505,null)
insert into ChiTietHDN
values('HDN03','CTSP11',700,null)

insert into ChiTietHDN
values('HDN04','CTSP12',409,null)
insert into ChiTietHDN
values('HDN04','CTSP06',501,null)
insert into ChiTietHDN
values('HDN04','CTSP09',100,null)

insert into ChiTietHDN
values('HDN05','CTSP11',907,null)
insert into ChiTietHDN
values('HDN05','CTSP03',305,null)
insert into ChiTietHDN
values('HDN05','CTSP02',909,null)

insert into ChiTietHDN
values('HDN06','CTSP04',607,null)
insert into ChiTietHDN
values('HDN06','CTSP05',304,null)
insert into ChiTietHDN
values('HDN06','CTSP06',705,null)

insert into ChiTietHDN
values('HDN07','CTSP07',806,null)
insert into ChiTietHDN
values('HDN07','CTSP08',405,null)
insert into ChiTietHDN
values('HDN07','CTSP09',907,null)

insert into ChiTietHDN
values('HDN08','CTSP10',700,null)
insert into ChiTietHDN
values('HDN08','CTSP03',405,null)
insert into ChiTietHDN
values('HDN08','CTSP09',804,null)

insert into ChiTietHDN
values('HDN09','CTSP10',400,null)
insert into ChiTietHDN
values('HDN09','CTSP07',505,null)
insert into ChiTietHDN
values('HDN09','CTSP08',1103,null)

insert into ChiTietHDN
values('HDN10','CTSP06',208,null)
insert into ChiTietHDN
values('HDN10','CTSP03',902,null)
insert into ChiTietHDN
values('HDN10','CTSP02',206,null)


-- ChiTietHDB
-- HDB01
INSERT INTO ChiTietHDB
  VALUES ('HDB01', 'CTSP01', 42, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB01', 'CTSP02', 15, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB01', 'CTSP05', 5, NULL, NULL, NULL)
-- HDB02
INSERT INTO ChiTietHDB
  VALUES ('HDB02', 'CTSP01', 47, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB02', 'CTSP03', 80, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB02', 'CTSP09', 20, NULL, NULL, NULL)
-- HDB03
INSERT INTO ChiTietHDB
  VALUES ('HDB03', 'CTSP04', 40, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB03', 'CTSP01', 51, NULL, NULL, NULL)
-- HDB04
INSERT INTO ChiTietHDB
  VALUES ('HDB04', 'CTSP07', 22, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB04', 'CTSP02', 12, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB04', 'CTSP03', 77, NULL, NULL, NULL)
-- HDB05
INSERT INTO ChiTietHDB
  VALUES ('HDB05', 'CTSP05', 32, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB05', 'CTSP06', 21, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB05', 'CTSP08', 44, NULL, NULL, NULL)
-- HDB06
INSERT INTO ChiTietHDB
  VALUES ('HDB06', 'CTSP01', 11, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB06', 'CTSP02', 23, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB06', 'CTSP03', 18, NULL, NULL, NULL)
-- HDB07
INSERT INTO ChiTietHDB
  VALUES ('HDB07', 'CTSP07', 5, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB07', 'CTSP02', 22, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB07', 'CTSP08', 40, NULL, NULL, NULL)
-- HDB08
INSERT INTO ChiTietHDB
  VALUES ('HDB08', 'CTSP01', 9, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB08', 'CTSP09', 12, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB08', 'CTSP04', 13, NULL, NULL, NULL)
-- HDB09
INSERT INTO ChiTietHDB
  VALUES ('HDB09', 'CTSP05', 33, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB09', 'CTSP06', 52, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB09', 'CTSP07', 15, NULL, NULL, NULL)
-- HDB10
INSERT INTO ChiTietHDB
  VALUES ('HDB10', 'CTSP02', 27, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB10', 'CTSP03', 38, NULL, NULL, NULL)
INSERT INTO ChiTietHDB
  VALUES ('HDB10', 'CTSP06', 11, NULL, NULL, NULL)

-- Trung gian giữa Chi tiết sản phẩm và linh kiện
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK07')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK16')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK08')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP01', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK05')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK16')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK08')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP02', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK01')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK07')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP03', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK02')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK07')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP04', 'LK11')


INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK20')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK09')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP05', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK21')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK09')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP06', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK01')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK16')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK07')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP07', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK03')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK10')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP08', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK01')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK07')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP09', 'LK11')


INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK06')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK09')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP10', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK03')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK09')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP11', 'LK11')


INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK02')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK08')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP12', 'LK11')

INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK02')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK13')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK14')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK15')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK17')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK08')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK18')
INSERT dbo.SanPham_LinhKien
  VALUES ('CTSP13', 'LK11')





-- Nhà cung cấp
select * from NhaCungCap
-- Chức vụ
select * from ChucVu
-- Nhân Viên
select * from NhanVien
-- Linh kiện
select * from LinhKien
-- Hãng
select * from Hang
-- Sản phẩm
select * from SanPham
-- KhachHang
select * from KhachHang
-- ChiTietSanPham
select * from ChiTietSanPham
-- HoaDonNhap
select * from HoaDonNhap
-- Voucher
select * from Voucher
-- HoaDonBan
select * from HoaDonBan
-- PhieuDoiTra
select * from PhieuDoiTra
-- PhieuBaoHanh
select * from PhieuBaoHanh
-- ChiTietHDN
select * from ChiTietHDN
-- ChiTietHDB
select * from ChiTietHDB
-- Trung gian giữa Chi tiết sản phẩm và linh kiện
select * from SanPham_LinhKien








------------------------------------------------- VIEW ----------------------------------------------------------
--1. Tạo view thống kê 5 máy tính bán chạy nhất năm 2022
create view cau1View as
select top 5 with ties SanPham.MaSanPham, TenSanPham,  sum(SoLuongBan) as 'SoLuongBanDuoc'
from SanPham,ChiTietHDB,HoaDonBan,ChiTietSanPham
where SanPham.MaSanPham = ChiTietSanPham.MaSanPham and ChiTietHDB.MaHDB = HoaDonBan.MaHDB 
and ChiTietSanPham.MaChiTietSP = ChiTietHDB.MaChiTietSP and year(NgayBan) = 2022
group by SanPham.MaSanPham, TenSanPham
order by SoLuongBanDuoc desc

select * from dbo.cau1View
--2. Tạo view đưa ra hóa đơn mua tất cả các máy của hãng Acer
create view cau2View as
select HoaDonBan.MaHDB
from HoaDonBan,SanPham,Hang,ChiTietHDB,ChiTietSanPham
where SanPham.MaSanPham = ChiTietSanPham.MaSanPham and ChiTietHDB.MaHDB = HoaDonBan.MaHDB 
and ChiTietSanPham.MaChiTietSP = ChiTietHDB.MaChiTietSP and Hang.MaHang = SanPham.MaHang and Hang.MaHang = 'H07'
group by HoaDonBan.MaHDB
having count(ChiTietHDB.MaHDB) = (select count(ChiTietSanPham.MaChiTietSP)
								  from SanPham,Hang,ChiTietSanPham
								  where SanPham.MaSanPham = ChiTietSanPham.MaSanPham and  Hang.MaHang = SanPham.MaHang and Hang.MaHang = 'H07')

select * from dbo.cau2View
---TEST
--select ChiTietSanPham.MaSanPham
--from ChiTietSanPham,SanPham
--where ChiTietSanPham.MaSanPham = SanPham.MaSanPham and MaHang = 'H07'
--select * from ChiTietSanPham
--where MaSanPham = 'SP01' or MaSanPham = 'SP09'
--select * from ChiTietHDB
--insert into ChiTietHDB
--values('HDB01','CTSP12','4',null,null,null)
--delete from ChiTietHDB
--where MaHDB = 'HDB01' and MaChiTietSP = 'CTSP13'

--3. Tạo view đưa ra thông tin hóa đơn và tổng tiền của hóa đơn đó ngày 10-10-2022
--update
update HoaDonBan
set TongTienHDB = a.Tien-a.Tien*(PhanTram*1.0)/100.0
from (select ChiTietHDB.MaHDB,sum(SoLuongBan*DonGiaBan) as 'Tien'
		from ChiTietHDB,SanPham,ChiTietSanPham
		where SanPham.MaSanPham = ChiTietSanPham.MaSanPham and ChiTietSanPham.MaChiTietSP = ChiTietHDB.MaChiTietSP
		group by ChiTietHDB.MaHDB) a,Voucher
where HoaDonBan.MaHDB = a.MaHDB and HoaDonBan.MaVoucher = Voucher.MaVoucher
--

create view cau3View as
select HoaDonBan.MaHDB, TongTienHDB
from HoaDonBan
where NgayBan = '2022-10-10 00:00:00.000'

select * from dbo.cau3View
--4. Tạo view thống kê các máy không bán được trong tháng 10/2022
create view cau4View as
select ChiTietSanPham.MaSanPham,TenSanPham,MaChiTietSP
from SanPham,ChiTietSanPham
where SanPham.MaSanPham = ChiTietSanPham.MaSanPham and ChiTietSanPham.MaChiTietSP 
								not in(select ChiTietHDB.MaChiTietSP
								from HoaDonBan,ChiTietHDB,ChiTietSanPham,SanPham
								where SanPham.MaSanPham = ChiTietSanPham.MaSanPham and ChiTietHDB.MaHDB = HoaDonBan.MaHDB
								and ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP and MONTH(NgayBan)=10 and year(NgayBan)=2022)

select * from dbo.cau4View
--5. Tạo view đưa ra danh sách các máy còn tồn kho
alter view cau5View as
select ChiTietSanPhamNhap.MaChiTietSP,ChiTietSanPhamNhap.SoLuongNhap,isnull(ChiTietSanPhamBan.SoLuongBan,0) as 'SoLuongBan',(ChiTietSanPhamNhap.SoLuongNhap-isnull(ChiTietSanPhamBan.SoLuongBan,0)) as 'SoLuongTon'
from (Select ChiTietSanPham.MaChiTietSP,sum(SoLuongNhap) as 'SoLuongNhap'
	  from ChiTietHDN,ChiTietSanPham
	  where ChiTietSanPham.MaChiTietSP = ChiTietHDN.MaChiTietSP
	  group by ChiTietSanPham.MaChiTietSP) ChiTietSanPhamNhap left join (Select ChiTietSanPham.MaChiTietSP,isnull(sum(SoLuongBan),0) as 'SoLuongBan'
																		from ChiTietHDB,ChiTietSanPham
																		where ChiTietSanPham.MaChiTietSP = ChiTietHDB.MaChiTietSP
																		group by ChiTietSanPham.MaChiTietSP) ChiTietSanPhamBan on ChiTietSanPhamNhap.MaChiTietSP = ChiTietSanPhamBan.MaChiTietSP
where ChiTietSanPhamNhap.SoLuongNhap-isnull(ChiTietSanPhamBan.SoLuongBan,0)>0

select * from dbo.cau5View
--6. Tạo view đưa ra tổng số lượng máy nhập và số lượng máy bán trong năm 2022
create view cau6View as
select SoLuongNhap.SoLuongNhap,SoLuongBan.SoLuongBan
from (Select sum(SoLuongNhap) as 'SoLuongNhap'
	  from ChiTietHDN) SoLuongNhap, (Select sum(SoLuongBan) as 'SoLuongBan'
										   from ChiTietHDB) SoLuongBan

select * from dbo.cau6View

--7. Tạo view đưa ra khách hàng mua máy tính với trị giá hóa đơn cao nhất
create view cau7View as
select KhachHang.MaKhachHang,TenKhachHang,TongTienHDB
from KhachHang,HoaDonBan
where KhachHang.MaKhachHang = HoaDonBan.MaKhachHang
group by KhachHang.MaKhachHang,TenKhachHang,TongTienHDB
having TongTienHDB = (select max(TongTienHDB)
					from HoaDonBan)

select * from dbo.cau7View
--8. Tạo view đưa ra số hóa đơn bán và tổng tiền do nhân viên 'NV02' lập vào tháng '9' năm '2022'
create view cau8View as
select HoaDonBan.MaHDB,sum(TongTienHDB) as 'TongTienNhanVien'
from HoaDonBan,NhanVien
where HoaDonBan.MaNhanVien = NhanVien.MaNhanVien and NhanVien.MaNhanVien='NV02' and MONTH(NgayBan)=9 and year(NgayBan)=2022
group by HoaDonBan.MaHDB

select * from dbo.cau8View


-------------------------------------------------- FUNCTION ----------------------------------------------------------

-- Function
-- Hàm
--1. Tạo hàm có đầu vào năm, đầu ra là tháng có doanh thu cao nhất trong năm đó
Go
create function Cau1Ham(@Nam int)
returns table 
as
return 
(
	select top(1)  with ties month(NgayBan) As Thang, Sum(SoLuongBan*DonGiaBan*(1-(PhanTram/100.0))) as TongTien
	from HoaDonBan inner join ChiTietHDB on HoaDonBan.MaHDB = ChiTietHDB.MaHDB
				   inner join ChiTietSanPham on ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP	
				   inner join Voucher on HoaDonBan.MaVoucher = Voucher.MaVoucher
	where	year(NgayBan) = @Nam
	group by   month(NgayBan)
	order by TongTien desc 
)
select month(NgayBan), Sum(SoLuongBan*DonGiaBan*(1-(PhanTram/100.0))) from HoaDonBan inner join Voucher on HoaDonBan.MaVoucher = Voucher.MaVoucher 
inner join ChiTietHDB on HoaDonBan.MaHDB = ChiTietHDB.MaHDB
inner join ChiTietSanPham on ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP
group by  month(NgayBan)

select * from Cau1Ham(2022)
--2. Tạo hàm có đầu vào là tên Máy, đưa ra tất cả các linh kiện của máy đó
Go

create function Cau2Ham(@TenMay nvarchar(255))
returns table  
as
return 
(
	select TenLinhKien 
	from   ChiTietSanPham	inner join SanPham_LinhKien on ChiTietSanPham.MaChiTietSP = SanPham_LinhKien.MaChiTietSP 
							inner join LinhKien on SanPham_LinhKien.MaLinhKien = LinhKien.MaLinhKien
							inner join SanPham on SanPham.MaSanPham = ChiTietSanPham.MaSanPham
	where TenSanPham = @TenMay
)
select * from Cau2Ham(N'Bravo 15')

--3. Tạo hàm có đầu vào là năm, đưa ra top 5 nhân viên bán được nhiều sản phẩm nhất trong năm đó
Go
create function Cau3Ham(@Nam int)
returns table  
as
return 
(
	select top(5) with ties NhanVien.MaNhanVien, sum(SoLuongBan) as SoLuong
	from NhanVien	inner join HoaDonBan on NhanVien.MaNhanVien = HoaDonBan.MaNhanVien 
					inner join ChiTietHDB on ChiTietHDB.MaHDB = HoaDonBan.MaHDB
	where year(NgayBan) = @Nam
	group by NhanVien.MaNhanVien, year(NgayBan)
	order by sum(SoLuongBan) desc 
)
select * from Cau3Ham(2022)


--4. Tạo hàm có đầu vào là tên hãng, đưa ra thông tin sản phẩm, số máy đã nhập, số máy đã bán của hãng đó

create function Cau4Ham(@TenHang nvarchar(255))
returns table 
as 
return 
(
	select a.MaSanPham, a.TenSanPham, isnull(SLN, 0) as SLN, isnull(SLB, 0) as SLB
	from 
	(select SanPham.MaSanPham, TenSanPham, MaHang, sum(SoLuongNhap) as SLN
	from.ChiTietHDN, SanPham, ChiTietSanPham
	where ChiTietSanPham.MaChiTietSP = ChiTietHDN.MaChiTietSP
		and ChiTietSanPham.MaSanPham = SanPham.MaSanPham
	group by SanPham.MaSanPham,TenSanPham, Mahang) a 
	left join
	(select SanPham.MaSanPham, TenSanPham, MaHang, sum(SoLuongBan) as SLB
	from.ChiTietHDB, SanPham, ChiTietSanPham
	where ChiTietSanPham.MaChiTietSP = ChiTietHDB.MaChiTietSP
		and ChiTietSanPham.MaSanPham = SanPham.MaSanPham
	group by SanPham.MaSanPham,TenSanPham, Mahang) b
	on a.MaSanPham = b.MaSanPham, Hang 
	where a.MaHang = Hang.Mahang and TenHang = @TenHang
)
select * from Cau4Ham('Asus')
--5. Tạo hàm có đầu vào là mã hãng, năm, đầu ra là thông tin những khách hàng mua máy của hãng trong năm đó

create function Cau5Ham(@MaHang nvarchar(255), @Nam int)
returns table 
as
return 
(
	select distinct KhachHang.MaKhachHang, TenKhachHang
	from KhachHang, HoaDonBan, ChiTietHDB, SanPham, ChiTietSanPham
	where KhachHang.MaKhachHang = HoaDonBan.MaKhachHang
	and HoaDonBan.MaHDB = ChiTietHDB.MaHDB
	and ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP
	and ChiTietSanPham.MaSanPham = SanPham.MaSanPham
	and year(NgayBan) = @Nam
	and MaHang = @MaHang
)
select * from Cau5Ham('H07',2022)
	
--6. Tạo hàm có đầu vào là mã nhân viên, năm, đầu ra là tổng tiền và số lượng hóa đơn bán của nhân viên đó đã lập
--trong năm đầu vào

create function Cau6Ham(@MaNhanVien nvarchar(255), @Nam int)
returns table 
as 
return 
(
	select count(Distinct HoaDonBan.MaHDB) as SL, Sum(SoLuongBan*DonGiaBan*(1-(PhanTram/100.0))) as TongTien
	from NhanVien, HoaDonBan, ChiTietHDB, Voucher, ChiTietSanPham
	where  NhanVien.MaNhanVien = HoaDonBan.MaNhanVien
			and HoaDonBan.MaHDB = ChiTietHDB.MaHDB
			and ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP
			and HoaDonBan.MaVoucher = Voucher.MaVoucher
			and NhanVien.MaNhanVien = @MaNhanVien
			and YEAR(NgayBan) = @Nam	

)
select * from Cau6Ham('NV01',2022)


---------------------------------------------------------------- PROCEDURE ------------------------------------------------------------------------------

--1. Tạo thủ tục có đầu vào là tên của Hãng, đầu ra là số lượng máy tính của Hãng đó bán được trong tháng 5

create procedure Cau1THUTUC @tenhang nvarchar(255), @soluong int output
as
begin
	select @soluong = sum(SoLuongBan)
	from ChiTietHDB join ChiTietSanPham on ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP
		join SanPham on ChiTietSanPham.MaSanPham = SanPham.MaSanPham
		join Hang on SanPham.MaHang = Hang.MaHang
		join HoaDonBan on HoaDonBan.MaHDB = ChiTietHDB.MaHDB
	where @tenhang=TenHang and month(NgayBan) = 5 and YEAR(NgayBan) =2022
end

declare @soluongMT int
exec Cau1THUTUC N'MSI', @soluongMT output
print N'Số lượng máy bán: ' + cast(@soluongMT as char(30))

--2. Tạo thủ tục có đầu vào là mã nhà cung cấp, đầu ra là số máy nhập và tổng tiền

create procedure Cau2THUTUC @manhacungcap nvarchar(255), @somay int output, @tongtien money output
as
begin
	select @somay = sum(SoLuongNhap), @tongtien = sum(DonGiaNhap*SoLuongNhap)
	from ChiTietHDN join HoaDonNhap on ChiTietHDN.MaHDN = HoaDonNhap.MaHDN
		join ChiTietSanPham on ChiTietSanPham.MaChiTietSP = ChiTietHDN.MaChiTietSP
		join NhaCungCap on NhaCungCap.MaNhaCungCap = HoaDonNhap.MaNhaCungCap
	where @manhacungcap = NhaCungCap.MaNhaCungCap
end

declare @soluong int, @tien money
exec Cau2THUTUC N'NCC01', @soluong output, @tien output
print N'Số lượng máy nhập: ' + cast(@soluong as char(30))
print N'Tổng tiền nhập: ' + cast(@tien as char(20))

--3. Tạo thủ tục có đầu vào là mã hãng, đầu ra là số lượng tồn máy tính của hãng đó

create procedure Cau3THUTUC @mahang nvarchar(255), @soluong int output
as
begin
	select @soluong = SanPhamNhap.SoLuongNhap-isnull(SanPhamBan.SoLuongBan,0)
	from (Select Hang.MaHang,sum(SoLuongNhap) as SoLuongNhap
	  from ChiTietHDN join ChiTietSanPham on ChiTietHDN.MaChiTietSP = ChiTietSanPham.MaChiTietSP
		join SanPham on SanPham.MaSanPham = ChiTietSanPham.MaSanPham
		join Hang on Hang.MaHang = SanPham.MaHang
	  group by Hang.MaHang) SanPhamNhap join (Select Hang.MaHang, isnull(sum(SoLuongBan),0) as SoLuongBan
										   from ChiTietHDB join ChiTietSanPham on ChiTietSanPham.MaChiTietSP = ChiTietHDB.MaChiTietSP
												join SanPham on SanPham.MaSanPham = ChiTietSanPham.MaSanPham
												join Hang on Hang.MaHang = SanPham.MaHang
										   group by Hang.MaHang) SanPhamBan on SanPhamNhap.MaHang = SanPhamBan.MaHang
	where @mahang = SanPhamBan.MaHang
end

declare @soluongMT int
exec Cau3THUTUC N'H01', @soluongMT output
print N'Số lượng máy : ' + cast(@soluongMT as char(30))

select * from ChiTietHDN
select * from HoaDonNhap
--4. Tạo thủ tục có đầu vào là mã nhân viên, năm, đầu ra là số hóa đơn bán do nhân viên đó lập trong năm đó

create procedure Cau4THUTUC @manhanvien nvarchar(255), @nam int, @sohoadon int output
as
begin
	select @sohoadon = count(HoaDonBan.MaHDB)
	from HoaDonBan
	where @manhanvien = HoaDonBan.MaNhanVien and @nam = YEAR(NgayBan)
end

declare @soHD int
exec Cau4THUTUC N'NV02',2022, @soHD output
print N'Số hóa đơn bán đã lập : ' + cast(@soHD as char(30))

--5. Tạo thủ tục có đầu vào là tháng năm, đầu ra là tổng doanh thu của tháng trong năm đó
create procedure Cau5THUTUC @thang int, @nam int, @tongtien money output
as
begin
	select @tongtien =  sum(BangA.DonGia-BangA.DonGia*(PhanTram*1.0/100.0))
	from (select ChiTietHDB.MaHDB, sum(SoLuongBan*DonGiaBan) as DonGia
		from ChiTietHDB join ChiTietSanPham on ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP
		group by ChiTietHDB.MaHDB) BangA join HoaDonBan on  HoaDonBan.MaHDB = BangA.MaHDB
										join Voucher on Voucher.MaVoucher = HoaDonBan.MaVoucher
	where @thang = MONTH(NgayBan) and @nam = YEAR(NgayBan)
end

declare @tien money
exec Cau5THUTUC 05,2022, @tien output
print N'Tổng doanh thu: ' + cast(@tien as char(20))

--6. Tạo thủ tục có đầu vào là mã khách hàng, đầu ra là số tiền mà khách hàng đó đã sử dụng để mua máy tính

create procedure Cau6THUTUC @makhachhang nvarchar(255), @tongtien money output
as
begin
	select @tongtien =  sum(BangA.DonGia-BangA.DonGia*(PhanTram*1.0/100.0))
	from (select ChiTietHDB.MaHDB, sum(SoLuongBan*DonGiaBan) as DonGia
		from ChiTietHDB join ChiTietSanPham on ChiTietHDB.MaChiTietSP = ChiTietSanPham.MaChiTietSP
		group by ChiTietHDB.MaHDB) BangA join HoaDonBan on  HoaDonBan.MaHDB = BangA.MaHDB
										join Voucher on Voucher.MaVoucher = HoaDonBan.MaVoucher
	where @makhachhang = HoaDonBan.MaKhachHang
end

declare @tien money
exec Cau6THUTUC N'KH01', @tien output
print N'Tổng tiền: ' + cast(@tien as char(20))

---------------------------------------------------------------- KỊCH BẢN ------------------------------------------------------------------------------
/*Kịch bản 1
– Tạo login NguyenVanAn, TranVanMinh
– Tạo user NguyenVanAn, TranVanMinh tương ứng với login NguyenVanAn, TranVanMinh
trên CSDL BTL
– Gán quyền select, update cho NguyenVanAn trên bảng SanPham của CSDL BTL, NguyenVanAn
có quyền trao quyền này cho người khác
– Đăng nhập NguyenVanAn để kiểm tra
– Từ NguyenVanAn, Trao quyền select cho TranVanMinh trên bảng SanPham của CSDL BTL
– Đăng nhập TranVanMinh để kiểm tra*/
exec sp_addlogin NguyenVanAn, 123
exec sp_addlogin TranVanMinh, 123
exec sp_adduser NguyenVanAn, NguyenVanAn
exec sp_adduser TranVanMinh, TranVanMinh
grant select, update on SanPham to NguyenVanAn with grant option
grant select on SanPham to TranVanMinh


/*Kịch bản 2
– Tạo login NguyenQuangHao
– Tạo user NguyenQuangHao cho login NguyenQuangHao trên CSDL BTL
– Gán quyền select cho NguyenQuangHao trên cau1view cho NguyenQuangHao, NguyenQuangHao
có quyền trao quyền này cho người khác
– Đăng nhập NguyenQuangHao để kiểm tra
– Tạo login NguyenTanLuc
– Tạo user NguyenTanLuc cho login NguyenTanLuc trên CSDL BTL
- Đăng nhập NguyenTanLuc để kiểm tra
- Từ login NguyenQuangHao, phân quyền select, update trên cau1view cho NguyenTanLuc
- Đăng nhập NguyenTanLuc để kiểm tra*/
exec sp_addlogin NguyenQuangHao, 123
exec sp_adduser NguyenQuangHao, NguyenQuangHao
grant select on cau1View to NguyenQuangHao with grant option
exec sp_addlogin NguyenTanLuc, 123
exec sp_adduser NguyenTanLuc, NguyenTanLuc
grant select, update on cau1View to NguyenTanLuc

/*Kịch bản 3
– Tạo login A, B , C
– Tạo user userA, userB, userC tương ứng với login A, B, C
– Gán quyền select, update, delete, insert cho userA trên bảng KhachHang của CSDL 
BTL, A có quyền trao quyền này cho người khác
– Đăng nhập A để kiểm tra
– Từ A, Trao quyền select, update cho userB trên bảng NhaCungCap của CSDL 
QLBanHang
– Đăng nhập B để kiểm tra
– Từ B, Trao quyền select cho userC trên bảng NhaCungCap của CSDL QLBanHang
– Đăng nhập C để kiểm tra
– Xóa login và user B, C*/
exec sp_addlogin A, 123
exec sp_addlogin B, 123
exec sp_addlogin C, 123
exec sp_adduser A, userA
exec sp_adduser B, userB
exec sp_adduser C, userC
grant select, update, delete, insert on KhachHang to userA with grant option
grant select, update on NhaCungCap to userB
grant select on NhaCungCap to userB
drop login B
drop login C



