require 'prettyprint'

module Site
  module Controllers
    class Site < Main::Controllers::Main

      def index_action
        resp = {}
        resp[:title]  = "#{@main_title} - Anasayfa"
        render resp
      end

    end
  end
end