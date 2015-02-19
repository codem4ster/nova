App::Conf.default(
  env: 'dev',
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
    username: 'neo4j',
    password: '123456'
  },
  mail: {
    from: 'onurelibol@gmail.com',
    defaults: {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      user_name: 'onurelibol@gmail.com',
      password: '123456',
      authentication: :plain,
      enable_starttls_auto: true
    }
  }
)