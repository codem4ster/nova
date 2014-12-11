module Loader


  @cypher = Neo::Database::Cypher
  @admin = ::User::Models::Admin
  @admin_query = ::User::Models::AdminQuery
  @member = ::User::Models::Member
  @member_query = ::User::Models::MemberQuery
  @operator = ::User::Models::Operator
  @operator_query = ::User::Models::OperatorQuery
  @user = ::User::Models::User
  @user_query = ::User::Models::UserQuery

  @session = Neo.req.session

  def clear_db
    @cypher.new.query('OPTIONAL MATCH (n:@)-[r]-(m:@) DELETE n,r,m').run
    @cypher.new.query('MATCH (n:@) DELETE n').run
  end
end