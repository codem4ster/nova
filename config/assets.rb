App::Conf.default(
  asset_sets: {
      layout: %w(/layout/css/layout.sass /layout/js/jquery.js /layout/js/jsm.js),
      opal: %w(/js/opal.min.js)
  },
  assets: [
    { action: 'site:site:about_us',
      files: %w(#layout /css/about_us.sass) },

    { action: 'site:site:test',
      files: %w(#opal /js/required.rb /js/test.rb) },

    { action: 'site:site:contact',
      files: %w(#layout /css/contact.sass) },

    { action: 'user:user:login',
      files: %w(#layout /css/login.sass) },

    { action: 'user:user:register',
      files: %w(#layout /css/register.sass) },

    { action: 'site:site:index',
      files: %w(#layout /css/index.sass) },

    { action: 'user:user:activation',
      files: %w(#layout /css/activation.sass) },

    { action: 'user:user:forget',
      files: %w(#layout /css/forget.sass) },

    { action: 'user:user:change_password',
      files: %w(#layout /css/change_password.sass) }
  ]
)