USE [master]
GO
/****** Object:  Database [dbsistemaasp]    Script Date: 5/9/2021 19:08:13 ******/
CREATE DATABASE [dbsistemaasp]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbsistemaasp', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbsistemaasp.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbsistemaasp_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\dbsistemaasp_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [dbsistemaasp] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbsistemaasp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbsistemaasp] SET ANSI_NULL_DEFAULT ON 
GO
ALTER DATABASE [dbsistemaasp] SET ANSI_NULLS ON 
GO
ALTER DATABASE [dbsistemaasp] SET ANSI_PADDING ON 
GO
ALTER DATABASE [dbsistemaasp] SET ANSI_WARNINGS ON 
GO
ALTER DATABASE [dbsistemaasp] SET ARITHABORT ON 
GO
ALTER DATABASE [dbsistemaasp] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbsistemaasp] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbsistemaasp] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbsistemaasp] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbsistemaasp] SET CURSOR_DEFAULT  LOCAL 
GO
ALTER DATABASE [dbsistemaasp] SET CONCAT_NULL_YIELDS_NULL ON 
GO
ALTER DATABASE [dbsistemaasp] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbsistemaasp] SET QUOTED_IDENTIFIER ON 
GO
ALTER DATABASE [dbsistemaasp] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbsistemaasp] SET  DISABLE_BROKER 
GO
ALTER DATABASE [dbsistemaasp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbsistemaasp] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbsistemaasp] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbsistemaasp] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbsistemaasp] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbsistemaasp] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbsistemaasp] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbsistemaasp] SET RECOVERY FULL 
GO
ALTER DATABASE [dbsistemaasp] SET  MULTI_USER 
GO
ALTER DATABASE [dbsistemaasp] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbsistemaasp] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbsistemaasp] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbsistemaasp] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbsistemaasp] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbsistemaasp] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [dbsistemaasp] SET QUERY_STORE = OFF
GO
USE [dbsistemaasp]
GO
/****** Object:  Table [dbo].[articulo]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[articulo](
	[idarticulo] [int] IDENTITY(1,1) NOT NULL,
	[idcategoria] [int] NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[precio_venta] [decimal](11, 2) NOT NULL,
	[stock] [int] NOT NULL,
	[descripcion] [varchar](256) NULL,
	[condicion] [bit] NULL,
 CONSTRAINT [PK__articulo__BCE2F8F7A868B63A] PRIMARY KEY CLUSTERED 
(
	[idarticulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categoria]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[idcategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[descripcion] [varchar](256) NULL,
	[condicion] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idcategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_ingreso]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_ingreso](
	[iddetalle_ingreso] [int] IDENTITY(1,1) NOT NULL,
	[idingreso] [int] NOT NULL,
	[idarticulo] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio] [decimal](11, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iddetalle_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_venta]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_venta](
	[iddetalle_venta] [int] IDENTITY(1,1) NOT NULL,
	[idventa] [int] NOT NULL,
	[idarticulo] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio] [decimal](11, 2) NOT NULL,
	[descuento] [decimal](11, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[iddetalle_venta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ingreso]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ingreso](
	[idingreso] [int] IDENTITY(1,1) NOT NULL,
	[idproveedor] [int] NOT NULL,
	[idusuario] [int] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[num_comprobante] [varchar](10) NOT NULL,
	[fecha_hora] [datetime] NOT NULL,
	[impuesto] [decimal](4, 2) NOT NULL,
	[total] [decimal](11, 2) NOT NULL,
	[estado] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[persona]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[persona](
	[idpersona] [int] IDENTITY(1,1) NOT NULL,
	[tipo_persona] [varchar](20) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[tipo_documento] [varchar](20) NULL,
	[num_documento] [varchar](20) NULL,
	[direccion] [varchar](70) NULL,
	[telefono] [varchar](20) NULL,
	[email] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[idpersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rol]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rol](
	[idrol] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](30) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[condicion] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idrol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[idusuario] [int] IDENTITY(1,1) NOT NULL,
	[idrol] [int] NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[tipo_documento] [varchar](20) NULL,
	[num_documento] [varchar](20) NULL,
	[direccion] [varchar](70) NULL,
	[telefono] [varchar](20) NULL,
	[email] [varchar](50) NOT NULL,
	[password_hash] [varbinary](max) NOT NULL,
	[password_salt] [varbinary](max) NOT NULL,
	[condicion] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[idusuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venta]    Script Date: 5/9/2021 19:08:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[venta](
	[idventa] [int] IDENTITY(1,1) NOT NULL,
	[idcliente] [int] NOT NULL,
	[idusuario] [int] NOT NULL,
	[tipo_comprobante] [varchar](20) NOT NULL,
	[num_comprobante] [varchar](10) NOT NULL,
	[fecha_hora] [datetime] NOT NULL,
	[impuesto] [decimal](4, 2) NOT NULL,
	[total] [decimal](11, 2) NOT NULL,
	[estado] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idventa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[articulo] ON 
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (1, 2, N'852369852', N'Gaseosa Inka Kola', CAST(4.00 AS Decimal(11, 2)), 113, NULL, 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (2, 5002, N'12345678', N'Aceite capri 1200ml', CAST(5.00 AS Decimal(11, 2)), 59, N'Aceite de soya capri.', 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (1002, 1003, N'123654799', N'Paracetamol 500Mg', CAST(0.50 AS Decimal(11, 2)), 200, NULL, 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (2002, 3003, N'321523142', N'Papel Bond A4 - Clase B', CAST(10.00 AS Decimal(11, 2)), 218, N'Papel bond tama??o A4 - CB', 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (3002, 3003, N'32147895', N'Papel lustre variados', CAST(0.50 AS Decimal(11, 2)), 510, N'Papel lustre de colores', 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (4002, 3003, N'14587523', N'Papel sabana cuadriculado', CAST(1.00 AS Decimal(11, 2)), 93, N'papel sabana simple', 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (5002, 6003, N'12345679', N'Cargador para celular', CAST(10.00 AS Decimal(11, 2)), 100, N'', 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (5003, 3003, N'12456', N'PAPEL HIGENICO', CAST(20.00 AS Decimal(11, 2)), 100, N'PAPEL', 1)
GO
INSERT [dbo].[articulo] ([idarticulo], [idcategoria], [codigo], [nombre], [precio_venta], [stock], [descripcion], [condicion]) VALUES (5004, 8002, N'78962', N'CALZONESS', CAST(75.00 AS Decimal(11, 2)), 10, N'HOLA', 1)
GO
SET IDENTITY_INSERT [dbo].[articulo] OFF
GO
SET IDENTITY_INSERT [dbo].[categoria] ON 
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2, N'Bebidas', N'Todas las bebidas', 0)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (1003, N'Medicamentos', N'Todos los medicamentos', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (2004, N'Carnes', N'Todas las carnes', 0)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (3002, N'Categoria ejemplo n', N'descripci??n ejemplo', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (3003, N'Papeles', N'Todos los papeles', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (3004, N'Legumbres', N'Todas las legumbres', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (3005, N'Pl??sticos', N'Todos los pl??sticos', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (4002, N'Cereales', N'Todos los cereales', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (5002, N'Aceites', N'Todos los aceites, todas las marcas', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (6002, N'Prueba aut', N'', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (6003, N'Accesorios celular', N'Todos los art??culos para el celular', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (7002, N'Art??culos gym', N'Todos los art??culos para el gym', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (8002, N'con IIS', N'', 1)
GO
INSERT [dbo].[categoria] ([idcategoria], [nombre], [descripcion], [condicion]) VALUES (8003, N'registro iis 2', N'', 1)
GO
SET IDENTITY_INSERT [dbo].[categoria] OFF
GO
SET IDENTITY_INSERT [dbo].[detalle_ingreso] ON 
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (1, 1004, 2, 10, CAST(16.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (2, 1004, 5002, 10, CAST(20.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (3, 1005, 2, 10, CAST(15.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (1002, 2002, 2, 10, CAST(9.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (1003, 2002, 1, 1, CAST(5.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (2002, 3002, 2, 5, CAST(5.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (2003, 3002, 5002, 5, CAST(15.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (2004, 3003, 2, 5, CAST(5.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (2005, 3003, 5002, 5, CAST(15.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (3004, 4002, 2002, 10, CAST(10.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (3005, 4002, 3002, 10, CAST(0.50 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (4004, 5002, 1, 30, CAST(5.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (4005, 5002, 2, 30, CAST(5.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (4006, 5003, 2, 10, CAST(20.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (4007, 5004, 2, 10, CAST(10.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (4008, 5005, 2002, 10, CAST(100.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (4009, 5005, 2, 20, CAST(100.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_ingreso] ([iddetalle_ingreso], [idingreso], [idarticulo], [cantidad], [precio]) VALUES (4010, 5006, 5003, 10, CAST(25.00 AS Decimal(11, 2)))
GO
SET IDENTITY_INSERT [dbo].[detalle_ingreso] OFF
GO
SET IDENTITY_INSERT [dbo].[detalle_venta] ON 
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (1, 1002, 2, 1, CAST(5.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2, 1002, 5002, 1, CAST(10.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (1002, 2002, 2, 10, CAST(5.00 AS Decimal(11, 2)), CAST(5.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (1003, 2002, 2002, 1, CAST(10.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (1004, 2003, 4002, 7, CAST(1.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (1005, 2003, 1, 7, CAST(4.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (1006, 2004, 2, 1, CAST(5.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (1007, 2004, 2002, 1, CAST(10.00 AS Decimal(11, 2)), CAST(1.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2004, 3002, 1, 1, CAST(4.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2005, 3002, 2, 1, CAST(5.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2006, 3002, 1002, 1, CAST(0.50 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2007, 3002, 2002, 1, CAST(10.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2008, 3002, 3002, 1, CAST(0.50 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2009, 3003, 1, 1, CAST(4.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
INSERT [dbo].[detalle_venta] ([iddetalle_venta], [idventa], [idarticulo], [cantidad], [precio], [descuento]) VALUES (2010, 3004, 1, 10, CAST(4.00 AS Decimal(11, 2)), CAST(0.00 AS Decimal(11, 2)))
GO
SET IDENTITY_INSERT [dbo].[detalle_venta] OFF
GO
SET IDENTITY_INSERT [dbo].[ingreso] ON 
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (2, 1, 2, N'FACTURA', N'0001', CAST(N'2018-10-10T00:00:00.000' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(100.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (1004, 1003, 2, N'BOLETA', N'00012', CAST(N'2018-10-14T19:17:21.917' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(360.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (1005, 1003, 3002, N'FACTURA', N'00013', CAST(N'2018-10-14T19:37:23.710' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(150.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (2002, 2, 2, N'BOLETA', N'00013', CAST(N'2018-10-16T12:39:25.240' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(95.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (3002, 1003, 2, N'BOLETA', N'00015', CAST(N'2018-11-01T12:36:24.897' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(100.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (3003, 1003, 2, N'BOLETA', N'00016', CAST(N'2018-11-01T12:38:40.447' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(100.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (4002, 2, 2, N'BOLETA', N'00013', CAST(N'2018-11-06T16:12:08.803' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(105.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (5002, 2, 2, N'FACTURA', N'00020', CAST(N'2018-11-06T17:33:57.077' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(300.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (5003, 1003, 2, N'FACTURA', N'dsaf', CAST(N'2021-09-02T21:43:09.810' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(200.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (5004, 2, 2, N'FACTURA', N'adsf', CAST(N'2021-09-02T21:47:01.587' AS DateTime), CAST(15.00 AS Decimal(4, 2)), CAST(100.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (5005, 2, 3003, N'FACTURA', N'123456', CAST(N'2021-09-03T21:43:13.083' AS DateTime), CAST(15.00 AS Decimal(4, 2)), CAST(3000.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[ingreso] ([idingreso], [idproveedor], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (5006, 2, 3003, N'FACTURA', N'123456897', CAST(N'2021-09-04T21:29:10.470' AS DateTime), CAST(15.00 AS Decimal(4, 2)), CAST(250.00 AS Decimal(11, 2)), N'Anulado')
GO
SET IDENTITY_INSERT [dbo].[ingreso] OFF
GO
SET IDENTITY_INSERT [dbo].[persona] ON 
GO
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (1, N'Cliente', N'Rosa Montenegro Sialer', N'DNI', N'47856932', N'Los alamos 331 - JLO', N'50577592428', N'rosam@gmail.com')
GO
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (2, N'Proveedor', N'Inversiones SantaAna SAC', N'RUC', N'20145236983', N'Chongoyape Jos?? G??lvez 1368', N'963214589', N'mi.anitadiaz@gmail.com')
GO
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (1002, N'Cliente', N'Pedro Suarez De La Cruz', N'DNI', N'15482635', N'Calle Arequipa 113 - Jos?? Olaya', N'963214753', N'pedros@prueba.com')
GO
INSERT [dbo].[persona] ([idpersona], [tipo_persona], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email]) VALUES (1003, N'Proveedor', N'Corporaci??n POLE SA', N'RUC', N'10452121102', N'Chiclayo - Juan Buen D??a 1314', N'999222555', N'pole@prueba.com')
GO
SET IDENTITY_INSERT [dbo].[persona] OFF
GO
SET IDENTITY_INSERT [dbo].[rol] ON 
GO
INSERT [dbo].[rol] ([idrol], [nombre], [descripcion], [condicion]) VALUES (1, N'Administrador', N'Administrador del Sistema', 1)
GO
INSERT [dbo].[rol] ([idrol], [nombre], [descripcion], [condicion]) VALUES (2, N'Almacenero', N'Almacenero del Sistema', 1)
GO
INSERT [dbo].[rol] ([idrol], [nombre], [descripcion], [condicion]) VALUES (3, N'Vendedor', N'Vendedor del Sistema', 1)
GO
SET IDENTITY_INSERT [dbo].[rol] OFF
GO
SET IDENTITY_INSERT [dbo].[usuario] ON 
GO
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion]) VALUES (2, 1, N'Juan C. Arcila D??az', N'DNI', N'47715777', N'Zarumilla 113 - Chiclayo', N'931742904', N'jcarlos.ad7@gmail.com', 0xDD7731CF8729C9428A4E724F61D1F5927E45EE0D736690476AD47CABE1DE3E8927C470E19D23FC88FB61937C6BD1C014F487425FA42D86612EC502DE7D89423F, 0xE68F8D12D91766BBDD19F4FE1E33118E4C57B548C7F1B8E40A2916CDA53E67FB1ABE9EA2ACD4B7330E28994DB576F909E47518BE94856DBD645ECF4A1C39454BCD33C1213EFCAB2FED73A25DF8529E8A0AFDC30E94F802FEB66C6752132D78A7061288C3AF67E5D08AB94E3E652DA945A1BD8773F013A35D48304F39DD84C8D9, 1)
GO
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion]) VALUES (1002, 2, N'Liliana Nataly Arcila D??az', N'DNI', N'47856932', N'Chiclayo', N'985632147', N'liliana.ad7@gmail.com', 0x37D7137257A47E88DE639F382F37E98DFE65B581C00996421B2D66B57E37781D08874987E6A0BEE9DD28E00E35E1A1E0BB3E224D33E88C836F2C3E48CA2B6B18, 0x1CB3A0CA6373ED75061ACB2116760018FD319B8B0A070A2AC3CA5A72F1F3772300C05D33D1FC7D3AF76F69F11D6EC0B2E11E7D8D62D629B1746EB973E945B03EB6BC04220F7D645B786BBACD82CCDCCFFD9508B05D101EA0379DEFAACB8D2053377FEAEDC0A020354587AF0EF1E7D75F9538953E038CC8E54BB71F89D421118D, 1)
GO
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion]) VALUES (2002, 3, N'Vendedor Prueba', N'DNI', N'96321452', N'Calle Piura 113', N'9632587412', N'vendedor@prueba.com', 0x1397F16C7C2983D0764AB17ACF0E87D636E9CBE5678158637AF2C6A79EC4B7B7441EE90DFA5A5313BECE65076AB2421E41AE4087011572A40F436B849BC2811B, 0x551E4C8CE2428BABE2678475243F47D5635FE1DD538460A13173558FD5FD868776C375CD6F9DC106445B757909612B0DDC5D8632799820FEBD57240A76E9D3965F5C52836921F3E4809F1740CDF60E09BA5F810CA7051A0C32C8EDBCF7CF6ABA92923EBC1504FC1A5AF34472E3654949BFF12F3768C6466BEA1A96982BDFCE2B, 1)
GO
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion]) VALUES (3002, 2, N'Almacenero', N'DNI', N'11111111', N'', N'50577758952', N'almacenero@prueba.com', 0x77439C39475A38CBA6188B14CFF7FD7368CFE7847BAA818C8B0FAE4ABB97C8044B87C458FBD66A4C48B41F37AB9279906A099B3C17064233D7519D660CA389EB, 0x6D26C60232B494C92384ED72E52610CA64280884BD3E32B931F41E4257031C869410ADCA6DE2A0884647DEE61B27A40D94E8539D9FDE6E4E4ED20FC9FE593E7729D36B368D6B8B70047654799A751DF77A58759F0744863265367E1174349F6ED2DF7AEB24D6065E894E23C11DBC1375B82B386245505C90E0FEF5FE81A927DC, 1)
GO
INSERT [dbo].[usuario] ([idusuario], [idrol], [nombre], [tipo_documento], [num_documento], [direccion], [telefono], [email], [password_hash], [password_salt], [condicion]) VALUES (3003, 1, N'Francisco ', N'RUC', N'123465', N'j', N'77593728', N'admin@admin', 0x5180107E0C4F91815DC264CF123798DBC98C28BCD53BC2E9023AB8A3B1311926A1109F882CCB500538B46FDDE6D929FDE0AFAAA354FBBE8745D90433CBA038F9, 0x42788A5BFED31F2D5C91F80EC891DE9EEF28CA45BBD97D70509A028032B06D3D1E3F1CF443E02C1DC312CEE5945476FDA8CD8ED12B56A3B9E39F09BC278569B538B1407D077B8C94553B2BFA2FE091E7A7B62875C5E631D6AF83270FC490AEB8D80138B6BF638F238039C4E3A971A198E6DFB4EE644837C9AF49459747155718, 1)
GO
SET IDENTITY_INSERT [dbo].[usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[venta] ON 
GO
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (1002, 1, 2, N'FACTURA', N'0001', CAST(N'2018-12-04T18:01:38.000' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(15.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (2002, 1002, 2, N'FACTURA', N'0002', CAST(N'2018-11-07T11:00:20.163' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(55.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (2003, 1002, 2, N'FACTURA', N'0003', CAST(N'2018-11-07T11:24:42.000' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(35.00 AS Decimal(11, 2)), N'Aceptado')
GO
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (2004, 1, 2, N'FACTURA', N'0004', CAST(N'2018-10-07T11:39:27.000' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(14.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (3002, 1, 2, N'BOLETA', N'0001', CAST(N'2018-09-27T15:10:56.000' AS DateTime), CAST(18.00 AS Decimal(4, 2)), CAST(20.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (3003, 1, 3003, N'FACTURA', N'asdf', CAST(N'2021-09-04T21:26:31.890' AS DateTime), CAST(15.00 AS Decimal(4, 2)), CAST(4.00 AS Decimal(11, 2)), N'Anulado')
GO
INSERT [dbo].[venta] ([idventa], [idcliente], [idusuario], [tipo_comprobante], [num_comprobante], [fecha_hora], [impuesto], [total], [estado]) VALUES (3004, 1, 3003, N'FACTURA', N'780', CAST(N'2021-09-05T17:49:36.253' AS DateTime), CAST(15.00 AS Decimal(4, 2)), CAST(40.00 AS Decimal(11, 2)), N'Aceptado')
GO
SET IDENTITY_INSERT [dbo].[venta] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__articulo__72AFBCC6F8BBBF87]    Script Date: 5/9/2021 19:08:13 ******/
ALTER TABLE [dbo].[articulo] ADD  CONSTRAINT [UQ__articulo__72AFBCC6F8BBBF87] UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [codigo]    Script Date: 5/9/2021 19:08:13 ******/
CREATE UNIQUE NONCLUSTERED INDEX [codigo] ON [dbo].[articulo]
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__categori__72AFBCC6B2B17C4F]    Script Date: 5/9/2021 19:08:13 ******/
ALTER TABLE [dbo].[categoria] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [USUARIO]    Script Date: 5/9/2021 19:08:13 ******/
CREATE UNIQUE NONCLUSTERED INDEX [USUARIO] ON [dbo].[usuario]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[articulo] ADD  CONSTRAINT [DF__articulo__condic__35BCFE0A]  DEFAULT ((1)) FOR [condicion]
GO
ALTER TABLE [dbo].[categoria] ADD  DEFAULT ((1)) FOR [condicion]
GO
ALTER TABLE [dbo].[rol] ADD  DEFAULT ((1)) FOR [condicion]
GO
ALTER TABLE [dbo].[usuario] ADD  DEFAULT ((1)) FOR [condicion]
GO
ALTER TABLE [dbo].[articulo]  WITH CHECK ADD  CONSTRAINT [FK__articulo__idcate__398D8EEE] FOREIGN KEY([idcategoria])
REFERENCES [dbo].[categoria] ([idcategoria])
GO
ALTER TABLE [dbo].[articulo] CHECK CONSTRAINT [FK__articulo__idcate__398D8EEE]
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD  CONSTRAINT [FK__detalle_i__idart__3A81B327] FOREIGN KEY([idarticulo])
REFERENCES [dbo].[articulo] ([idarticulo])
GO
ALTER TABLE [dbo].[detalle_ingreso] CHECK CONSTRAINT [FK__detalle_i__idart__3A81B327]
GO
ALTER TABLE [dbo].[detalle_ingreso]  WITH CHECK ADD FOREIGN KEY([idingreso])
REFERENCES [dbo].[ingreso] ([idingreso])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD  CONSTRAINT [FK__detalle_v__idart__3C69FB99] FOREIGN KEY([idarticulo])
REFERENCES [dbo].[articulo] ([idarticulo])
GO
ALTER TABLE [dbo].[detalle_venta] CHECK CONSTRAINT [FK__detalle_v__idart__3C69FB99]
GO
ALTER TABLE [dbo].[detalle_venta]  WITH CHECK ADD FOREIGN KEY([idventa])
REFERENCES [dbo].[venta] ([idventa])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ingreso]  WITH CHECK ADD FOREIGN KEY([idproveedor])
REFERENCES [dbo].[persona] ([idpersona])
GO
ALTER TABLE [dbo].[ingreso]  WITH CHECK ADD  CONSTRAINT [FK__ingreso__idusuar__3F466844] FOREIGN KEY([idusuario])
REFERENCES [dbo].[usuario] ([idusuario])
GO
ALTER TABLE [dbo].[ingreso] CHECK CONSTRAINT [FK__ingreso__idusuar__3F466844]
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD FOREIGN KEY([idrol])
REFERENCES [dbo].[rol] ([idrol])
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD FOREIGN KEY([idcliente])
REFERENCES [dbo].[persona] ([idpersona])
GO
ALTER TABLE [dbo].[venta]  WITH CHECK ADD  CONSTRAINT [FK__venta__idusuario__4222D4EF] FOREIGN KEY([idusuario])
REFERENCES [dbo].[usuario] ([idusuario])
GO
ALTER TABLE [dbo].[venta] CHECK CONSTRAINT [FK__venta__idusuario__4222D4EF]
GO
USE [master]
GO
ALTER DATABASE [dbsistemaasp] SET  READ_WRITE 
GO
