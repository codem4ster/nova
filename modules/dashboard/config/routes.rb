App::Conf.default(
	routes: {
		dashboard: %w( /dashboard / dashboard:dashboard:index get ),
		login: %w( /login / dashboard:dashboard:login get,post )
	},
	assets: [
		{ action: 'dashboard:dashboard:login',
			files: %w(#layout /js/login.rb /css/login.sass) }
	]
)