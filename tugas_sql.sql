CREATE DATABASE practice;

-- one to one
CREATE TABLE pengguna(
id_user int generated always as identity not null,
nama_user varchar(255),
tempat_tinggal varchar(255),
PRIMARY KEY(id_user)
);

INSERT INTO pengguna(nama_user, tempat_tinggal) VALUES 
('Alvienas', 'Bekasi'),
('Maman', 'Sukabumi'),
('Yandika','Cianjur')
;

SELECT * FROM pengguna;

CREATE TABLE rekening(
no_rekening int not null,
nama_rekening varchar(255),
jumlah_saldo bigint,
id int,
PRIMARY KEY(no_rekening),
FOREIGN KEY (id) REFERENCES pengguna(id_user)
);

INSERT INTO rekening (no_rekening, nama_rekening, jumlah_saldo, id) VALUES 
(2132212, 'BCA', 12000000, 1),
(3212031, 'Mandiri', 20102300, 2),
(5635588,'BNI', 30123322, 3)
;

UPDATE rekening
SET nama_rekening = 'BCA'
WHERE no_rekening = 3212031;

UPDATE rekening
SET nama_rekening = 'BCA'
WHERE no_rekening = 5635588;

SELECT rekening.*, pengguna.nama_user AS Nasabah FROM rekening join pengguna ON rekening.id = pengguna.id_user;






-- one to many
CREATE TABLE barang(
id_barang int primary key not null,
nama_barang varchar(255),
harga_barang int
);

CREATE TABLE pembeli(
id_pembeli int primary key not null,
nama_pembeli varchar(255),
no_telp int,
barang_id int,
FOREIGN KEY (barang_id) REFERENCES barang(id_barang)
);

INSERT INTO barang(id_barang, nama_barang, harga_barang) VALUES 
(1, 'Gunting Rumput', 45000),
(2, 'Panci', 215000),
(3,'Gergaji Besi',35000);

INSERT INTO pembeli(id_pembeli, nama_pembeli, no_telp, barang_id) VALUES 
(1, 'Joko Widodo', 0812371232, 1),
(2, 'Prabowo Subianto', 0873676321, 2),
(3,'Mahfud MD',0812787198, 3);

SELECT pembeli.*, barang.nama_barang AS Barang FROM pembeli join barang ON pembeli.barang_id = barang.id_barang;


-- many to many

CREATE TABLE penumpang (
    id_penumpang int generated always as identity not null,
    nama_penumpang varchar(255),
    no_telepon int,
    PRIMARY KEY(id_penumpang)
    );


CREATE TABLE driver (
    plat_nomer varchar(255) not null,
    nama_driver varchar(255) not null,
    no_telepon int not null,
    PRIMARY KEY(plat_nomer)
    );

CREATE TABLE pembayaran (
    id_pembayaran int generated always as identity not null,
    jenis_pembayaran varchar(255) not null,
    harga int,
    penumpang_id int not null,
    plat_nomer varchar(255) not null,
    PRIMARY KEY(id_pembayaran),
    FOREIGN KEY (penumpang_id) REFERENCES penumpang(id_penumpang),
    FOREIGN KEY (plat_nomer) REFERENCES driver(plat_nomer)
    );

INSERT INTO penumpang(nama_penumpang, no_telepon) VALUES 
('Bambang Pamungkas', 0812371232),
('Boaz Solossa', 0873676321),
('Victor Igbonefo', 0812787198);

INSERT INTO driver(plat_nomer, nama_driver, no_telepon) VALUES 
('B 3434 ND', 'Mamat Alkatiri', 0823232314),
('F 2211 DY', 'Raditya Dika', 0812876889),
('B 2000 YN', 'Ernest Prakasa', 0856287902);

INSERT INTO pembayaran(jenis_pembayaran, harga, penumpang_id, plat_nomer) VALUES 
('Cash', 150000, 1, 'B 3434 ND'),
('E-Wallet', 29000, 2, 'F 2211 DY'),
('E-Wallet', 32500, 3, 'B 2000 YN');


SELECT pembayaran.jenis_pembayaran, pembayaran.harga, penumpang.nama_penumpang AS Penumpang, driver.nama_driver AS driver FROM pembayaran join penumpang ON pembayaran.penumpang_id = penumpang.id_penumpang 
JOIN driver ON pembayaran.plat_nomer = driver.plat_nomer;