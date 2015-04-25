class Auth::Commands::LoadFixtures < Neo::Command
  Cypher = Neo::Database::Cypher

  def run
    Cypher.new.query('OPTIONAL MATCH (n:$)-[r]-(m:$) DELETE n,r,m').run
    Cypher.new.query('MATCH (n:$) DELETE n').run

    fixtures = Neo::Fixture.new(
      paths: fixture_files(['roles.yml'], in_path: 'modules/auth/fixtures'),
      sort_cols: {'Auth/Role'=> ['name']}
    )

    fixtures.load
  end

  private

  def fixture_files(files, in_path:)
    files.map{|path| File.join Neo.app_dir, in_path, path}
  end
end