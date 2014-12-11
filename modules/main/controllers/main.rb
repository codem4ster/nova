module Main
  module Controllers
    class Main < Neo::Controller
      def initialize
        @layout = 'main::layout'
        @main_title = 'My Application'
      end
    end
  end
end