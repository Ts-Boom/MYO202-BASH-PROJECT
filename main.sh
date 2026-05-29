#!/bin/bash

# İsim SOYİSİM: Taha SAYIN
# Öğrenci Numarası: 2420191020
# Sertifika Bağlantıları:
# 1- Docker: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=wmlFmMBv2q
# 2- Linux: https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=mKEhkM1bx8
# 3- Bash Script: https://credsverse.com/credentials/7d5b0f7a-40ae-4c79-8f2c-85a27350338d

# 1. report.log dosyasını oluştur ve ilk satırına ISO biçiminde tarih/saat yazdır
date -Iseconds > report.log

# 2. Donanım bilgilerini ekle (Macbook için system_profiler ve ifconfig)
echo "--- İŞLEMCİ, RAM, ANAKART VE UUID BİLGİSİ ---" >> report.log
system_profiler SPHardwareDataType >> report.log

# DİSK BİLGİSİ (Hocanın istediği kapasite, marka, model. UUID hariç!)
echo "--- DİSK BİLGİSİ (KAPASİTE, MARKA, MODEL) ---" >> report.log
system_profiler SPStorageDataType | grep -v "UUID" >> report.log

echo "--- MAC ADRESİ BİLGİSİ ---" >> report.log
ifconfig | grep -w "ether" >> report.log

# 3. Kullanıcıdan parola iste (Şifre ekranda görünmez, gizli giriş)
read -sp "Lütfen parolayı giriniz: " PAROLA
echo ""

# 4. GPG ile AES256 algoritmasını kullanarak simetrik şifreleme yap
echo "$PAROLA" | gpg --batch --yes --passphrase-fd 0 --symmetric --cipher-algo AES256 -o report.log.gpg report.log

# 5. İşlem bittikten sonra orijinal dosyayı sil
rm report.log

echo "Tebrikler! İşlem başarıyla tamamlandı ve şifreli log dosyası (report.log.gpg) oluşturuldu."
