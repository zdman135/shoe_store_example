require 'rubygems'
require 'taza/page'

module Dashboard
  class Navigation < ::Taza::Page
    element(:month_link) { |month_name| browser.link(text: month_name) }

    def select_month(month_name)
      month_link(month_name).when_present.click
    end
  end
end