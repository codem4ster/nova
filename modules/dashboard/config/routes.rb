App::Conf.default(
	routes: {
		dashboard: %w( /dashboard / dashboard:dashboard:index get ),
		login: %w( /login / dashboard:dashboard:login get,post )
	},
	assets: [
		{ action: 'dashboard:dashboard:index',
			files: %w(#opal /js/dashboard.rb) },
		{ action: 'dashboard:dashboard:login',
			files: %w(#opal #groundwork /js/login.rb /css/login.sass) }
	]
)