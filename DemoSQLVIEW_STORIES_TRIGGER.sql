/*Tuần 7 - Viết code tạo cơ sở dữ liệu với cấu trúc lược đồ quan hệ của tuần 6*/
CREATE DATABASE HTQL_DACSN
GO
USE HTQL_DACSN
GO

/*==============================================================*/
/* Table: TBLHOCPHAN                                            */
/*==============================================================*/

CREATE TABLE TblHocPhan(
	MaHocPhan VARCHAR(20),
	TenHocPhan NVARCHAR(255),
	SoTinChi INT,
	SoTietTH INT,
	SoTietLT INT,
	PRIMARY KEY (MaHocPhan)
)

/*==============================================================*/
/* Index: TBLHOCPHAN_PK                                         */
/*==============================================================*/
create unique index TBLHOCPHAN_PK on TblHocPhan (
MaHocPhan ASC
);

/*==============================================================*/
/* Table: TBLCHUYENMON                                          */
/*==============================================================*/
CREATE TABLE TblChuyenMon(
	MaChuyenMon VARCHAR(20),
	TrinhDo VARCHAR(255),
	ChuyenNganh VARCHAR(255),
	PRIMARY KEY (MaChuyenMon)
)
/*==============================================================*/
/* Index: TBLCHUYENMON_PK                                       */
/*==============================================================*/
create unique index TBLCHUYENMON_PK on TblChuyenMon (
MaChuyenMon ASC
);
/*==============================================================*/
/* Table: TBLGIAOVIEN                                           */
/*==============================================================*/
CREATE TABLE TblGiangVien(
	MaGiangVien VARCHAR(20),
	HoTen NVARCHAR(50),
	MaChuyenMon VARCHAR(20),
	SdtGV INT,
	Email VARCHAR(50),
	PRIMARY KEY (MaGiangVien),
	FOREIGN KEY (MaChuyenMon) REFERENCES TblChuyenMon (MaChuyenMon)
)

/*==============================================================*/
/* Index: TBLGIAOVIEN_PK                                        */
/*==============================================================*/
create unique index TBLGIAOVIEN_PK on TblGiangVien (
MaGiangVien ASC
);
/*==============================================================*/
/* Table: TBLLOP                                                */
/*==============================================================*/
CREATE TABLE TblLop(
	MaLop VARCHAR(20),
	TenLop NVARCHAR(255),
	NamTuyenSinh VARCHAR(255),
	PRIMARY KEY (MaLop)
)
/*==============================================================*/
/* Index: TBLLOP_PK                                             */
/*==============================================================*/
create unique index TBLLOP_PK on TblLop (
MaLop ASC
);
/*==============================================================*/
/* Table: TBLSINHVIEN                                           */
/*==============================================================*/
CREATE TABLE TblSinhVien(
	MSSV VARCHAR(20),
	MaLop VARCHAR(20),
	HoTenSV NVARCHAR(50),
	SdtSV INT,
	Email VARCHAR(50),
	PRIMARY KEY (MSSV),
	FOREIGN KEY(MaLop) REFERENCES TblLop (MaLop)
)
/*==============================================================*/
/* Index: TBLSINHVIEN_PK                                        */
/*==============================================================*/
create unique index TBLSINHVIEN_PK on TblSinhVien (
MSSV ASC
);

/*==============================================================*/
/* Table: TBLDETAI                                              */
/*==============================================================*/
CREATE TABLE TblDeTai(
	MaDeTai VARCHAR(20),
	MaHocPhan VARCHAR(20),
	MaGiangVien VARCHAR(20),
	TenDeTai NVARCHAR(150),
	MoTaChiTiet NVARCHAR(1000),
	TrangThaiDeTai VARCHAR(50),
	PRIMARY KEY (MaDeTai),
	FOREIGN KEY (MaHocPhan) REFERENCES TblHocPhan (MaHocPhan),
	FOREIGN KEY (MaGiangVien) REFERENCES TblGiangVien (MaGiangVien)
)
/*==============================================================*/
/* Index: TBLDETAI_PK                                           */
/*==============================================================*/
create unique index TBLDETAI_PK on TblDeTai (
MaDeTai ASC
);
/*==============================================================*/
/* Index: DT_GV_FK                                              */
/*==============================================================*/
create index DT_GV_FK on TblDeTai (
MaGiangVien ASC
);
/*==============================================================*/
/* Table: DT_SV                                                 */
/*==============================================================*/
CREATE TABLE TblDeTai_SinhVien(
	MSSV VARCHAR(20),
	MaDeTai VARCHAR(20),
	TGThucHien DATETIME,
	FOREIGN KEY (MSSV) REFERENCES TblSinhVien (MSSV),
	FOREIGN KEY (MaDeTai) REFERENCES TblDeTai (MaDeTai)
)
/*==============================================================*/
/* Index: DT_SV_FK                                              */
/*==============================================================*/
create index DT_SV_FK on TblDeTai_SinhVien (
MSSV ASC
);
/*==============================================================*/
/* Index: DT_SV2_FK                                             */
/*==============================================================*/
create index DT_SV2_FK on TblDeTai_SinhVien (
MaDeTai ASC
);
/*==============================================================*/
/* Table: CHAMBAOCAO                                            */
/*==============================================================*/
CREATE TABLE TblChamBaoCao (
  ID int IDENTITY PRIMARY KEY ,
  MaGiangVien VARCHAR(20),
  MaDeTai VARCHAR(20),
  MSSV VARCHAR(20),
  Diem FLOAT,
  NguoiChamThu NVARCHAR(255),
  FOREIGN KEY (MSSV) REFERENCES TblSinhVien (MSSV),
  FOREIGN KEY (MaGiangVien) REFERENCES TblGiangVien (MaGiangVien),
  FOREIGN KEY (MaDeTai) REFERENCES TblDeTai (MaDeTai)
);
alter table tblChamBaoCao
   add constraint FK_CHAMBAOC_CHAMBAOCAO_TBLGIANGVIEN foreign key (MaGiangVien)
      references tblGiangVien (MaGiangVien)
alter table tblChamBaoCao
   add constraint FK_CHAMBAOC_CHAMBAOCAO_TBLDETAI foreign key (MaDeTai)
      references tblDeTai (MaDeTai)
alter table TblChamBaoCao
   add constraint FK_CHAMBAOCAO_CHAMBAOCA_TBLSINHVIEN foreign key (MSSV)
      references TblSinhVien (MSSV)
alter table TblDeTai_SinhVien
   add constraint FK_DT_SV_DT_SV_TBLSINHVIEN foreign key (MSSV)
      references TblSinhVien (MSSV)
alter table TblDeTai_SinhVien
   add constraint FK_DT_SV_DT_SV2_TBLDETAI foreign key (MaDeTai)
      references TblDeTai (MaDeTai)
alter table TblDeTai
   add constraint FK_TBLDETAI_DT_GV_TBLGIAOV foreign key (MaGiangVien)
      references TblGiangVien (MaGiangVien)
alter table TblDeTai
   add constraint FK_TBLDETAI_HP_DT_TBLHOCPH foreign key (MaHocPhan)
      references TblHocPhan (MaHocPhan)
alter table TblGiangVien
   add constraint FK_TBLGIANGVIEN_TBLCHUYENMON foreign key (MaChuyenMon)
      references TblChuyenMon (MaChuyenMon)
alter table TblSinhVien
   add constraint FK_TBLSINHV_SV_LOP_TBLLOP foreign key (MaLop)
      references TblLop (MaLop)

/*Tuần 8 - Viết code nhập dữ liệu cho các bảng dữ bảng trên cơ sở cấu trúc bảng của tuần 8 và bảng dữ liệu đã chuẩn bị của tuần 7*/
INSERT INTO TblHocPhan(MaHocPhan, TenHocPhan, SoTinChi, SoTietLT, SoTietTH) VALUES ('220265', N'thực tập đồ án cơ sở ngành', '3', '0', '90');
GO

INSERT INTO TblChuyenMon(MaChuyenMon, TrinhDo, ChuyenNganh) VALUES
('ATTT',   N'Thạc Sĩ',  N'An toàn thông tin và Bảo mật mạng'), 
('KHDL',   N'Thạc Sĩ',  N'Khoa học Dữ liệu và Phân tích Dữ liệu lớn'), 
('PTUD',   N'Thạc Sĩ',  N'Phát triển ứng dụng di động và Web'), 
('TTNT',   N'Thạc Sĩ',  N'Trí tuệ nhân tạo và Học máy'), 
('KHMT',   N'Tiến Sĩ',  N'Khoa học Máy tính và Kỹ thuật phần mềm'), 
('MMT',    N'Tiến sĩ',  N'Mạng máy tính và Công nghệ Mạng'), 
('TGMT',   N'Tiến sĩ',  N'Thị giác máy tính và Xử lý hình ảnh'), 
('TTNTRB', N'Tiến sĩ',  N'Trí tuệ nhân tạo và Robot học');
GO

INSERT INTO TblGiangVien(MaGiangVien, HoTen, MaChuyenMon, SdtGV, Email) VALUES
('NNL',   N'Nguyễn Nhứt Lam',         'TTNT',    '919556441',  'lamnn@tvu.edu.vn'),
('NBA',   N'Nguyễn Bảo Ân',           'TTNTRB',  '908961632',  'annb@tvu.edu.vn'),
('PTTM',  N'Phạm Thị Trúc Mai',       'PTUD',    '936010206',  'pttmai@tvu.edu.vn'),
('DNVK',  N'Dương Ngọc Vân Khanh',    'ATTT',    '988332008',  'vankhanh@tvu.edu.vn'),
('PTPN',  N'Phan Thị Phương Nam',     'KHDL',    '989236166',  'ptpnam@tvu.edu.vn'),
('DPM',   N'Đoàn Phước Miền',         'ATTT',    '978962954',  'phuocmien@tvu.edu.vn'),
('HVT',   N'Huỳnh Văn Thanh',         'PTUD',    '977654181',  'hvthanh@tvu.edu.vn'),
('NHDT',  N'Nguyễn Hoàng Duy Thiện',  'MMT',     '989274222',  'thiennhd@tvu.edu.vn');
GO

INSERT INTO TblLop( MaLop, TenLop, NamTuyenSinh) VALUES
('DA21TTB', N'Công nghệ thông tin B', '2021'),
('DA21TTC', N'Công nghệ thông tin C', '2021'),
('DA21TTA', N'Công nghệ thông tin A', '2021');
GO

INSERT INTO TblSinhVien(MSSV, MaLop, HoTenSV, SdtSV, Email) VALUES
('110121255',  'DA21TTC',  N'Lâm Huệ Trung',      '147852369',   'lamhuetrung@gamil.com'),
('110121266',  'DA21TTC',  N'Mã Đại Phú',         '148852368',   'madaiphu@gmail.com'),
('110121269',  'DA21TTC',  N'Nguyễn Hoàng Nhựt',  '147852367',   'hoangnhut@gmail.com'),
('110121254',  'DA21TTC',  N'La Tấn Đạt',         '147856923',   'tandat@gmail.com'),
('110121253',  'DA21TTC',  N'Đặng Thị Kim Ngân',  '123654476',   'kimngan@gmail.com'),
('110121252',  'DA21TTC',  N'Lâm Huỳnh Như',      '145236798',   'huynhnhu@gmail.com'),
('110121264',  'DA21TTC',  N'Tải Trọng Nghĩa',    '147986325',   'trongnghia@gmail.com'),
('110121263',  'DA21TTC',  N'Kim Hoàng Nam',      '178542369',   'hoangnam@gmail.com'),
('110121278',  'DA21TTC',  N'Lê Trực Tín',        '149876523',   'tructin@gmail.com'),
('110121222',  'DA21TTC',  N'Nguyễn Hữu Luân',    '125437986',   'huuluan@gmail.com'),
('110121210',  'DA21TTB',  N'Nguyễn Tuyết Như',   '145237896',   'tuyetnhu@gmail.com'),
('110121211',  'DA21TTB',  N'La Tuyết Huệ',       '145236978',   'tuyethue@gmail.com'),
('110121112',  'DA21TTB',  N'Dương Văn Hiệp',     '147852365',   'vanhiep@gmail.comm'),
('110121213',  'DA21TTB',  N'Nguyễn Đức Mạnh',    '147258369',   'ducmanh@gmail.com'),
('110121214',  'DA21TTB',  N'Nguyễn Trung Kiên',  '145236987',   'trungkien@gmail.com'),
('110121221',  'DA21TTA',  N'Quách Tấn Quân',     '147896325',   'tanquan@gmail.com'),
('110121223',  'DA21TTA',  N'Cao Kỳ',             '254136987',   'caoky@gmail.com'),
('110121224',  'DA21TTA',  N'Huỳnh Văn Tới',      '145236987',   'vantoi@gmail.com'),
('110121225',  'DA21TTA',  N'Dương Hoàng Duy',    '147896523',   'hoangduy@gmail.com'),
('110121247',  'DA21TTA',  N'Thạch Minh Hòa',     '145236987',   'minhoa@gmail.com');
GO 

INSERT INTO TblDeTai(MaDeTai, MaHocPhan, MaGiangVien, TenDeTai, MoTaChiTiet, TrangThaiDeTai) VALUES
('CSN211',   '220265',  'NNL',   N'Hệ thống quản lý thư viện',                          N'Xây dựng hệ thống quản lý thư viện để quản lý thông tin về sách, độc giả, mượn/trả sách. Sử dụng ngôn ngữ Java và framework Spring Boot.',                                              N'Đã đăng ký'),
('CSN212',   '220265',  'NNL',   N'Hệ thống quản lý nhân sự',                           N'Phát triển hệ thống quản lý thông tin về nhân sự trong một công ty, bao gồm thông tin cá nhân, hợp đồng lao động, bảng lương. Sử dụng ngôn ngữ Python và framework Django.',            N'Hoàn thành'),
('CSN213',   '220265',  'NNL',   N'Hệ thống quản lý bán hàng',                          N'Xây dựng hệ thống quản lý bán hàng cho các cửa hàng nhỏ, bao gồm quản lý sản phẩm, đơn hàng, khách hàng. Sử dụng ngôn ngữ PHP và framework Laravel.',                                   N'Hoàn thành'),
('CSN214',   '220265',  'NNL',   N'Hệ thống quản lý khách sạn',                         N'Phát triển hệ thống quản lý điểm của sinh viên trong một trường đại học, bao gồm nhập điểm, tính điểm trung bình. Sử dụng ngôn ngữ JavaScript và framework Node.js',                    N'Hoàn thành'),
('CSN215',   '220265',  'NNL',   N'Hệ thống quản lý kho hàng',                          N'Xây dựng hệ thống quản lý kho hàng cho các doanh nghiệp, bao gồm nhập/xuất hàng, kiểm kê kho. Sử dụng ngôn ngữ Ruby và framework Ruby on Rails.',                                       N'Hoàn thành'),
('CSN216',   '220265',  'NNL',   N'Hệ thống quản lý dự án phần mềm',                    N'Tạo một hệ thống quản lý dự án phần mềm để theo dõi tiến độ, nguồn lực và công việc trong dự án. Sử dụng ngôn ngữ Java và framework Spring.',                                           N'Hoàn thành'),
('CSN217',   '220265',  'NBA',   N'Hệ thống quản lý y tế',                              N'Phát triển hệ thống quản lý thông tin y tế của bệnh nhân, bao gồm lịch sử bệnh, đơn thuốc, lịch tái khám. Sử dụng ngôn ngữ Python và framework Flask.',                                 N'Hoàn thành'),
('CSN218',   '220265',  'NBA',   N'Hệ thống quản lý trường học',                        N'Xây dựng hệ thống quản lý thông tin của một trường học, bao gồm thông tin học sinh, giáo viên, lớp học. Sử dụng ngôn ngữ PHP và framework CodeIgniter.',                                N'Hoàn thành'),
('CSN219',   '220265',  'NBA',   N'Hệ thống quản lý dự án xây dựng',                    N'Tạo một hệ thống quản lý dự án xây dựng để theo dõi tiến độ công trình, tài liệu và nguồn lực. Sử dụng ngôn ngữ C# và framework ASP.NET MVC.',                                          N'Hoàn thành'),
('CSN220',   '220265',  'NBA',   N'Hệ thống quản lý kế toán',                           N'Phát triển hệ thống quản lý kế toán cho các doanh nghiệp, bao gồm quản lý hóa đơn, thu chi, báo cáo tài chính. Sử dụng ngôn ngữ Java và framework Hibernate.',                          N'Hoàn thành'),
('CSN221',   '220265',  'NBA',   N'Hệ thống quản lý chuỗi cung ứng',                    N'Xây dựng hệ thống quản lý chuỗi cung ứng cho các doanh nghiệp sản xuất, bao gồm quản lý nhà cung cấp, đơn đặt hàng, lưu trữ sản phẩm. Sử dụng ngôn ngữ Ruby và framework Sinatra.',     N'Hoàn thành'),
('CSN222',   '220265',  'NBA',   N'Hệ thống quản lý video game',                        N'Tạo một hệ thống quản lý thông tin về video game, bao gồm danh sách game, thông tin về người chơi và bảng xếp hạng. Sử dụng ngôn ngữ JavaScript và framework Express.js.',              N'Hoàn thành'),
('CSN223',   '220265',  'PTTM',  N'Hệ thống quản lý dữ liệu địa lý',                    N'Phát triển hệ thống quản lý dữ liệu địa lý để lưu trữ và truy xuất thông tin về địa lý, bản đồ, địa điểm. Sử dụng ngôn ngữ Python và framework Flask.',                                 N'Hoàn thành'),
('CSN224',   '220265',  'PTTM',  N'Hệ thống quản lý vận chuyển',                        N'Xây dựng hệ thống quản lý vận chuyển hàng hóa, bao gồm quản lý đơn hàng, xe vận chuyển và lộ trình giao hàng. Sử dụng ngôn ngữ Java và framework Spring Boot.',                         N'Hoàn thành'),
('CSN225',   '220265',  'PTTM',  N'Hệ thống quản lý phòng gym',                         N'Phát triển hệ thống quản lý thông tin của một phòng tập gym, bao gồm thông tin hội viên, lịch tập, gó',                                                                                 N'Hoàn thành'),
('CSN226',   '220265',  'PTTM',  N'Hệ thống quản lý đặt phòng khách sạn trực tuyến',    N'Xây dựng một hệ thống web cho phép người dùng đặt phòng khách sạn trực tuyến, bao gồm tìm kiếm phòng, đặt phòng, thanh toán. Sử dụng ngôn ngữ JavaScript và framework React.js.',       N'Hoàn thành'),
('CSN227',   '220265',  'PTPN',  N'Hệ thống quản lý quản lý bất động sản',              N'Phát triển một trang web cho phép người dùng tìm kiếm, đăng tin và quản lý thông tin về bất động sản, bao gồm nhà ở, căn hộ, đất đai. Sử dụng ngôn ngữ PHP và framework Symfony.',      N'Hoàn thành'),
('CSN228',   '220265',  'PTPN',  N'Hệ thống quản lý quản lý thương mại điện tử',        N'Xây dựng một trang web thương mại điện tử để bán hàng trực tuyến, bao gồm quản lý sản phẩm, giỏ hàng, thanh toán. Sử dụng ngôn ngữ Python và framework Django.',                        N'Hoàn thành'),
('CSN229',   '220265',  'PTPN',  N'Hệ thống quản lý blog',                              N'Tạo một trang web cho phép người dùng tạo, chỉnh sửa và quản lý blog cá nhân, bao gồm đăng bài viết, tương tác với độc giả. Sử dụng ngôn ngữ JavaScript và framework Vue.js.',          N'Hoàn thành'),
('CSN230',   '220265',  'PTPN',  N'Hệ thống quản lý sự kiện trực tuyến',                N'Phát triển một trang web để quản lý và tổ chức sự kiện trực tuyến, bao gồm tạo sự kiện, quản lý đăng ký và tham gia. Sử dụng ngôn ngữ Ruby và framework Ruby on Rails.',                N'Hoàn thành');
GO

INSERT INTO TblDeTai_SinhVien(MSSV, MaDeTai, TGThucHien) VALUES
('110121255',  'CSN211', '01/02/2024'),
('110121266',  'CSN212', '01/02/2024'),
('110121269',  'CSN213', '01/02/2024'),
('110121254',  'CSN214', '01/02/2024'),
('110121253',  'CSN217', '01/02/2024'),
('110121252',  'CSN218', '01/02/2024'),
('110121264',  'CSN219', '01/02/2024'),
('110121263',  'CSN220', '01/02/2024'),
('110121278',  'CSN221', '01/02/2024'),
('110121222',  'CSN223', '01/02/2024'),
('110121211',  'CSN224', '01/02/2024'),
('110121112',  'CSN225', '01/02/2024'),
('110121213',  'CSN226', '01/02/2024'),
('110121214',  'CSN227', '01/02/2024'),
('110121221',  'CSN228', '01/02/2024'),
('110121223',  'CSN229', '01/02/2024'),
('110121224',  'CSN230', '01/02/2024')
GO

INSERT INTO TblChamBaoCao(MaGiangVien, MaDeTai, MSSV, Diem, NguoiChamThu) VALUES
('NNL',   'CSN212', '110121266',   '9.2',   'DPM'),
('NNL',   'CSN213', '110121269',   '9',     'DPM'),
('NNL',   'CSN214', '110121254',   '8',     'DPM'),
('NBA',   'CSN217', '110121253',   '8.2',   'DPM'),
('NBA',   'CSN218', '110121252',   '8.8',   'DPM'),
('NBA',   'CSN219', '110121264',   '8.6',   'DPM'),
('NBA',   'CSN220', '110121263',   '8.4',   'NHDT'),
('NBA',   'CSN221', '110121278',   '9.4',   'NHDT'),
('PTTM',  'CSN223', '110121222',   '9.8',   'NHDT'),
('PTTM',  'CSN224', '110121211',   '10',    'NHDT'),
('PTTM',  'CSN226', '110121213',   '9.5',   'NHDT'),
('PTPN',  'CSN227', '110121214',   '8.5',   'HVT'),
('PTPN',  'CSN228', '110121221',   '9.2',   'HVT'),
('PTPN',  'CSN229', '110121223',   '9.4',   'HVT'),
('PTPN',  'CSN230', '110121224',   '9.8',   'HVT');
GO

/*Tuần 9 -Viết code khai thác các tính năng của hệ thống theo phân quyền và chức năng sử dụng của tuần 1 +2 
Code khai thác chức năng gồm: View, procedure*/
-- SINH VIÊN XEM THÔNG TIN ĐỀ TÀI- GV - THỜI GIAN THỰC HIỆN --
CREATE VIEW SinhVien_ThongTinDeTai AS
SELECT 
	DT.MaHocPhan,
    DT.MaDeTai,
    GV.HoTen AS GiangVienHuongDan,
	GV.Email AS EmailGiangVien,
	GV.SdtGV AS SdtGiangVien,
	DT.TenDeTai,
	DT.MoTaChiTiet,
	DT.TrangThaiDeTai,
	DTSV.TGThucHien AS ThoiGianThucHien
FROM 
    TblDeTai DT
	INNER JOIN TblDeTai_SinhVien DTSV ON DT.MaDeTai = DTSV.MaDeTai
    INNER JOIN TblGiangVien GV ON DT.MaGiangVien = GV.MaGiangVien;

-- KIỂM THỬ VIEW SINH VIÊN XEM THÔNG TIN ĐỀ TÀI- GV - THỜI GIAN THỰC HIỆN --
SELECT * FROM SinhVien_ThongTinDeTai

-- SINH VIÊN XEM KẾT QUẢ BÁO CÁO -- 
CREATE VIEW KetQuaChamBaoCao AS
SELECT 
	DT.TenDeTai AS TenDeTai,
	GV.HoTen AS GiangVienHuongDan,
	GVT.HoTen AS GiangVienCham,
	SV.MSSV AS MSSV,
	SV.HoTenSV AS HoTenSinhVien,
	LOP.MaLop,
	LOP.TenLop,
	BC.Diem
FROM 
    TblChamBaoCao BC
INNER JOIN TblDeTai DT ON BC.MaDeTai = DT.MaDeTai
INNER JOIN TblGiangVien GV ON BC.MaGiangVien = GV.MaGiangVien
INNER JOIN TblGiangVien GVT ON BC.NguoiChamThu = GVT.MaGiangVien
INNER JOIN TblSinhVien SV ON BC.MSSV = SV.MSSV
INNER JOIN TblLop LOP ON SV.MaLop = LOP.MaLop

-- KIỂM THỬ VIEW SINH VIÊN XEM KẾT QUẢ BÁO CÁO -- 
SELECT * FROM KetQuaChamBaoCao

-- SINH VIÊN XEM KẾT QUẢ BÁO CÁO THEO MSSV --
CREATE PROCEDURE XemDiemTheoMSSV
    @MSSV VARCHAR(20),
	@MaDeTai VARCHAR(20)
AS
BEGIN
    -- Kiểm tra xem @MSSV có tồn tại trong bảng TblSinhVien không
    IF NOT EXISTS (SELECT 1 FROM TblSinhVien WHERE MSSV = @MSSV)
    BEGIN
        PRINT N'MSSV không tồn tại trong bảng TblSinhVien';
        RETURN;
    END
	DECLARE @TrangThaiDeTai VARCHAR(50);
	SELECT @TrangThaiDeTai = TrangThaiDeTai from TblDeTai_SinhVien 
	INNER JOIN TblDeTai ON TblDeTai_SinhVien.MaDeTai = TblDeTai.MaDeTai WHERE TblDeTai_SinhVien.MSSV = @MSSV AND TblDeTai_SinhVien.MaDeTai = @MaDeTai 
	IF NOT (@TrangThaiDeTai = 'Hoàn thành')
    BEGIN
        PRINT N'Sinh viên chưa hoàn thành đồ án';
        RETURN;
    END
	ELSE 
	BEGIN
		-- Thực hiện truy vấn chính nếu MSSV tồn tại
		SELECT 
			DT.TenDeTai AS TenDeTai,
			GV.HoTen AS GiangVienHuongDan,
			GVT.HoTen AS GiangVienCham,
			SV.MSSV AS MSSV,
			SV.HoTenSV AS HoTenSinhVien,
			LOP.MaLop,
			LOP.TenLop,
			BC.Diem
		FROM 
			TblChamBaoCao BC
		INNER JOIN TblDeTai DT ON BC.MaDeTai = DT.MaDeTai
		INNER JOIN TblGiangVien GV ON BC.MaGiangVien = GV.MaGiangVien
		INNER JOIN TblGiangVien GVT ON BC.NguoiChamThu = GVT.MaGiangVien
		INNER JOIN TblSinhVien SV ON BC.MSSV = SV.MSSV
		INNER JOIN TblLop LOP ON SV.MaLop = LOP.MaLop
		WHERE BC.MSSV = @MSSV AND BC.MaDeTai = @MaDeTai;
	END
END;

-- KIỂM THỬ PROCEDURE SINH VIÊN XEM KẾT QUẢ BÁO CÁO THEO MSSV -- 
EXEC XemDiemTheoMSSV  '110121266', 'CSN212'
EXEC XemDiemTheoMSSV  '110121266', 'CSNTC89'

-- GIÁNG VIÊN HƯỚNG DÂN ĐĂNG KÝ ĐỀ TÀI SINH VIÊN ĐỀ XUẤT -- 
CREATE PROCEDURE DangKyDeTai
	@MaHocPhan VARCHAR(20),
	@MaGiangVien VARCHAR(20),
	@TenDeTai NVARCHAR(150),
	@MoTaChiTiet NVARCHAR(1000),
	@TGThucHien datetime,
	@MSSV VARCHAR(20)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM TblSinhVien WHERE MSSV = @MSSV)
    BEGIN
        PRINT 'Mã số sinh viên không hợp lệ.';
        RETURN;
    END
	
	DECLARE @MADETAITEST VARCHAR(20);
	SELECT @MADETAITEST = MaDeTai FROM TblDeTai_SinhVien WHERE MSSV = @MSSV;
	IF EXISTS (SELECT 1 FROM TblDeTai WHERE MaDeTai = @MADETAITEST AND TrangThaiDeTai = 'Hoàn thành')
	BEGIN 
		DECLARE @MaDeTai VARCHAR(20)
		SET @MaDeTai = 'CSNTC' + CAST(FLOOR(RAND() * (76)) + 25 AS VARCHAR(2))
		INSERT INTO TblDeTai(MaDeTai, MaGiangVien,MaHocPhan, MoTaChiTiet, TenDeTai, TrangThaiDeTai) VALUES
		(@MaDeTai, @MaGiangVien,@MaHocPhan, @MoTaChiTiet, @TenDeTai,N'Đã đăng ký')
		-- Kiểm tra xem sinh viên đã đăng ký đề tài này chưa
		IF EXISTS (SELECT 1 FROM TblDeTai_SinhVien WHERE MSSV = @MSSV AND MaDeTai = @MaDeTai)
		BEGIN
			PRINT 'Sinh viên đã đăng ký đề tài này.';
			RETURN;
		END
		-- Thêm bản ghi vào bảng DeTai_SinhVien
		INSERT INTO TblDeTai_SinhVien (MSSV, MaDeTai, TGThucHien)
		VALUES (@MSSV, @MaDeTai, @TGThucHien);
		PRINT 'Đăng ký đề tài thành công.';
	END
	ELSE
	BEGIN
		PRINT N'Sinh viên đang thực hiện đề tài - không thể đăng ký thêm'
	END
END

-- KIỂM THỬ PROCEDURE GIÁNG VIÊN HƯỚNG DÂN ĐĂNG KÝ ĐỀ TÀI SINH VIÊN ĐỀ XUẤT --
EXEC DangKyDeTai '220265', 'DNVK', N'Đề tài tự chọn', N'Chủ đề này thêm vào để test procedure', '01/02/2024', '110121266'
select * from TblGiangVien where MaGiangVien = 'DNVK' 
select * from TblDeTai 
select * from TblDeTai_SinhVien

-- GIÁNG VIÊN XEM SINH VIÊN ĐĂNG KÝ ĐỀ TÀI CỦA GIÁO VIÊN --
CREATE PROCEDURE XemSinhVienDangKyDeTai
    @MaGiangVien VARCHAR(20)
AS
BEGIN
    SELECT 
        SV.MSSV,
        SV.HoTenSV AS HoTenSinhVien,
		SV.Email AS EmailSinhVien,
		SV.SdtSV AS SdtSinhVien,
        DT.MaDeTai,
        DT.TenDeTai,
        DT.MoTaChiTiet,
        DT.TrangThaiDeTai
    FROM 
        TblDeTai DT
    INNER JOIN TblDeTai_SinhVien DTSV ON DT.MaDeTai = DTSV.MaDeTai
    INNER JOIN TblSinhVien SV ON DTSV.MSSV = SV.MSSV
    WHERE 
        DT.MaGiangVien = @MaGiangVien
END

-- KIỂM THỬ PROCEDURE GIÁNG VIÊN XEM SINH VIÊN ĐĂNG KÝ ĐỀ TÀI CỦA GIÁO VIÊN --
EXEC XemSinhVienDangKyDeTai 'NBA'

-- SINH VIÊN XEM THÔNG TIN ĐỀ TÀI CỦA MÌNH-- 
CREATE PROCEDURE XemThongTinDeTai
    @MSSV VARCHAR(20)
AS
BEGIN
    SELECT 
        DT.MaDeTai,
        DT.TenDeTai,
        DT.MoTaChiTiet,
        GV.HoTen AS GiangVienHuongDan,
        DTSV.TGThucHien AS ThoiGianThucHien
    FROM 
        TblDeTai DT
    INNER JOIN TblDeTai_SinhVien DTSV ON DT.MaDeTai = DTSV.MaDeTai
    INNER JOIN TblGiangVien GV ON DT.MaGiangVien = GV.MaGiangVien
    WHERE 
        DTSV.MSSV = @MSSV;
END

-- KIỂM THỬ PROCEDURE SINH VIÊN XEM THÔNG TIN ĐỀ TÀI -- 
EXEC XemThongTinDeTai '110121269'

-- GIÁO VIÊN CHẤM ĐIỂM ĐỒ ÁN  --
CREATE PROCEDURE ChamDiem 
@MaDeTai VARCHAR(20), 
@MaGiangVienChamThu VARCHAR(20),
@DiemGVHD FLOAT, 
@DiemGVCT FLOAT
AS
BEGIN
    IF @DiemGVHD < 0 OR @DiemGVHD > 10
    BEGIN
        PRINT N'Điểm GVHD phải nằm trong khoảng 0 -> 10';
        RETURN;
    END
    IF @DiemGVCT < 0 OR @DiemGVCT > 10
    BEGIN
        PRINT N'Điểm GVCT phải nằm trong khoảng 0 -> 10';
        RETURN;
    END

    DECLARE @MSSV VARCHAR(20);
    DECLARE @MaGVHD VARCHAR(20);
    DECLARE @Diem FLOAT;

    SELECT @MSSV = MSSV FROM TblDeTai_SinhVien WHERE MaDeTai = @MaDeTai;
    IF @MSSV IS NULL
    BEGIN
        PRINT N'Không tìm thấy MSSV cho MaDeTai này trong bảng TblDeTai_SinhVien';
        RETURN;
    END

    SELECT @MaGVHD = MaGiangVien FROM TblDeTai WHERE MaDeTai = @MaDeTai;
    IF @MaGVHD IS NULL
    BEGIN
        PRINT N'Không tìm thấy MaGVHD cho MaDeTai này trong bảng TblDeTai';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM TblGiangVien WHERE MaGiangVien = @MaGiangVienChamThu)
    BEGIN
        PRINT N'Không tìm thấy MaGiangVienChamThu trong bảng TblGiangVien';
        RETURN;
    END

    SET @Diem = (@diemGVCT + @DiemGVHD) / 2;

    IF EXISTS (SELECT 1 FROM TblChamBaoCao WHERE MaDeTai = @MaDeTai AND MaGiangVien = @MaGVHD)
    BEGIN
        -- Nếu tồn tại, cập nhật bản ghi
        UPDATE TblChamBaoCao
        SET Diem = @Diem, NguoiChamThu = @MaGiangVienChamThu
        WHERE MaDeTai = @MaDeTai AND MaGiangVien = @MaGVHD;

        PRINT N'Chấm điểm thành công - Đã cập nhật bản ghi hiện có';
    END
    ELSE
    BEGIN
        -- Nếu không tồn tại, chèn bản ghi mới
        INSERT INTO TblChamBaoCao (MaDeTai, MaGiangVien, MSSV, Diem, NguoiChamThu)
        VALUES (@MaDeTai, @MaGVHD, @MSSV, @Diem, @MaGiangVienChamThu);

        PRINT N'Chấm điểm thành công - Đã thêm bản ghi mới';
		UPDATE TblDeTai
		SET TrangThaiDeTai = N'Hoàn thành'
		WHERE MaDeTai = @MaDeTai;
    END
END;

-- KIỂM THỬ PROCEDURE GIÁO VIÊN CHẤM ĐIỂM ĐỒ ÁN --
EXEC ChamDiem 'CSNTC89', 'NNL', 8, 10
select * from TblChamBaoCao WHERE MaDeTai = 'CSNTC89'

/* 
TRIGGER ĐỂ KIỂM TRA VÀ CẬP NHẬT TRẠNG THÁI ĐỀ TÀI KHI SINH VIÊN HOÀN THÀNH
Trigger này sẽ tự động cập nhật trạng thái của đề tài khi điểm báo cáo của sinh viên được cập nhật trong bảng TblChamBaoCao
*/
CREATE TRIGGER trg_Update_TrangThaiDeTai
ON TblChamBaoCao
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaDeTai VARCHAR(20);
    DECLARE @MSSV VARCHAR(20);
    DECLARE @Diem FLOAT;

    SELECT @MaDeTai = inserted.MaDeTai, 
           @MSSV = inserted.MSSV, 
           @Diem = inserted.Diem
    FROM inserted;

    -- Cập nhật trạng thái đề tài thành "Hoàn thành" nếu điểm >= 5
    IF @Diem >= 5
    BEGIN
        UPDATE TblDeTai
        SET TrangThaiDeTai = N'Hoàn thành'
        WHERE MaDeTai = @MaDeTai;
    END
END;

/*
TRIGGER ĐỂ GHI NHẬT KÝ KHI ĐIỂM BÁO CÁO ĐƯỢC CẬP NHẬT
Trigger này sẽ ghi lại lịch sử cập nhật điểm báo cáo của sinh viên vào bảng log để theo dõi.
*/
CREATE TABLE TblLogDiemBaoCao (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    MaDeTai VARCHAR(20),
    MSSV VARCHAR(20),
    MaGiangVien VARCHAR(20),
    Diem FLOAT,
    NguoiChamThu VARCHAR(20),
    ThoiGianCapNhat DATETIME
);

CREATE TRIGGER trg_Log_UpdateDiemBaoCao
ON TblChamBaoCao
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaDeTai VARCHAR(20);
    DECLARE @MSSV VARCHAR(20);
    DECLARE @MaGiangVien VARCHAR(20);
    DECLARE @Diem FLOAT;
    DECLARE @NguoiChamThu VARCHAR(20);

    SELECT @MaDeTai = inserted.MaDeTai,
           @MSSV = inserted.MSSV,
           @MaGiangVien = inserted.MaGiangVien,
           @Diem = inserted.Diem,
           @NguoiChamThu = inserted.NguoiChamThu
    FROM inserted;

    INSERT INTO TblLogDiemBaoCao (MaDeTai, MSSV, MaGiangVien, Diem, NguoiChamThu, ThoiGianCapNhat)
    VALUES (@MaDeTai, @MSSV, @MaGiangVien, @Diem, @NguoiChamThu, GETDATE());
END;

/*
TRIGGER ĐỂ KIỂM TRA VÀ NGĂN VIỆC ĐĂNG KÝ ĐỀ TÀI TRÙNG LẶP
Trigger này sẽ ngăn không cho sinh viên đăng ký trùng lặp đề tài đã hoàn thành hoặc đang thực hiện.
*/
CREATE TRIGGER trg_Check_DuplicateRegistration
ON TblDeTai_SinhVien
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @MSSV VARCHAR(20);
    DECLARE @MaDeTai VARCHAR(20);
    DECLARE @TrangThaiDeTai VARCHAR(50);

    SELECT @MSSV = inserted.MSSV, 
           @MaDeTai = inserted.MaDeTai
    FROM inserted;

    -- Kiểm tra trạng thái đề tài
    SELECT @TrangThaiDeTai = TrangThaiDeTai 
    FROM TblDeTai 
    WHERE MaDeTai = @MaDeTai;

    IF @TrangThaiDeTai IN (N'Hoàn thành', N'Đang thực hiện')
    BEGIN
        RAISERROR (N'Sinh viên đã đăng ký đề tài hoặc đề tài đã hoàn thành', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO TblDeTai_SinhVien (MSSV, MaDeTai, TGThucHien)
        SELECT MSSV, MaDeTai, TGThucHien
        FROM inserted;
    END
END;

/*
TRIGGER ĐỂ KIỂM TRA TRƯỚC KHI XÓA GIẢNG VIÊN
Trigger này ngăn không cho xóa giảng viên nếu giảng viên đang hướng dẫn đề tài nào đó.
*/
CREATE TRIGGER trg_Prevent_DeleteGiangVien
ON TblGiangVien
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @MaGiangVien VARCHAR(20);

    SELECT @MaGiangVien = deleted.MaGiangVien 
    FROM deleted;

    IF EXISTS (SELECT 1 FROM TblDeTai WHERE MaGiangVien = @MaGiangVien)
    BEGIN
        RAISERROR (N'Không thể xóa giảng viên đang hướng dẫn đề tài.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM TblGiangVien
        WHERE MaGiangVien = @MaGiangVien;
    END
END;

-- Tạo login cho người dùng - Sử dụng thủ tục lưu trữ
exec sp_addlogin 'Quantri',   '123456',  'HTQL_DACSN' 
exec sp_addlogin 'Giangvien', '123456',  'HTQL_DACSN'
exec sp_addlogin 'Sinhvien',  '123456',  'HTQL_DACSN'

-- tạo người dùng với hai quyền admin và user để so sánh quyền truy cập vào cơ sở dữ liệu
-- quyền admin
	create user Quantri_admin for login Quantri
-- quyền user
	create user Giangvien_user for login Giangvien
	create user Sinhvien_user for login Sinhvien

-- Gán quyền admin cho Quantri
ALTER ROLE db_owner ADD MEMBER Quantri_admin;

-- Gán quyền cho Giangvien_user
GRANT SELECT, INSERT, UPDATE, DELETE ON TblDeTai TO Giangvien_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TblDeTai_SinhVien TO Giangvien_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TblGiangVien TO Giangvien_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TblChamBaoCao TO Giangvien_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TblSinhVien TO Giangvien_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TblLop TO Giangvien_user;

-- Gán quyền thực thi các thủ tục lưu trữ
GRANT EXECUTE ON XemSinhVienDangKyDeTai TO Giangvien_user;
GRANT EXECUTE ON ChamDiem TO Giangvien_user;
GRANT EXECUTE ON DangKyDeTai TO Giangvien_user;

-- Gán quyền cho Sinhvien_user
GRANT SELECT ON TblDeTai TO Sinhvien_user;
GRANT SELECT ON TblDeTai_SinhVien TO Sinhvien_user;
GRANT SELECT ON TblGiangVien TO Sinhvien_user;
GRANT SELECT ON TblChamBaoCao TO Sinhvien_user;
GRANT SELECT ON TblSinhVien TO Sinhvien_user;
GRANT SELECT ON TblLop TO Sinhvien_user;

-- Gán quyền thực thi các thủ tục lưu trữ
GRANT EXECUTE ON XemDiemTheoMSSV TO Sinhvien_user;
GRANT EXECUTE ON XemThongTinDeTai TO Sinhvien_user;


