USE TakvimAjandaDB;
GO

-- 1. Kullanici ve Tarih Bazli Hizli Arama Indeksi
CREATE INDEX IX_Gorevler_KullaniciTarih
ON Gorevler (KullaniciID, PlanTarihi);
GO

-- 2. Takvimdeki Dolu Gunleri ve Tamamlanma Yuzdesini Dinamik Hesaplayan Sorgu
SELECT 
    PlanTarihi,
    COUNT(GorevID) AS ToplamGorevSayisi,
    SUM(CAST(TamamlandiMi AS INT)) AS TamamlananGorevSayisi,
    (SUM(CAST(TamamlandiMi AS INT)) * 100) / COUNT(GorevID) AS TamamlanmaYuzdesi,
    CASE 
        WHEN COUNT(GorevID) > 0 THEN N'Koyu Yeşil (Görev Var)'
        ELSE N'Standart (Boş)'
    END AS GunRenkDurumu
FROM Gorevler
WHERE KullaniciID = 1
  AND PlanTarihi BETWEEN '2026-11-01' AND '2026-11-30'
GROUP BY PlanTarihi;
GO
