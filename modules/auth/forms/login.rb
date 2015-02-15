class Auth::Forms::Login < Neo::Form
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
		@errors[:form] << Neo.trn('Invalid username or password')
	end
end