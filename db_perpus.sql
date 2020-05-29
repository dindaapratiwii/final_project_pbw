-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2020 at 04:02 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_perpus`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_buku`
--

CREATE TABLE `tb_buku` (
  `id_buku` varchar(50) NOT NULL,
  `id_kategori` int(10) UNSIGNED NOT NULL,
  `id_pengarang` int(10) UNSIGNED NOT NULL,
  `id_penerbit` int(10) UNSIGNED NOT NULL,
  `id_rak` int(10) UNSIGNED NOT NULL,
  `judul_buku` varchar(50) NOT NULL,
  `gambar_buku` varchar(50) NOT NULL,
  `tahun_buku` int(10) UNSIGNED NOT NULL,
  `stok_buku` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_buku`
--

INSERT INTO `tb_buku` (`id_buku`, `id_kategori`, `id_pengarang`, `id_penerbit`, `id_rak`, `judul_buku`, `gambar_buku`, `tahun_buku`, `stok_buku`, `created_at`, `updated_at`) VALUES
('BK/2020/00001', 1, 57, 10, 2, 'Semua Bisa Menjadi Programmer Python Case Study', '5ed112e73a09b.jpg', 2020, 5, '2020-05-29 21:49:27', '2020-05-29 21:49:27'),
('BK/2020/00002', 1, 55, 10, 3, '5 Pemrograman Dasar Desain Website', '5ed11320c5100.jpg', 2019, 2, '2020-05-29 21:50:24', '2020-05-29 21:50:24'),
('BK/2020/00003', 1, 55, 9, 4, 'Java, Referensi Lengkap Untuk Programer', '5ed113546d912.jpg', 2019, 1, '2020-05-29 21:51:16', '2020-05-29 21:51:16');

-- --------------------------------------------------------

--
-- Table structure for table `tb_kategori`
--

CREATE TABLE `tb_kategori` (
  `id_kategori` int(10) UNSIGNED NOT NULL,
  `nama_kategori` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_kategori`
--

INSERT INTO `tb_kategori` (`id_kategori`, `nama_kategori`, `created_at`, `updated_at`) VALUES
(1, 'Teknologi Informasi', '2020-05-25 15:08:05', '2020-05-25 16:09:38'),
(2, 'Kesehatan', '2020-05-25 15:08:05', '2020-05-25 15:08:05'),
(4, 'Lingkungan', '2020-05-25 16:31:42', '2020-05-25 16:31:42'),
(6, 'Hukum', '2020-05-25 16:34:25', '2020-05-25 16:34:25'),
(7, 'Teknik', '2020-05-25 16:36:13', '2020-05-25 16:36:13'),
(8, 'Musik', '2020-05-25 16:36:39', '2020-05-25 16:36:39'),
(14, 'Agama', '2020-05-25 16:44:46', '2020-05-25 16:44:46'),
(53, 'Sejarah', '2020-05-25 20:34:29', '2020-05-25 20:34:29'),
(79, 'Petualangan', '2020-05-25 21:02:32', '2020-05-25 21:02:32'),
(132, '', '2020-05-26 08:56:14', '2020-05-28 09:28:21');

-- --------------------------------------------------------

--
-- Table structure for table `tb_peminjaman`
--

CREATE TABLE `tb_peminjaman` (
  `id_peminjaman` varchar(50) NOT NULL,
  `id_user` int(10) UNSIGNED NOT NULL,
  `status` enum('0','1','2') NOT NULL DEFAULT '0',
  `due_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_peminjaman`
--

INSERT INTO `tb_peminjaman` (`id_peminjaman`, `id_user`, `status`, `due_date`, `created_at`, `updated_at`) VALUES
('TRK/2020/00001', 22, '0', '2020-05-29 13:56:00', '2020-05-29 13:58:57', '2020-05-29 21:58:57');

-- --------------------------------------------------------

--
-- Table structure for table `tb_peminjaman_detail`
--

CREATE TABLE `tb_peminjaman_detail` (
  `id_peminjaman_detail` int(11) NOT NULL,
  `id_peminjaman` varchar(50) NOT NULL,
  `id_buku` varchar(50) NOT NULL,
  `amount` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_peminjaman_detail`
--

INSERT INTO `tb_peminjaman_detail` (`id_peminjaman_detail`, `id_peminjaman`, `id_buku`, `amount`, `created_at`, `updated_at`) VALUES
(42, 'TRK/2020/00001', 'BK/2020/00003', 1, '2020-05-29 21:58:57', '2020-05-29 21:58:57');

-- --------------------------------------------------------

--
-- Table structure for table `tb_penerbit`
--

CREATE TABLE `tb_penerbit` (
  `id_penerbit` int(10) UNSIGNED NOT NULL,
  `nama_penerbit` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_penerbit`
--

INSERT INTO `tb_penerbit` (`id_penerbit`, `nama_penerbit`, `created_at`, `updated_at`) VALUES
(9, 'Andi Offset', '2020-05-25 17:41:26', '2020-05-29 13:47:07'),
(10, 'Elexmedia Komputindo', '2020-05-25 17:41:33', '2020-05-29 13:46:24'),
(12, 'Gramedia Widiasarana Indonesia ', '2020-05-25 17:41:58', '2020-05-29 13:47:21'),
(70, 'Penerbit Baru', '2020-05-25 20:34:58', '2020-05-25 20:34:58');

-- --------------------------------------------------------

--
-- Table structure for table `tb_pengarang`
--

CREATE TABLE `tb_pengarang` (
  `id_pengarang` int(10) UNSIGNED NOT NULL,
  `nama_pengarang` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_pengarang`
--

INSERT INTO `tb_pengarang` (`id_pengarang`, `nama_pengarang`, `created_at`, `updated_at`) VALUES
(55, 'R.h. Sianipar', '2020-05-29 13:48:02', '2020-05-29 13:48:02'),
(56, 'Jubilee Enterprise', '2020-05-29 13:48:11', '2020-05-29 13:48:11'),
(57, 'YUNIAR SUPARDI & DR.(CD) DEDE, S.KOM., M.KOM', '2020-05-29 13:48:24', '2020-05-29 13:48:24');

-- --------------------------------------------------------

--
-- Table structure for table `tb_pengembalian`
--

CREATE TABLE `tb_pengembalian` (
  `id_pengembalian` int(50) UNSIGNED NOT NULL,
  `id_peminjaman` varchar(50) CHARACTER SET utf8 NOT NULL,
  `tanggal_kembali` date NOT NULL,
  `ketepatan` enum('0','1') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_permissions`
--

CREATE TABLE `tb_permissions` (
  `id_permission` int(10) UNSIGNED NOT NULL,
  `name_permission` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_permissions`
--

INSERT INTO `tb_permissions` (`id_permission`, `name_permission`) VALUES
(1, 'create_user'),
(2, 'read_user'),
(3, 'update_user'),
(4, 'delete_user'),
(5, 'menu_data'),
(6, 'submenu_data_user'),
(7, 'create_kategori'),
(8, 'read_kategori'),
(9, 'update_kategori'),
(10, 'delete_kategori'),
(11, 'create_penerbit'),
(12, 'read_penerbit'),
(13, 'update_penerbit'),
(14, 'delete_penerbit'),
(15, 'create_pengarang'),
(16, 'read_pengarang'),
(17, 'update_pengarang'),
(18, 'delete_pengarang'),
(19, 'submenu_data_kategori'),
(20, 'submenu_data_penerbit'),
(21, 'submenu_data_pengarang'),
(22, 'create_buku'),
(23, 'read_buku'),
(24, 'update_buku'),
(25, 'delete_buku'),
(26, 'submenu_data_buku'),
(27, 'create_rak'),
(28, 'read_rak'),
(29, 'update_rak'),
(30, 'delete_rak'),
(31, 'submenu_data_rak'),
(32, 'update_profile'),
(33, 'menu_transaksi'),
(34, 'submenu_transaksi_peminjaman'),
(35, 'create_peminjaman'),
(36, 'read_peminjaman'),
(37, 'update_peminjaman'),
(38, 'delete_peminjaman'),
(39, 'cek_status'),
(40, 'submenu_transaksi_pengembalian'),
(41, 'create_pengembalian'),
(42, 'read_pengembalian'),
(43, 'update_pengembalian'),
(44, 'delete_pengembalian');

-- --------------------------------------------------------

--
-- Table structure for table `tb_rak`
--

CREATE TABLE `tb_rak` (
  `id_rak` int(10) UNSIGNED NOT NULL,
  `nama_rak` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_rak`
--

INSERT INTO `tb_rak` (`id_rak`, `nama_rak`, `created_at`, `updated_at`) VALUES
(2, 'Rak A', '2020-05-26 12:50:14', '2020-05-26 12:50:14'),
(3, 'Rak B', '2020-05-26 13:18:09', '2020-05-26 13:18:09'),
(4, 'Rak C', '2020-05-26 13:18:14', '2020-05-26 13:18:14'),
(5, 'Rak D', '2020-05-26 13:18:18', '2020-05-26 13:18:18'),
(6, 'Rak E', '2020-05-26 13:18:23', '2020-05-26 13:18:23'),
(7, 'Rak F', '2020-05-26 13:18:28', '2020-05-26 13:18:28');

-- --------------------------------------------------------

--
-- Table structure for table `tb_rules`
--

CREATE TABLE `tb_rules` (
  `id_rule` int(10) UNSIGNED NOT NULL,
  `name_rule` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_rules`
--

INSERT INTO `tb_rules` (`id_rule`, `name_rule`) VALUES
(1, 'superadmin'),
(2, 'admin'),
(3, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `tb_rule_permission`
--

CREATE TABLE `tb_rule_permission` (
  `id_rule` int(10) UNSIGNED NOT NULL,
  `id_permission` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_rule_permission`
--

INSERT INTO `tb_rule_permission` (`id_rule`, `id_permission`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 5),
(2, 19),
(2, 20),
(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(2, 30),
(2, 31),
(3, 32),
(2, 33),
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(2, 38),
(3, 33),
(3, 34),
(3, 35),
(3, 36),
(3, 37),
(3, 39),
(3, 23),
(3, 26),
(3, 5),
(2, 40),
(2, 41),
(2, 42),
(2, 43),
(2, 44);

-- --------------------------------------------------------

--
-- Table structure for table `tb_users`
--

CREATE TABLE `tb_users` (
  `id_user` int(10) UNSIGNED NOT NULL,
  `id_rule` int(10) UNSIGNED NOT NULL,
  `name` varchar(35) COLLATE utf8_bin NOT NULL,
  `username` varchar(20) COLLATE utf8_bin NOT NULL,
  `password` text COLLATE utf8_bin NOT NULL,
  `status` enum('0','1') COLLATE utf8_bin NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `tb_users`
--

INSERT INTO `tb_users` (`id_user`, `id_rule`, `name`, `username`, `password`, `status`, `created_at`, `updated_at`) VALUES
(4, 1, 'Super Admin', 'superadmin', 'ac497cfaba23c4184cb03b97e8c51e0a', '1', '2020-05-24 10:23:06', '2020-05-29 10:52:44'),
(14, 2, 'Admin User', 'adminadmin', 'f5bb0c8de146c67b44babbf4e6584cc0', '1', '2020-05-25 11:53:40', '2020-05-29 10:53:13'),
(22, 3, 'pengguna', 'pengguna', 'f5bb0c8de146c67b44babbf4e6584cc0', '1', '2020-05-29 12:15:24', '2020-05-29 12:15:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_buku`
--
ALTER TABLE `tb_buku`
  ADD PRIMARY KEY (`id_buku`),
  ADD KEY `id_kategori` (`id_kategori`,`id_pengarang`,`id_penerbit`,`id_rak`),
  ADD KEY `tb_buku_ibfk_2` (`id_penerbit`),
  ADD KEY `tb_buku_ibfk_3` (`id_pengarang`),
  ADD KEY `tb_buku_ibfk_4` (`id_rak`);

--
-- Indexes for table `tb_kategori`
--
ALTER TABLE `tb_kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `tb_peminjaman`
--
ALTER TABLE `tb_peminjaman`
  ADD PRIMARY KEY (`id_peminjaman`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `tb_peminjaman_detail`
--
ALTER TABLE `tb_peminjaman_detail`
  ADD PRIMARY KEY (`id_peminjaman_detail`),
  ADD KEY `id_peminjaman` (`id_peminjaman`),
  ADD KEY `id_buku` (`id_buku`);

--
-- Indexes for table `tb_penerbit`
--
ALTER TABLE `tb_penerbit`
  ADD PRIMARY KEY (`id_penerbit`);

--
-- Indexes for table `tb_pengarang`
--
ALTER TABLE `tb_pengarang`
  ADD PRIMARY KEY (`id_pengarang`);

--
-- Indexes for table `tb_pengembalian`
--
ALTER TABLE `tb_pengembalian`
  ADD PRIMARY KEY (`id_pengembalian`),
  ADD KEY `id_peminjaman` (`id_peminjaman`);

--
-- Indexes for table `tb_permissions`
--
ALTER TABLE `tb_permissions`
  ADD PRIMARY KEY (`id_permission`);

--
-- Indexes for table `tb_rak`
--
ALTER TABLE `tb_rak`
  ADD PRIMARY KEY (`id_rak`);

--
-- Indexes for table `tb_rules`
--
ALTER TABLE `tb_rules`
  ADD PRIMARY KEY (`id_rule`);

--
-- Indexes for table `tb_rule_permission`
--
ALTER TABLE `tb_rule_permission`
  ADD KEY `id_rule` (`id_rule`),
  ADD KEY `id_permission` (`id_permission`) USING BTREE;

--
-- Indexes for table `tb_users`
--
ALTER TABLE `tb_users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `id_rule` (`id_rule`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_kategori`
--
ALTER TABLE `tb_kategori`
  MODIFY `id_kategori` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `tb_peminjaman_detail`
--
ALTER TABLE `tb_peminjaman_detail`
  MODIFY `id_peminjaman_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `tb_penerbit`
--
ALTER TABLE `tb_penerbit`
  MODIFY `id_penerbit` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `tb_pengarang`
--
ALTER TABLE `tb_pengarang`
  MODIFY `id_pengarang` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `tb_pengembalian`
--
ALTER TABLE `tb_pengembalian`
  MODIFY `id_pengembalian` int(50) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `tb_permissions`
--
ALTER TABLE `tb_permissions`
  MODIFY `id_permission` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `tb_rak`
--
ALTER TABLE `tb_rak`
  MODIFY `id_rak` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tb_rules`
--
ALTER TABLE `tb_rules`
  MODIFY `id_rule` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_users`
--
ALTER TABLE `tb_users`
  MODIFY `id_user` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tb_buku`
--
ALTER TABLE `tb_buku`
  ADD CONSTRAINT `tb_buku_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `tb_kategori` (`id_kategori`),
  ADD CONSTRAINT `tb_buku_ibfk_2` FOREIGN KEY (`id_penerbit`) REFERENCES `tb_penerbit` (`id_penerbit`),
  ADD CONSTRAINT `tb_buku_ibfk_3` FOREIGN KEY (`id_pengarang`) REFERENCES `tb_pengarang` (`id_pengarang`),
  ADD CONSTRAINT `tb_buku_ibfk_4` FOREIGN KEY (`id_rak`) REFERENCES `tb_rak` (`id_rak`);

--
-- Constraints for table `tb_peminjaman`
--
ALTER TABLE `tb_peminjaman`
  ADD CONSTRAINT `tb_peminjaman_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `tb_users` (`id_user`);

--
-- Constraints for table `tb_peminjaman_detail`
--
ALTER TABLE `tb_peminjaman_detail`
  ADD CONSTRAINT `tb_peminjaman_detail_ibfk_1` FOREIGN KEY (`id_peminjaman`) REFERENCES `tb_peminjaman` (`id_peminjaman`),
  ADD CONSTRAINT `tb_peminjaman_detail_ibfk_2` FOREIGN KEY (`id_buku`) REFERENCES `tb_buku` (`id_buku`);

--
-- Constraints for table `tb_pengembalian`
--
ALTER TABLE `tb_pengembalian`
  ADD CONSTRAINT `tb_pengembalian_ibfk_1` FOREIGN KEY (`id_peminjaman`) REFERENCES `tb_peminjaman` (`id_peminjaman`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tb_rule_permission`
--
ALTER TABLE `tb_rule_permission`
  ADD CONSTRAINT `tb_rule_permission_ibfk_1` FOREIGN KEY (`id_permission`) REFERENCES `tb_permissions` (`id_permission`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb_rule_permission_ibfk_2` FOREIGN KEY (`id_rule`) REFERENCES `tb_rules` (`id_rule`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tb_users`
--
ALTER TABLE `tb_users`
  ADD CONSTRAINT `tb_users_ibfk_1` FOREIGN KEY (`id_rule`) REFERENCES `tb_rules` (`id_rule`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
