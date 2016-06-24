require 'rubygems'
require 'taza'

# not currently using any models or factories
Dir["#{File.dirname(__FILE__)}/dashboard/models/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/dashboard/factories/*.rb"].each {|f| require f}

module Dashboard
  include ForwardInitialization

  class Dashboard < ::Taza::Site

    def close
      browser.close
    end
  end
end
