App::Conf.default(

	routes: {
		dashboard: {get:'/dashboard', to:'dashboard:dashboard:index'},
		login: {[:get,:post]=>'/login', to:'dashboard:dashboard:login'},
		logout: {get:'/logout', to:'dashboard:dashboard:logout'},
	},
	assets: [
		{ action: 'dashboard:dashboard:login',
			files: %w(#layout /js/login.rb /css/login.sass) },
    { action: 'dashboard:dashboard:index',
      files: %w(#layout /js/login.rb /css/index.sass) }
	]
)