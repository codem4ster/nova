App::Conf.default(
  env: 'prod',
  gem_path: '/home/cm/.rvm/gems/ruby-2.1.4@global/',
  default_module: 'site',
  default_template_engine: 'slim',
  lang: 'TrTr',

  routes: {
    home: %w( / / site:site:index get ),
    about_us: %w( /hakkimizda / site:site:about_us get ),
    contact: %w( /iletisim / site:site:contact get ),

    api: %w( /api / api:api:index get ),
  },
  db: {
    name: '`>Nova`',
    host: '127.0.0.1',
    port: 7474,
    auth_key: '725a2651b5c0244f237ace48f8eec946'
  },
  mail: {
    from: 'burak@netvent.com',
    defaults: {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'netvent.com',
      user_name: 'burak@netvent.com',
      password: '14534545',
      authentication: :plain,
      enable_starttls_auto: true
    }
  }
)