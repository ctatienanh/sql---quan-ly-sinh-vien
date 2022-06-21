create database qldsv;
use qldsv;
create table khoa(
makhoa int primary key,
ten varchar (250)
);
create table lop(
malop int primary key,
tenlop varchar(250),
makhoa int,
foreign key (makhoa) references khoa(makhoa)
);
create table sinhvien(
masv int primary key,
hoten varchar(250) ,
ngaysinh date,
hocbong varchar(250),
gioitinh varchar(250),
malop int,
foreign key (malop) references lop(malop)
);
create table monhoc(
idmonhoc int primary key,
tenmh varchar(250),
sotiet varchar(250)
);
create table ketqua(
diemthi int,
masv int,
idmonhoc int,
foreign key(masv) references sinhvien(masv),
foreign key(idmonhoc) references monhoc(idmonhoc)
);

alter table ketqua 
add primary key (diemthi,masv);

select * from sinhvien where hoten like 'tran%';
select * from sinhvien where year(ngaysinh) between 1978 and 1985 ;
select hoten from sinhvien where hocbong is not null and gioitinh ='nu';
select * from sinhvien  order  by  masv ; 

-- vd12 va vd13
select hoten, tenlop, ten  from sinhvien as sv
join lop  on sv.malop = lop.malop
join khoa on lop.makhoa = khoa.makhoa;


-- cau 14
select lop.malop,tenlop , count(hoten) as sl from lop 
join sinhvien as sv on sv.malop = lop.malop
group by tenlop ;

-- cau15
select khoa.makhoa , ten, count(hoten) as "so luong" from sinhvien as sv
join lop on sv.malop = lop.malop
join khoa on lop.makhoa = khoa.makhoa
group by ten;

-- cau 16
select khoa.makhoa , ten, count(gioitinh) as "so luong sinh vien nu" from sinhvien as sv
join lop on sv.malop = lop.malop
join khoa on lop.makhoa = khoa.makhoa
where gioitinh="nu"
group by ten;

-- cau 17
select tenlop, sum(tienhocbong) as "tong tien hoc bong" from lop
join sinhvien as sv  on sv.malop = lop.malop 
group by tenlop; 

-- cau 18
select ten, sum(tienhocbong) as "tong tien hoc bong" from lop
join sinhvien as sv  on sv.malop = lop.malop 
join khoa as k on lop.makhoa = k.makhoa
group by ten;

-- cau19
select k.makhoa, ten as "ten khoa" , count(hoten) as "so luong hoc sinh cua khoa " 
from khoa as k
 join lop on k.makhoa = lop.makhoa
 join sinhvien as sv on sv.malop = lop.malop
 group by ten
 having count(hoten) >1;
 
 -- cau20
 select k.makhoa, ten as "ten khoa" , count(gioitinh) as "so luong hoc sinh cua khoa " 
from khoa as k
 join lop on k.makhoa = lop.makhoa
 join sinhvien as sv on sv.malop = lop.malop
 where gioitinh = "nu"
 group by ten;