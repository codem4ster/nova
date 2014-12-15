require '../parameters'
require $neo_dir+'/neo'
class Index
  def call (env)
    Neo.app_dir = $app_dir
    Neo.dir = $neo_dir
    Neo.server_vars = env
    Neo.run
    Neo.http_response
  end
end