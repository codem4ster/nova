App::Conf.prod(
  prod: {
    errors: {
      e404: ['Main:Errors:e404', {errMsg: 'Sayfa Bulunamadı'}],
      e500: ['Main:Errors:e500', {errMsg: 'Sunucu Hatası'}]
    }
  }
)
