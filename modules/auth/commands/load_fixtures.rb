class Auth::Commands::LoadFixtures < Neo::Command
	Cypher = Neo::Database::Cypher

  def run
	  Cypher.new.query('OPTIONAL MATCH (n:$)-[r]-(m:$) DELETE n,r,m').run
	  Cypher.new.query('MATCH (n:$) DELETE n').run

    fixture_paths = [
      'roles.yml'
    ].map{|path| File.join Neo.app_dir, 'modules/auth/fixtures', path}

    fixtures = Neo::Fixture.new(
	    paths: fixture_paths,
	    sort_cols: {'Auth/Role'=> ['name']}
    )

    fixtures.load
  end
end