App::Conf.default(
  asset_sets: {
    layout: %w(/layout/css/layout.sass /layout/js/jquery.js /layout/js/jsm.js)
  },
  assets: [
    { action: 'site:site:about_us',
      files: %w(#layout /css/about_us.sass) },

  ]
)