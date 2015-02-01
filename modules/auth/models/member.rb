class Auth::Models::Member < Auth::Models::User
  MemberQuery = Auth::Models::MemberQuery

  attr_accessor :username, :email, :password, :salt, :active
  attr_accessor :activation_code, :pass_requested_at, :pass_request_code
  attr_accessor :hidden_answer, :last_login, :signed_at

  def initialize
    @labels = 'User:Member'
  end

end
