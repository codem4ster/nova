#\ -w -p 3000 -E development
working_dir = File.dirname(__FILE__)
Dir.chdir(working_dir)
require './index'

app = Index.new
use Rack::Reloader, 0
use Rack::ContentLength
use Rack::Session::Cookie, :key => 'rack.session', :secret => 'y3ml46y2536tk'
run app