import 'book.dart';
import 'section.dart';

class SampleRisaleBookList {
  static final books = [
    Book(
        title: 'Asâ-yı Musa',
        sections:
            asayiMusa.map((fileName) => Section(fileName: fileName)).toList(),
        assetFolder: 'asayi_musa'),
    Book(
        title: 'Küçük Kitaplar',
        sections:
            littleBooks.map((fileName) => Section(fileName: fileName)).toList(),
        assetFolder: 'kucuk_kitaplar'),
    Book(
        title: 'Lem\'alar',
        sections:
            lemalar.map((fileName) => Section(fileName: fileName)).toList(),
        assetFolder: 'lemalar'),
    Book(
        title: 'Mektubat',
        sections:
            mektubat.map((fileName) => Section(fileName: fileName)).toList(),
        assetFolder: 'mektubat'),
    Book(
        title: 'Sözler',
        sections:
            sozler.map((fileName) => Section(fileName: fileName)).toList(),
        assetFolder: 'sozler'),
    Book(
        title: 'Barla Lâhikası',
        sections: barlaLahikasi1
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'barla_lahikasi'),
    Book(
        title: 'Emirdağ Lâhikası 1',
        sections: emirdagLahikasi1
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'emirdag_lahikasi_1'),
    Book(
        title: 'Emirdağ Lâhikası 2',
        sections: emirdagLahikasi2
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'emirdag_lahikasi_2'),
    Book(
        title: 'İşaratü\'l-i\'caz',
        sections: isaratulICaz
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'isaratul_icaz'),
    Book(
        title: 'Kastamonu Lâhikası',
        sections: kastamonuLahikasi
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'kastamonu_lahikasi'),
    Book(
        title: 'Mesnevî-i Nuriye',
        sections: mesneviiNuriye
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'mesnevii_nuriye'),
    Book(
        title: 'Muhakemat',
        sections:
            muhakemat.map((fileName) => Section(fileName: fileName)).toList(),
        assetFolder: 'muhakemat'),
    Book(
        title: 'Sikke-i Tasdik-i Gaybî',
        sections: sikkeiTasdikiGaybi
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'sikkei_tasdiki_gaybi'),
    Book(
        title: 'Şuâlar',
        sections:
            sualar.map((fileName) => Section(fileName: fileName)).toList(),
        assetFolder: 'sualar'),
    Book(
        title: 'Tarihçe-i Hayat',
        sections: tarihceiHayat
            .map((fileName) => Section(fileName: fileName))
            .toList(),
        assetFolder: 'tarihcei_hayat'),
  ];
  static final asayiMusa = [
    'Asâ-yı Musa-01-Mukaddimat.txt',
    'Asâ-yı Musa-02-Asâ yı Musa\'dan Birinci Kısım.txt',
    'Asâ-yı Musa-03-Birinci Mesele.txt',
    'Asâ-yı Musa-04-İkinci Mesele.txt',
    'Asâ-yı Musa-05-Üçüncü Mesele.txt',
    'Asâ-yı Musa-06-Dördüncü Mesele.txt',
    'Asâ-yı Musa-07-Beşinci Mesele.txt',
    'Asâ-yı Musa-08-Altıncı Mesele.txt',
    'Asâ-yı Musa-09-Yedinci Mesele.txt',
    'Asâ-yı Musa-10-Sekizinci Mesele.txt',
    'Asâ-yı Musa-11-Dokuzuncu Mesele.txt',
    'Asâ-yı Musa-12-Onuncu Mesele.txt',
    'Asâ-yı Musa-13-On Birinci Mesele.txt',
    'Asâ-yı Musa-14-Asâ yı Musa\'dan İkinci Kısım.txt',
    'Asâ-yı Musa-15-Birinci Hüccet i İmaniye.txt',
    'Asâ-yı Musa-16-İkinci Hüccet i İmaniye.txt',
    'Asâ-yı Musa-17-Üçüncü Hüccet i İmaniye.txt',
    'Asâ-yı Musa-18-Dördüncü Hüccet i İmaniye.txt',
    'Asâ-yı Musa-19-Beşinci Hüccet i İmaniye.txt',
    'Asâ-yı Musa-20-Altıncı Hüccet i İmaniye.txt',
    'Asâ-yı Musa-21-Yedinci Hüccet i İmaniye.txt',
    'Asâ-yı Musa-22-Sekizinci Hüccet i İmaniye.txt',
    'Asâ-yı Musa-23-Dokuzuncu Hüccet i İmaniye.txt',
    'Asâ-yı Musa-24-Onuncu Hüccet i İmaniye.txt',
    'Asâ-yı Musa-25-On Birinci Hüccet i İmaniye.txt',
    'Asâ-yı Musa-26-Fihrist (Asâ yı Musa).txt'
  ];
  static final barlaLahikasi1 = [
    'Barla Lâhikası-01-Barla Lâhikası - Takdim.txt',
    'Barla Lâhikası-02-Barla Lâhikası - Yedinci Risale.txt',
    'Barla Lâhikası-03-Barla Lâhikası s.21_39.txt',
    'Barla Lâhikası-04-Barla Lâhikası s.40_58.txt',
    'Barla Lâhikası-05-Barla Lâhikası s.59_80.txt',
    'Barla Lâhikası-06-Barla Lâhikası s.80_102.txt',
    'Barla Lâhikası-07-Barla Lâhikası s.103_121.txt',
    'Barla Lâhikası-08-Barla Lâhikası s.121_146.txt',
    'Barla Lâhikası-09-Barla Lâhikası s.146_159.txt',
    'Barla Lâhikası-10-Barla Lâhikası s.160_180.txt',
    'Barla Lâhikası-11-Barla Lâhikası s.181_201.txt',
    'Barla Lâhikası-12-Barla Lâhikası s.202_221.txt',
    'Barla Lâhikası-13-Barla Lâhikası s.221_240.txt',
    'Barla Lâhikası-14-Barla Lâhikası s.241_261.txt',
    'Barla Lâhikası-15-Barla Lâhikası s.262_280.txt',
    'Barla Lâhikası-16-Barla Lâhikası s.280_299.txt',
    'Barla Lâhikası-17-Barla Lâhikası s.300_321.txt',
    'Barla Lâhikası-18-Barla Lâhikası s.321_340.txt',
    'Barla Lâhikası-19-Barla Lâhikası s.340_362.txt',
    'Barla Lâhikası-20-Barla Lâhikası s.363_392.txt'
  ];

  static final emirdagLahikasi1 = [
    'Emirdağ Lâhikası 1-01-Emirdağ Lâhikası - I - Takdim.txt',
    'Emirdağ Lâhikası 1-02-Emirdağ Lâhikası - I s.10_31.txt',
    'Emirdağ Lâhikası 1-03-Emirdağ Lâhikası - I s.31_50.txt',
    'Emirdağ Lâhikası 1-04-Emirdağ Lâhikası - I s.50_69.txt',
    'Emirdağ Lâhikası 1-05-Emirdağ Lâhikası - I s.70_90.txt',
    'Emirdağ Lâhikası 1-06-Emirdağ Lâhikası - I s.90_110.txt',
    'Emirdağ Lâhikası 1-07-Emirdağ Lâhikası - I s.110_130.txt',
    'Emirdağ Lâhikası 1-08-Emirdağ Lâhikası - I s.131_150.txt',
    'Emirdağ Lâhikası 1-09-Emirdağ Lâhikası - I s.150_170.txt',
    'Emirdağ Lâhikası 1-10-Emirdağ Lâhikası - I s.170_190.txt',
    'Emirdağ Lâhikası 1-11-Emirdağ Lâhikası - I s.190_211.txt',
    'Emirdağ Lâhikası 1-12-Emirdağ Lâhikası - I s.212_230.txt',
    'Emirdağ Lâhikası 1-13-Emirdağ Lâhikası - I s.230_251.txt',
    'Emirdağ Lâhikası 1-14-Emirdağ Lâhikası - I s.251_270.txt',
    'Emirdağ Lâhikası 1-15-Emirdağ Lâhikası - I s.271_288.txt'
  ];
  static final emirdagLahikasi2 = [
    'Emirdağ Lâhikası 2-01-Emirdağ Lâhikası - I.txt',
    'Emirdağ Lâhikası 2-02-Emirdağ Lâhikası - II s.6_26.txt',
    'Emirdağ Lâhikası 2-03-Emirdağ Lâhikası - II s.27_50.txt',
    'Emirdağ Lâhikası 2-04-Emirdağ Lâhikası - II s.51_70.txt',
    'Emirdağ Lâhikası 2-05-Emirdağ Lâhikası - II s.70_90.txt',
    'Emirdağ Lâhikası 2-06-Emirdağ Lâhikası - II s.91_109.txt',
    'Emirdağ Lâhikası 2-07-Emirdağ Lâhikası - II s.110_128.txt',
    'Emirdağ Lâhikası 2-08-Emirdağ Lâhikası - II s.129_148.txt',
    'Emirdağ Lâhikası 2-09-Emirdağ Lâhikası - II s.149_170.txt',
    'Emirdağ Lâhikası 2-10-Emirdağ Lâhikası - II s.171_189.txt',
    'Emirdağ Lâhikası 2-11-Emirdağ Lâhikası - II s.190_210.txt',
    'Emirdağ Lâhikası 2-12-Emirdağ Lâhikası - II s.210_229.txt',
    'Emirdağ Lâhikası 2-13-Emirdağ Lâhikası - II s.230_247.txt'
  ];
  static final isaratulICaz = [
    'İşaratü\'l-i\'caz-01-Tenbih.txt',
    'İşaratü\'l-i\'caz-02-İfadetü\'l Meram.txt',
    'İşaratü\'l-i\'caz-03-Kur\'an\'ın Tarifi.txt',
    'İşaratü\'l-i\'caz-04-Fatiha Suresi.txt',
    'İşaratü\'l-i\'caz-05-Bakara Suresi 1, 2, 3. âyetler.txt',
    'İşaratü\'l-i\'caz-06-Bakara Suresi 4,5. âyetler.txt',
    'İşaratü\'l-i\'caz-07-Bakara Suresi 6. âyet.txt',
    'İşaratü\'l-i\'caz-08-Bakara Suresi 7. âyet.txt',
    'İşaratü\'l-i\'caz-09-Bakara Suresi 8. âyet.txt',
    'İşaratü\'l-i\'caz-10-Bakara Suresi 9,10. âyetler.txt',
    'İşaratü\'l-i\'caz-11-Bakara Suresi 11,12. âyetler.txt',
    'İşaratü\'l-i\'caz-12-Bakara Suresi 13. âyet.txt',
    'İşaratü\'l-i\'caz-13-Bakara Suresi 14,15. âyetler.txt',
    'İşaratü\'l-i\'caz-14-Bakara Suresi 16. âyet.txt',
    'İşaratü\'l-i\'caz-15-Bakara Suresi 17,18,19,20. âyetler.txt',
    'İşaratü\'l-i\'caz-16-Bakara Suresi 21,22. âyetler.txt',
    'İşaratü\'l-i\'caz-17-Bakara Suresi 23,24. âyetler.txt',
    'İşaratü\'l-i\'caz-18-Bakara Suresi 25. âyet.txt',
    'İşaratü\'l-i\'caz-19-Bakara Suresi 26,27. âyetler.txt',
    'İşaratü\'l-i\'caz-20-Bakara Suresi 28. âyet.txt',
    'İşaratü\'l-i\'caz-21-Bakara Suresi 29. âyet.txt',
    'İşaratü\'l-i\'caz-22-Bakara Suresi 30. âyet.txt',
    'İşaratü\'l-i\'caz-23-Bakara Suresi 31,32,33. âyetler.txt',
    'İşaratü\'l-i\'caz-24-Ecnebi Feylesofların Kur\'an Hakkındaki Beyanatları.txt',
    'İşaratü\'l-i\'caz-25-Mehmed Kayalar\'ın Bir Müdafaası.txt',
    'İşaratü\'l-i\'caz-26-Dua (İşaratü\'l İ\'caz).txt',
    'İşaratü\'l-i\'caz-27-Fihrist (İşaratü\'l İ\'caz).txt'
  ];

  static final kastamonuLahikasi = [
    'Kastamonu Lâhikası-01-Kastamonu Lâhikası - Takdim.txt',
    'Kastamonu Lâhikası-02-Kastamonu Lâhikası s.10_30.txt',
    'Kastamonu Lâhikası-03-Kastamonu Lâhikası s.30_51.txt',
    'Kastamonu Lâhikası-04-Kastamonu Lâhikası s.52_69.txt',
    'Kastamonu Lâhikası-05-Kastamonu Lâhikası s.70_91.txt',
    'Kastamonu Lâhikası-06-Kastamonu Lâhikası s.91_109.txt',
    'Kastamonu Lâhikası-07-Kastamonu Lâhikası s.110_129.txt',
    'Kastamonu Lâhikası-08-Kastamonu Lâhikası s.130_149.txt',
    'Kastamonu Lâhikası-09-Kastamonu Lâhikası s.150_166 (Lemaat\'tan).txt',
    'Kastamonu Lâhikası-10-Kastamonu Lâhikası s.167_189.txt',
    'Kastamonu Lâhikası-11-Kastamonu Lâhikası s.190_210.txt',
    'Kastamonu Lâhikası-12-Kastamonu Lâhikası s.211_230.txt',
    'Kastamonu Lâhikası-13-Kastamonu Lâhikası s.231_255.txt'
  ];

  static final lemalar = [
    'Lem\'alar-01-Birinci Lem\'a.txt',
    'Lem\'alar-02-İkinci Lem\'a.txt',
    'Lem\'alar-03-Üçüncü Lem\'a.txt',
    'Lem\'alar-04-Dördüncü Lem\'a.txt',
    'Lem\'alar-05-Beşinci Lem\'a.txt',
    'Lem\'alar-06-Altıncı Lem\'a.txt',
    'Lem\'alar-07-Yedinci Lem\'a.txt',
    'Lem\'alar-08-Sekizinci Lem\'a.txt',
    'Lem\'alar-09-Dokuzuncu Lem\'a.txt',
    'Lem\'alar-10-Onuncu Lem\'a.txt',
    'Lem\'alar-11-On Birinci Lem\'a.txt',
    'Lem\'alar-12-On İkinci Lem\'a.txt',
    'Lem\'alar-13-On Üçüncü Lem\'a.txt',
    'Lem\'alar-14-On Dördüncü Lem\'a.txt',
    'Lem\'alar-15-On Beşinci Lem\'a.txt',
    'Lem\'alar-16-On Altıncı Lem\'a.txt',
    'Lem\'alar-17-On Yedinci Lem\'a.txt',
    'Lem\'alar-18-On Sekizinci Lem\'a.txt',
    'Lem\'alar-19-On Dokuzuncu Lem\'a.txt',
    'Lem\'alar-20-Yirminci Lem\'a.txt',
    'Lem\'alar-21-Yirmi Birinci Lem\'a.txt',
    'Lem\'alar-22-Yirmi İkinci Lem\'a.txt',
    'Lem\'alar-23-Yirmi Üçüncü Lem\'a.txt',
    'Lem\'alar-24-Yirmi Dördüncü Lem\'a.txt',
    'Lem\'alar-25-Yirmi Beşinci Lem\'a.txt',
    'Lem\'alar-26-Yirmi Altıncı Lem\'a.txt',
    'Lem\'alar-27-Yirmi Yedinci Lem\'a.txt',
    'Lem\'alar-28-Yirmi Sekizinci Lem\'a.txt',
    'Lem\'alar-29-Yirmi Dokuzuncu Lem\'a.txt',
    'Lem\'alar-30-Otuzuncu Lem\'a.txt',
    'Lem\'alar-31-Otuz Birinci Lem\'a.txt',
    'Lem\'alar-32-Otuz İkinci Lem\'a.txt',
    'Lem\'alar-33-Otuz Üçüncü Lem\'a.txt',
    'Lem\'alar-34-Münâcat (Lem\'alar).txt',
    'Lem\'alar-35-Fihrist (Lem\'alar).txt',
    'Lem\'alar-36-Dua (Lem\'alar).txt'
  ];

  static final mektubat = [
    'Mektubat-01-Birinci Mektup.txt',
    'Mektubat-02-İkinci Mektup.txt',
    'Mektubat-03-Üçüncü Mektup.txt',
    'Mektubat-04-Dördüncü Mektup.txt',
    'Mektubat-05-Beşinci Mektup.txt',
    'Mektubat-06-Altıncı Mektup.txt',
    'Mektubat-07-Yedinci Mektup.txt',
    'Mektubat-08-Sekizinci Mektup.txt',
    'Mektubat-09-Dokuzuncu Mektup.txt',
    'Mektubat-10-Onuncu Mektup.txt',
    'Mektubat-11-On Birinci Mektup.txt',
    'Mektubat-12-On İkinci Mektup.txt',
    'Mektubat-13-On Üçüncü Mektup.txt',
    'Mektubat-14-On Dördüncü Mektup.txt',
    'Mektubat-15-On Beşinci Mektup.txt',
    'Mektubat-16-On Altıncı Mektup.txt',
    'Mektubat-17-On Yedinci Mektup.txt',
    'Mektubat-18-On Sekizinci Mektup.txt',
    'Mektubat-19-On Dokuzuncu Mektup.txt',
    'Mektubat-20-Yirminci Mektup.txt',
    'Mektubat-21-Yirmi Birinci Mektup.txt',
    'Mektubat-22-Yirmi İkinci Mektup.txt',
    'Mektubat-23-Yirmi Üçüncü Mektup.txt',
    'Mektubat-24-Yirmi Dördüncü Mektup.txt',
    'Mektubat-25-Yirmi Beşinci Mektup.txt',
    'Mektubat-26-Yirmi Altıncı Mektup.txt',
    'Mektubat-27-Yirmi Yedinci Mektup.txt',
    'Mektubat-28-Yirmi Sekizinci Mektup.txt',
    'Mektubat-29-Yirmi Dokuzuncu Mektup.txt',
    'Mektubat-30-Otuzuncu Mektup.txt',
    'Mektubat-31-Otuz Birinci Mektup.txt',
    'Mektubat-32-Otuz İkinci Mektup.txt',
    'Mektubat-33-Otuz Üçüncü Mektup.txt',
    'Mektubat-34-İşarat ı Gaybiye Hakkında Bir Takriz.txt',
    'Mektubat-35-Hakikat Çekirdekleri.txt',
    'Mektubat-36-Gönüller Fatihi Büyük Üstada.txt',
    'Mektubat-37-Fihriste_i Mektubat.txt',
    'Mektubat-38-Hakikat Işıkları.txt',
    'Mektubat-39-Dua (Mektubat).txt'
  ];

  static final sualar = [
    'Şuâlar-01-Birinci Şuâ.txt',
    'Şuâlar-02-İkinci Şuâ.txt',
    'Şuâlar-03-Üçüncü Şuâ.txt',
    'Şuâlar-04-Dördüncü Şuâ.txt',
    'Şuâlar-05-Beşinci Şuâ.txt',
    'Şuâlar-06-Altıncı Şuâ.txt',
    'Şuâlar-07-Yedinci Şuâ.txt',
    'Şuâlar-08-Sekizinci Şuâ.txt',
    'Şuâlar-09-Dokuzuncu Şuâ.txt',
    'Şuâlar-10-On Birinci Şuâ.txt',
    'Şuâlar-11-On İkinci Şuâ.txt',
    'Şuâlar-12-On Üçüncü Şuâ.txt',
    'Şuâlar-13-On Dördüncü Şuâ.txt',
    'Şuâlar-14-On Beşinci Şuâ.txt',
    'Şuâlar-15-Yirmi Dokuzuncu Lem\'a\'dan İkinci Bab.txt',
    'Şuâlar-16-Eddâî.txt',
    'Şuâlar-17-Dua (Şuâlar).txt',
    'Şuâlar-18-İçindekiler (Şuâlar).txt'
  ];

  static final mesneviiNuriye = [
    'Mesnevî-i Nuriye-01-İ\'tizar.txt',
    'Mesnevî-i Nuriye-02-Mukaddime.txt',
    'Mesnevî-i Nuriye-03-Lem\'alar Risalesi.txt',
    'Mesnevî-i Nuriye-04-Reşhalar.txt',
    'Mesnevî-i Nuriye-05-Lâsiyyemalar.txt',
    'Mesnevî-i Nuriye-06-Katre.txt',
    'Mesnevî-i Nuriye-07-Hubab.txt',
    'Mesnevî-i Nuriye-08-Habbe.txt',
    'Mesnevî-i Nuriye-09-Zühre.txt',
    'Mesnevî-i Nuriye-10-Zerre.txt',
    'Mesnevî-i Nuriye-11-Şemme Risalesi.txt',
    'Mesnevî-i Nuriye-12-Onuncu Risale.txt',
    'Mesnevî-i Nuriye-13-Şule.txt',
    'Mesnevî-i Nuriye-14-Nokta.txt',
    'Mesnevî-i Nuriye-15-Münderecat Hakkında.txt',
    'Mesnevî-i Nuriye-16-Fihrist (Mesnevî).txt'
  ];

  static final muhakemat = [
    'Muhakemat-01-Giriş.txt',
    'Muhakemat-02-Birinci Makale.txt',
    'Muhakemat-03-İkinci Makale.txt',
    'Muhakemat-04-Üçüncü Makale.txt',
    'Muhakemat-05-Fihrist (Muhakemat).txt',
    'Muhakemat-06-Takriz.txt'
  ];

  static final sikkeiTasdikiGaybi = [
    'Sikke-i Tasdik-i Gaybî-01-Parlak Fıkralar ve Güzel Mektuplar 1.txt',
    'Sikke-i Tasdik-i Gaybî-02-Birinci Şuâ.txt',
    'Sikke-i Tasdik-i Gaybî-03-Sekizinci Şuâ.txt',
    'Sikke-i Tasdik-i Gaybî-04-On Sekizinci Lem\'a.txt',
    'Sikke-i Tasdik-i Gaybî-05-Yirmi Sekizinci Lem\'a.txt',
    'Sikke-i Tasdik-i Gaybî-06-Sekizinci Lem\'a.txt',
    'Sikke-i Tasdik-i Gaybî-07-Parlak Fıkralar ve Güzel Mektuplar 2.txt',
    'Sikke-i Tasdik-i Gaybî-08-Dua (Sikke_i Tasdik_i Gaybî).txt'
  ];

  static final tarihceiHayat = [
    'Tarihçe-i Hayat-01-Ön söz.txt',
    'Tarihçe-i Hayat-02-Giriş.txt',
    'Tarihçe-i Hayat-03-İlk Hayatı.txt',
    'Tarihçe-i Hayat-04-Barla Hayatı.txt',
    'Tarihçe-i Hayat-05-Eskişehir Hayatı.txt',
    'Tarihçe-i Hayat-06-Kastamonu Hayatı.txt',
    'Tarihçe-i Hayat-07-Denizli Hayatı.txt',
    'Tarihçe-i Hayat-08-Emirdağ Hayatı.txt',
    'Tarihçe-i Hayat-09-Afyon Hayatı.txt',
    'Tarihçe-i Hayat-10-Isparta Hayatı.txt',
    'Tarihçe-i Hayat-11-Hariç Memleketler.txt',
    'Tarihçe-i Hayat-12-Bedîüzzaman ve Risale i Nur.txt',
    'Tarihçe-i Hayat-13-Dua (Tarihçe i Hayatı).txt',
    'Tarihçe-i Hayat-14-İçindekiler.txt'
  ];

  static final littleBooksLabel = "Küçük Kitaplar";

  static final littleBooks = [
    'Tulûat.txt',
    'Gençli̇k Rehberi̇.txt',
    'Hanimlar Rehberi̇.txt',
    'Hutbe-i̇ Şami̇ye.txt',
    'İşarat.txt',
    'Konferans.txt',
    'Münazarat.txt',
    'Nur Çeşmesi̇.txt',
    'Nur\'un İlk Kapısı.txt',
    'Sünuhat.txt',
    'Di̇van-i Harb-i̇ Örfî.txt'
  ];

  static final sozler = [
    "Sözler-01-Birinci Söz.txt",
    "Sözler-02-İkinci Söz.txt",
    "Sözler-03-Üçüncü Söz.txt",
    "Sözler-04-Dördüncü Söz.txt",
    "Sözler-05-Beşinci Söz.txt",
    "Sözler-06-Altıncı Söz.txt",
    "Sözler-07-Yedinci Söz.txt",
    "Sözler-08-Sekizinci Söz.txt",
    "Sözler-09-Dokuzuncu Söz.txt",
    "Sözler-10-Onuncu Söz.txt",
    "Sözler-11-On Birinci Söz.txt",
    "Sözler-12-On İkinci Söz.txt",
    "Sözler-13-On Üçüncü Söz.txt",
    "Sözler-14-On Dördüncü Söz.txt",
    "Sözler-15-On Beşinci Söz.txt",
    "Sözler-16-On Altıncı Söz.txt",
    "Sözler-17-On Yedinci Söz.txt",
    "Sözler-18-On Sekizinci Söz.txt",
    "Sözler-19-On Dokuzuncu Söz.txt",
    "Sözler-20-Yirminci Söz.txt",
    "Sözler-21-Yirmi Birinci Söz.txt",
    "Sözler-22-Yirmi İkinci Söz.txt",
    "Sözler-23-Yirmi Üçüncü Söz.txt",
    "Sözler-24-Yirmi Dördüncü Söz.txt",
    "Sözler-25-Yirmi Beşinci Söz.txt",
    "Sözler-26-Yirmi Altıncı Söz.txt",
    "Sözler-27-Yirmi Yedinci Söz.txt",
    "Sözler-28-Yirmi Sekizinci Söz.txt",
    "Sözler-29-Yirmi Dokuzuncu Söz.txt",
    "Sözler-30-Otuzuncu Söz.txt",
    "Sözler-31-Otuz Birinci Söz.txt",
    "Sözler-32-Otuz İkinci Söz.txt",
    "Sözler-33-Otuz Üçüncü Söz.txt",
    "Sözler-34-Lemaat (Sözler).txt",
    "Sözler-35-Konferans (Sözler).txt",
    "Sözler-36-Fihrist (Sözler).txt",
  ];
}
