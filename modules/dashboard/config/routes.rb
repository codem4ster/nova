App::Conf.default(
	routes: {
		dashboard: %w( /dashboard / dashboard:dashboard:index get )
	},
	assets: [
		{ action: 'dashboard:dashboard:index',
			files: %w(#opal /js/dashboard.rb) }
	]
)