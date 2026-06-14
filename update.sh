#!/bin/zsh

# Eski endeks dosyalarını temizle
rm -f Packages Packages.gz

echo "Paketler taranıyor..."

# debs klasöründeki her bir .deb dosyasını tara
for deb in debs/*.deb; do
    if [ -f "$deb" ]; then
        echo "Taranıyor: $deb"
        # dpkg-deb kullanarak control içeriğini çek ve Packages dosyasına yaz
        dpkg-deb -f "$deb" >> Packages
        
        # Her paketin dosya yolunu ve boyutunu Debian standartlarına uygun ekle
        echo "Filename: $deb" >> Packages
        echo "Size: $(stat -c%s "$deb")" >> Packages
        echo "" >> Packages
    fi
done

# Packages dosyasını sıkıştırarak kopyasını oluştur
gzip -9c Packages > Packages.gz

echo "Bitti! Packages ve Packages.gz başarıyla oluşturuldu."
