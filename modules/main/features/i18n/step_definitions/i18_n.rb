Given(/^Dil dosyasının İngilizce olduğundan emin ol$/) do
  Neo::I18N.change_lang 'EnEn'
  expect(Neo::Config.main[:lang]).to eq('EnEn')
end

Then(/^(.*) kelimesini (.*) kelimesine çevir$/) do |kelime, ceviri|
  expect(Neo.trn(kelime)).to eq(ceviri)
end

And(/^Dil dosyasına (.*) ve (.*) ekle$/) do |kelime, ceviri_tr|
  Neo::I18N.add 'EnEn', [[kelime, kelime]]
  Neo::I18N.add 'TrTr', [[kelime, ceviri_tr]]
end

When(/^Dili Türkçe'ye çevir$/) do
  Neo::I18N.change_lang 'TrTr'
end