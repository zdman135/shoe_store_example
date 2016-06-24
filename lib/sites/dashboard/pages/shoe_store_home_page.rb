require 'taza/page'

module Dashboard
  class ShoeStoreHomePage < Taza::Page
    element(:reminder_email_field) { browser.text_field(id: 'remind_email_input') }
    element(:submit_email) { browser.button(type: 'submit') }

    def reminder_email(email)
      reminder_email_field.when_present.send_keys email
    end
  end
end