Feature: I18N
  Hem modüllerde hem de Neo tarafında çeviri dosyaları düzgün şekilde çalışıyor mu test edelim

  Scenario Outline: Neo yüklendikten sonra dil değiştirilmesi
    Given Dil dosyasının İngilizce olduğundan emin ol
    # İngilizceden İngilizceye çevrildiği için aynı kelime grubunu döndürmesi gerekli
    Then <kelime> kelimesini <kelime> kelimesine çevir
    And Dil dosyasına <kelime2> ve <ceviri_tr> ekle
    Then <kelime2> kelimesini <kelime2> kelimesine çevir
    When Dili Türkçe'ye çevir
    Then <kelime2> kelimesini <ceviri_tr> kelimesine çevir
  Examples:
    | kelime                             | kelime2 | ceviri_tr |
    | Please enter a valid email address | Try     | Deneme    |
