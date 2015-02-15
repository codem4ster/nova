class Auth::Forms::Login < Neo::Form
	Member = Auth::Models::Member

	def initialize
		super(
			name: 'login',
			method: 'post',
			inputs: [
				{name: 'username', type: 'textfield', label:'Kullanıcı Adı :',  attr: {class:''},
					validations: {required:{}}},
				{name: 'password', type: 'password', label:'Şifre :',  attr: {class:''},
					validations: {required:{}}},
				{name: 'giris', type: 'submit', value:'Gönder', attr: {class:'button padded pull-right info'}}
			]
		)
	end

	def authenticate
		is_authed = Member.authenticate(username.value, password.value)
		@errors[:form] << Neo.trn('Invalid username or password') unless is_authed
		is_authed
	end
end