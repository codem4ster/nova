App::Conf.default(
	asset_sets: {
		opal: %w(/layout/js/jquery.js /layout/js/opal.min.js /layout/js/opal.jquery.min.js)
	},
	assets: [
		{ action: 'site:site:index',
			files: %w(#opal /js/test.rb) },

	]
)