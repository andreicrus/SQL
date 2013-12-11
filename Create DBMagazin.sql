
-----Prima cerinta
----Minim: creati o baza de date destinata unui "Magazin"  in care retinem detalii despre magazin, produsele comercializate in magazin si stocuri
----Extra: fisierele bazei de date se regasesc in locatia "c:\databases\" sau "D:\Databases\"
----HINTS: CREATE

create database Magazin

---Cerinta doi 
----Baza de date contine tabelele 
	---Magazin
	---Produs
	---CategorieProdus - in care sunt stocate categoriile de produse
	---Stoc - in aceasta tabela se tin informatii cantitative despre produse 
	---Intrari - ce produse intra in stocurile (produs, cantitate, pret unitar, data de intrare a produsului in stocul magazinului)
	---Iesiri - ce produse ies din stoc (produs, cantitate, pret unitar, data de iesire a produsului din stocul magazinului)

----Minim:  construiti structura astfel incat sa nu se poata adauga un produs fara sa se specifice magazinul si categoria produsului; 
----		sa nu se poata adauga informatii cantitative in stoc fara sa se precizeze produsul si magazinul
----		sa nu se poata adauga informatii in intrari iesiri fara sa se precizeze produsul, data, magazinul
----Extra: Construiti un trigger care sa populeze tabela st  
----Hints: foreign keys, primary keys

----Create Categorie Produse:
USE Magazin
CREATE TABLE [dbo].[CategorieProdus](
	[Id_Categorie] [int] IDENTITY(1,1) NOT NULL,
	[DenumireCat] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CategorieProdus] PRIMARY KEY CLUSTERED 
(
	[Id_Categorie] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

----Create Magazin:
USE Magazin
CREATE TABLE [dbo].[Magazin](
	[Id_Magazin] [int] IDENTITY(1,1) NOT NULL,
	[DenumireMag] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Magazin] PRIMARY KEY CLUSTERED 
(
	[Id_Magazin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---Create Produs
USE Magazin
CREATE TABLE [dbo].[Produs](
	[Id_Produs] [int] IDENTITY(1,1) NOT NULL,
	[DenumireProd] [nvarchar](50) NOT NULL,
	[Data_Expirare] [datetime] NOT NULL,
	[Id_Magazin] [int] NOT NULL,
	[Id_Categorie] [int] NOT NULL,
 CONSTRAINT [PK_Produs] PRIMARY KEY CLUSTERED 
(
	[Id_Produs] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Produs]  WITH CHECK ADD  CONSTRAINT [FK_Produs_CategorieProdus] FOREIGN KEY([Id_Categorie])
REFERENCES [dbo].[CategorieProdus] ([Id_Categorie])
ALTER TABLE [dbo].[Produs] CHECK CONSTRAINT [FK_Produs_CategorieProdus]
ALTER TABLE [dbo].[Produs]  WITH CHECK ADD  CONSTRAINT [FK_Produs_Magazin] FOREIGN KEY([Id_Magazin])
REFERENCES [dbo].[Magazin] ([Id_Magazin])
ALTER TABLE [dbo].[Produs] CHECK CONSTRAINT [FK_Produs_Magazin]

---Create Stoc
CREATE TABLE [dbo].[Stoc](
	[Id_Stoc] [int] IDENTITY(1,1) NOT NULL,
	[Id_Produs] [int] NOT NULL,
	[Id_Magazin] [int] NOT NULL,
	[Cantitate] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Stoc] PRIMARY KEY CLUSTERED 
(
	[Id_Stoc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[Stoc]  WITH CHECK ADD  CONSTRAINT [FK_Stoc_Magazin] FOREIGN KEY([Id_Magazin])
REFERENCES [dbo].[Magazin] ([Id_Magazin])
ALTER TABLE [dbo].[Stoc] CHECK CONSTRAINT [FK_Stoc_Magazin]
ALTER TABLE [dbo].[Stoc]  WITH CHECK ADD  CONSTRAINT [FK_Stoc_Produs] FOREIGN KEY([Id_Produs])
REFERENCES [dbo].[Produs] ([Id_Produs])
ALTER TABLE [dbo].[Stoc] CHECK CONSTRAINT [FK_Stoc_Produs]

---Create Iesiri
USE Magazin
CREATE TABLE [dbo].[Iesiri](
	[Cod_Iesire] [int] IDENTITY(1,1) NOT NULL,
	[Id_Produs] [int] NOT NULL,
	[Id_Magazin] [int] NOT NULL,
	[Data_Iesire] [datetime] NOT NULL,
	[Cantitate] [numeric](18, 0) NOT NULL,
	[Pret] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Iesiri] PRIMARY KEY CLUSTERED 
(
	[Cod_Iesire] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Iesiri]  WITH CHECK ADD  CONSTRAINT [FK_Iesiri_Magazin] FOREIGN KEY([Id_Magazin])
REFERENCES [dbo].[Magazin] ([Id_Magazin])
ALTER TABLE [dbo].[Iesiri] CHECK CONSTRAINT [FK_Iesiri_Magazin]
ALTER TABLE [dbo].[Iesiri]  WITH CHECK ADD  CONSTRAINT [FK_Iesiri_Produs] FOREIGN KEY([Id_Produs])
REFERENCES [dbo].[Produs] ([Id_Produs])
ALTER TABLE [dbo].[Iesiri] CHECK CONSTRAINT [FK_Iesiri_Produs]


---Create Intrari
USE Magazin
CREATE TABLE [dbo].[Intrari](
	[Cod_Intrare] [int] IDENTITY(1,1) NOT NULL,
	[Id_Produs] [int] NOT NULL,
	[Id_Magazin] [int] NOT NULL,
	[Data_Intrare] [datetime] NOT NULL,
	[Cantitate] [numeric](18, 0) NOT NULL,
	[Pret] [numeric](18, 0) NOT NULL,
 CONSTRAINT [PK_Intrari] PRIMARY KEY CLUSTERED 
(
	[Cod_Intrare] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Intrari]  WITH CHECK ADD  CONSTRAINT [FK_Intrari_Magazin] FOREIGN KEY([Id_Magazin])
REFERENCES [dbo].[Magazin] ([Id_Magazin])
ALTER TABLE [dbo].[Intrari] CHECK CONSTRAINT [FK_Intrari_Magazin]
ALTER TABLE [dbo].[Intrari]  WITH CHECK ADD  CONSTRAINT [FK_Intrari_Produs] FOREIGN KEY([Id_Produs])
REFERENCES [dbo].[Produs] ([Id_Produs])
ALTER TABLE [dbo].[Intrari] CHECK CONSTRAINT [FK_Intrari_Produs]


----Cerinta trei 
----Minim: sa se scrie un script de populare a tabelelor astfel incat sa existe 2 magazine, iar pentru fiecare magazin sa existe in stoc 3 produse din cele 6 categorii disponibile
----Extra: sa se scrie un script de populare precum cel de mai sus folosind iteratie /bucla
----Hints: INSERT, WHILE , CAST/CONVERT, N'Produs' + counter



WHILE (SELECT COUNT(*) FROM [Magazin].[dbo].[CategorieProdus]) <6
BEGIN
INSERT	INTO [Magazin].[dbo].[CategorieProdus]
			(DenumireMag)
	  VALUES
			('Fructe'),
			('Legume'),
			('Carne'),
			('Lactate'),
			('Bauturi'),
			('Sanitare') 
      BREAK
      CONTINUE
END
PRINT 'Avem deja 6 categorii';

WHILE (SELECT COUNT(*) FROM [Magazin].[dbo].[Magazin]) < 2
BEGIN
INSERT INTO [Magazin].[dbo].[Magazin]
           ([DenumireMag])
     VALUES
           ('Cora'),
           ('MegaImage') 
      BREAK
      CONTINUE
END
PRINT 'Avem deja 2 magazine';


---delete from Magazin.dbo.CategorieProdus
---elete from magazin.dbo.magazin
--- nu e chiar cum am vrut puteams a fac un insert care sa introduca o valoare '0' de exemplu 
---si apoi sa fac un update prin care sa fac un insert select from .. dar in momentul
---in care incecam sa introduc 0 nu respectam condiitiile de foreign key

INSERT INTO [Magazin].[DBO].[Produs]
	(DenumireProd,Data_Expirare,Id_Categorie,Id_Magazin)
	VALUES ('Cartofi','2013-05-05',2,1) ,
			('Vin','2013-05-05',5,1) ,
			('Pui','2013-05-05',3,1) ,
			('Iaurt','2013-05-05',4,2) ,
			('Ace','2013-05-05',6,2), 
			('Mere','2013-05-05',1,2), 
			('Rosii','2013-05-05',2,1) ,
			('Bere','2013-05-05',5,1) ,
			('Carnati','2013-05-05',3,1) ,
			('Branza','2013-05-05',4,2) ,
			('Pansamente','2013-05-05',6,2), 
			('Prune','2013-05-05',1,2), 
			('Sfecla','2013-05-05',2,1) ,
			('Palinca','2013-05-05',5,1) ,
			('Porc','2013-05-05',3,1) ,
			('Telemea','2013-05-05',4,2) ,
			('Pastile','2013-05-05',6,2), 
			('Kiwi','2013-05-05',1,2) 
			--use Magazin
			--select * from Magazin.dbo.produs
--Cerinta patru:
----Minim: sa se scrie un query din care sa reiasa pt fiecare magazin care sunt categoriile de produse inexistente in stoc
----Extra: sa se re-scrie query-ul in cat mai multe moduri
----Hints: LEFT, NOT, IN, NULL, EXCEPT, INTERSECT

--??? 
use Magazin
SELECT DenumireCat , DenumireMag FROM CategorieProdus  , Magazin  
Except
(
(SELECT Magazin.DenumireMag, CategorieProdus.DenumireCat
From CategorieProdus
left join Produs on CategorieProdus.Id_Categorie = Produs.Id_Categorie
left join Stoc on Produs.Id_Magazin = Stoc.Id_Magazin
left join Magazin on Stoc.Id_Magazin = Magazin.Id_Magazin
Group by Magazin.DenumireMag,CategorieProdus.DenumireCat) 
)

--select * from Magazin.dbo.CategorieProdus

----Cerinta cinci :
----Minim : sa se creeze un view care sa contina urmatoarele informatii:
	--magazin
	--denumire produs
	--categorie produs
	--cantitatea aflata in stoc aferenta produsului
----Extra:	realizati un script sql care sa se modifice tabela stoc existenta astfel incat sa existe si pretul unitar asociat unui singur produs; 
----		view-ul de mai sus sa se modifice astfel incat sa contina si valoarea stocului
----Hints: ALTER, INNER, SUM

CREATE VIEW [dbo].[ViewC5]
AS
SELECT     dbo.Stoc.Cantitate, dbo.Produs.Denumire, dbo.Magazin.Denumire AS Expr1, dbo.CategorieProdus.Denumire AS Expr2
FROM         dbo.CategorieProdus INNER JOIN
                      dbo.Produs ON dbo.CategorieProdus.Id_Categorie = dbo.Produs.Id_Categorie INNER JOIN
                      dbo.Magazin ON dbo.Produs.Id_Magazin = dbo.Magazin.Id_Magazin INNER JOIN
                      dbo.Stoc ON dbo.Produs.Id_Produs = dbo.Stoc.Id_Produs AND dbo.Magazin.Id_Magazin = dbo.Stoc.Id_Magazin



----Cerinta sase:
----Minim: sa se scrie o procedura care introduce produse in stoc (insereaza informatii in tabela Intrari)
----extra: realizati un script care apeleaza procedura 
----Hints: CREATE, INSERT, DECLARE

	
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE   InserareIntrari
	-- Add the parameters for the stored procedure here
	@Id_Produs int,
	@Id_Magazin int,
	@Data_Intrare datetime,
	@Cantitate bigint,
	@Pret money
AS
BEGIN
		DECLARE @Id_Intrare INT
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    BEGIN TRANSACTION;

	BEGIN TRY
		INSERT INTO Intrari(Id_Produs, Id_Magazin, Data_Intrare,Cantitate,Pret) VALUES (@Id_Produs, @Id_Magazin, @Data_Intrare, @Cantitate,@Pret)
	SET @Id_Intrare = SCOPE_IDENTITY()

	END TRy
	BEGIN CATCH
		SELECT 
			ERROR_NUMBER() AS ErrorNumber
			,ERROR_SEVERITY() AS ErrorSeverity
			,ERROR_STATE() AS ErrorState
			,ERROR_PROCEDURE() AS ErrorProcedure
			,ERROR_LINE() AS ErrorLine
			,ERROR_MESSAGE() AS ErrorMessage;

		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;
	END CATCH;

	IF @@TRANCOUNT > 0
		COMMIT TRANSACTION;

END
GO

----Cerinta sapte:
----Minim: sa se elimine din tabela stoc coloana pret unitar (in cazul in care a fost introdusa o astfel de coloana)
----Maxim:
----Hints: ALTER  

alter table magazin.dbo.stoc
drop column Pret

---Cerinta opt:
---Minim: sa se realizeze un trigger pe tabela Intrari, care sa refaca automat cantitatea din Stoc la introducerea de noi produse in stocul magazinului 
---extra: sa se realizeze un trigger pe tabela Iesiri care sa refaca automat cantitatea din Stoc la iesirea produselor din stocul magazinului
----Hints: TRIGGER, INSERTED



---Cerinta noua: 
---Minim : sa se afiseze ce produse au intrat in ultimele 10 zile in stocul fiecarui magazin
---Extra : sa se afiseze ce produse au iesit in ultimele 10 zile in stocul fiecarui magazin
---Hints: SELECT ,  GROUP , WHERE

use Magazin
SELECT x.DenumireMag, y.DenumireProd, z.Data_Intrare
FROM Intrari z
inner join Magazin x on z.Id_Magazin = x.Id_Magazin
inner join Stoc s on s.Id_Magazin = x.Id_Magazin
inner join Produs y on z.Id_Produs = y.Id_Produs
WHERE DATEDIFF(day,z.Data_Intrare,GETDATE())<10
GROUP BY x.DenumireMag, z.Data_Intrare, y.DenumireProd

---Cerinta zece:
---Minim : sa se realizeze o procedura stocata care imi permite sa afisez evolutia cantitativa (cantitate) si valorica (pret*cantitate) a intrarilor pe ultimele n zile astfel
---magazin, data, produs, cantitate, valoare
---Extra: in procedura se apeleaza o functie care returneaza un tabela
---Hints: WHILE, SUM, variabila TABLE, 
