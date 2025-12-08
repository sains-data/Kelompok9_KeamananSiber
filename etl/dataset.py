#Kelompok 9

#Dataset Generation

import pandas as pd

import numpy as np

from faker import Faker

import random



fake = Faker()



# 1. GENERATE DIM_WAKTU

date_range = pd.date_range(start="2023-01-01", end="2025-12-31")

dim_waktu = pd.DataFrame({

    "WaktuKey": range(1, len(date_range)+1),

    "Tanggal": date_range,

    "Bulan": date_range.month,

    "Tahun": date_range.year,

    "Hari": date_range.day_name()

})



# 2. GENERATE DIM_LOKASI (3 FAKULTAS + SERVER)

fakultas = ["FS", "FTI", "FTIK"]



# misal tiap fakultas punya satu server utama

server_list = ["FS-SRV01", "FTI-SRV01", "FTIK-SRV01"]



dim_lokasi = pd.DataFrame({

    "LokasiKey": range(1, len(fakultas)+1),

    "Fakultas": fakultas,

    "Server": server_list

})



#  3. GENERATE DIM_JENIS_SERANGAN

jenis_serangan = [

    "DDoS", "SQL Injection", "Phishing", "Malware",

    "Brute Force", "Ransomware"

]



dim_serangan = pd.DataFrame({

    "JenisSeranganKey": range(1, len(jenis_serangan)+1),

    "NamaSerangan": jenis_serangan,

    "Deskripsi": [fake.sentence() for _ in jenis_serangan]

})



# 4. GENERATE DIM_TIM_RESPON

tim = [fake.name() for _ in range(20)]

jabatan = ["Staff", "Supervisor", "Koordinator"]

unit_tim = ["PUSDATIN", "Network Security", "Incident Response"]



dim_tim = pd.DataFrame({

    "TimResponKey": range(1, len(tim)+1),

    "Petugas": tim,

    "Jabatan": [random.choice(jabatan) for _ in tim],

    "Unit": [random.choice(unit_tim) for _ in tim]

})



# 5. GENERATE FACT INCIDENT (10.000 RECORD)

n = 10000



fact = pd.DataFrame({

    "ID_Incident": range(1, n+1),

    "WaktuKey": np.random.randint(1, len(dim_waktu)+1, n),

    "LokasiKey": np.random.randint(1, len(dim_lokasi)+1, n),

    "JenisSeranganKey": np.random.randint(1, len(dim_serangan)+1, n),

    "TimResponKey": np.random.randint(1, len(dim_tim)+1, n),

    "DurasiRespon": np.random.randint(5, 500, n),

    "JumlahDataTerenam": np.random.randint(0, 10000, n),

    "StatusPenanganan": np.random.choice(

        ["selesai", "pending"],

        n,

        p=[0.85, 0.15]

    )

})



# SAVE OPTIONAL

dim_waktu.to_csv("Dim_Waktu.csv", index=False)

dim_lokasi.to_csv("Dim_Lokasi.csv", index=False)

dim_serangan.to_csv("Dim_Jenis_Serangan.csv", index=False)

dim_tim.to_csv("Dim_Tim_Respon.csv", index=False)

fact.to_csv("Fact_Incident.csv", index=False)
