require 'rubygems'
require 'taza/page'

module Dashboard
  class Notifications < ::Taza::Page
    element(:reminder_email_success) { browser.div(id: 'flash') }
  end
end
