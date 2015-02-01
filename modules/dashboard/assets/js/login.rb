error_map = {
	'login_username'=> {
		'display'=>'#login_username', 'position'=>'top'
	},
	'login_password'=> {
		'display'=>'#login_password', 'position'=>'top'
	},
}

login_form = Element.find 'form[name="login"]'
`Validator`.(login_form.to_n, error_map.to_n)