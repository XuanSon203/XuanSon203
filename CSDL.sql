-- Tạo cơ sở dữ liệu QuanLyTiemBanh
CREATE DATABASE QuanLyTiemBanh;
USE QuanLyTiemBanh;

-- Tạo bảng DanhMuc
CREATE TABLE DanhMuc (
    MaDanhMuc  Nvarchar(50) PRIMARY KEY ,
    TenDanhMuc NVARCHAR(255) NOT NULL
);

-- Tạo bảng TaiKhoan
CREATE TABLE TaiKhoan (
    MaTaiKhoan INT PRIMARY KEY IDENTITY(1,1),
    TenDangNhap NVARCHAR(50) NOT NULL,
    MatKhau NVARCHAR(255) NOT NULL,
    VaiTro NVARCHAR(50) NOT NULL,
    Email NVARCHAR(50) UNIQUE NOT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    SoDienThoai NVARCHAR(20) NULL
);

-- Tạo bảng SanPham
CREATE TABLE SanPham (
    MaSanPham Nvarchar(50) PRIMARY KEY,
    TenSanPham NVARCHAR(255) NOT NULL,
    Gia DECIMAL(18, 2) NOT NULL,
    MoTa NVARCHAR(MAX) NULL,
    HinhAnh NVARCHAR(255) NULL,
    SoLuongTonKho INT NOT NULL,
    NgaySanXuat DATETIME NULL,
    HanSuDung DATETIME NULL,
    ThanhPhan NVARCHAR(300) NULL,
    MaDanhMuc Nvarchar(50),
    FOREIGN KEY (MaDanhMuc) REFERENCES DanhMuc(MaDanhMuc) ON DELETE CASCADE
);

-- Tạo bảng DonHang
CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY IDENTITY(1,1),
    NgayDatHang DATETIME DEFAULT GETDATE(),
    TongTien DECIMAL(18, 2) NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    HoTen NVARCHAR(255) NOT NULL,
    DiaChi NVARCHAR(255) NULL,
    MaTaiKhoan INT,
    CONSTRAINT FK_DonHang_TaiKhoan FOREIGN KEY (MaTaiKhoan) REFERENCES TaiKhoan(MaTaiKhoan) ON DELETE CASCADE
);

-- Tạo bảng ChiTietDonHang
CREATE TABLE ChiTietDonHang (
    MaChiTietDonHang INT PRIMARY KEY IDENTITY(1,1),
    MaDonHang INT NOT NULL,
    MaSanPham Nvarchar(50) NOT NULL,
    SoLuong INT NOT NULL,
    GiaBan DECIMAL(18, 2) NOT NULL,
    CONSTRAINT FK_ChiTietDonHang_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang) ON DELETE CASCADE,
    CONSTRAINT FK_ChiTietDonHang_SanPham FOREIGN KEY (MaSanPham) REFERENCES SanPham(MaSanPham) ON DELETE CASCADE
);

-- Tạo bảng ThanhToan
CREATE TABLE ThanhToan (
    MaThanhToan INT PRIMARY KEY IDENTITY(1,1),
    MaDonHang INT NOT NULL,
    PhuongThucThanhToan NVARCHAR(50) NOT NULL,
	
    TongTien DECIMAL(18, 2) NOT NULL,
    NgayThanhToan DATETIME DEFAULT GETDATE(),
    TrangThaiThanhToan NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_ThanhToan_DonHang FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang) ON DELETE CASCADE
);

-- Tạo bảng AboutUs
CREATE TABLE AboutUs (
    MaAboutUs INT PRIMARY KEY IDENTITY(1,1),
    TieuDe NVARCHAR(255) NOT NULL,
    NoiDung NVARCHAR(MAX) NOT NULL,
    HinhAnh NVARCHAR(255) NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    NgayCapNhat DATETIME DEFAULT GETDATE()
);

-- Tạo bảng ThanhVien
CREATE TABLE ThanhVien (
    MaThanhVien INT PRIMARY KEY IDENTITY(1,1),
    TenThanhVien NVARCHAR(255) NOT NULL,
    Email NVARCHAR(50) UNIQUE NOT NULL,
    SoDienThoai NVARCHAR(20) NULL,
    DiaChi NVARCHAR(255) NULL,
    NgaySinh DATETIME NULL,
    NgayThamGia DATETIME DEFAULT GETDATE(),
    VaiTro NVARCHAR(50) NOT NULL CHECK (VaiTro IN ('Admin', 'User')), -- Ràng buộc vai trò
    MatKhau NVARCHAR(255) NOT NULL
);
