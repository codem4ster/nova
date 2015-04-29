App::Conf.default(
  asset_sets: {
    opal: %w(/layout/js/jquery-1.11.2.min.js),
    groundwork: %w(/layout/groundwork/css/groundwork.css /layout/groundwork/js/libs/modernizr-2.6.2.min.js /layout/groundwork/js/groundwork.all.js),
	  tooltipster: %w{/layout/tooltipster/css/themes/tooltipster-error.css /layout/tooltipster/css/tooltipster.css /layout/tooltipster/js/jquery.tooltipster.min.js},
	  libs: %w(#tooltipster /layout/jquery/jquery.validate.min.js /layout/js/libs/validator.coffee),
    layout: %w(#opal #groundwork #libs)
  },
  assets: []
)