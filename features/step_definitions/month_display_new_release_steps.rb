Given(/^I am on the shoe store site$/) do
  expect(@dashboard.browser.url).to eql('http://shoestore-manheim.rhcloud.com/')
  expect(@dashboard.browser.title).to eql('Shoe Store: Welcome to the Shoe Store')
end

When(/^I check the month of "(.*?)"$/) do |month|
  @dashboard.navigation.select_month(month)
  @shoe_list = @dashboard.shoes_page.shoe_list
end

Then(/^I should see a description and image and price for each shoe$/) do
  @shoe_list.each do |check_shoe|
  expect(@dashboard.shoes_page.check_shoe_description(check_shoe)).to exist
  expect(@dashboard.shoes_page.check_shoe_image(check_shoe)).to exist
  expect(@dashboard.shoes_page.check_shoe_price(check_shoe)).to exist
  @dashboard.shoes_page.check_shoe_price(check_shoe).text.should include '$'
  end
end