When(/^I add an "(.*?)" reminder$/) do |email|
  @dashboard.shoe_store_home_page.reminder_email(email)
  @dashboard.shoe_store_home_page.submit_email.click
end

Then(/^I will see a success notification with my "(.*?)" displayed$/) do |email|
  Watir::Wait.until(15, 'Success notification element did not appear') { @dashboard.notifications.reminder_email_success.present? }
  @dashboard.notifications.reminder_email_success.text.should eql "Thanks! We will notify you of our new shoes at this email: #{email}"
end