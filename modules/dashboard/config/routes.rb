App::Conf.default(
	routes: {
		dashboard: %w( /dashboard / dashboard:dashboard:index get ),
		login: %w( /login / dashboard:dashboard:login get,post ),
    logout: %w( /logout / dashboard:dashboard:logout get)
	},
	assets: [
		{ action: 'dashboard:dashboard:login',
			files: %w(#layout /js/login.rb /css/login.sass) },
    { action: 'dashboard:dashboard:index',
      files: %w(#layout /js/login.rb /css/index.sass) }
	]
)