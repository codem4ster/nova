App::Conf.default(
  env: 'dev',
  default_module: 'site',
  default_template_engine: 'slim',
  lang: 'TrTr',

  routes: {
	  home: {get:'/', to:'site:site:index', position: 0},
    about_us: {get: '/hakkimizda?/\d+', to:'site:site:about_us'},
    contact: {[:get,:post]=>'/iletisim', to:'site:site:contact'},
    api: {get:'//api.site.com', to:'api:api:index', position: :last}
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