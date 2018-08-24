Before do
  @dashboard = Dashboard.new

  if ENV['BROWSER'] == 'ie'
    @dashboard.browser.window.resize_to(2024,1024)
    @dashboard.browser.window.maximize
    @dashboard.browser.execute_script('localStorage.clear();')
    @dashboard.browser.execute_script('sessionStorage.clear();')
  else
    # chrome security setting now prevents this on default
    # if using change this setting
    # @dashboard.browser.execute_script('window.localStorage.clear();')
  end

  if ENV['BROWSER'] == 'chrome'
    @dashboard.browser.window.resize_to(2024,1024)
    @dashboard.browser.window.maximize
  end
end

After do |scenario|
  if (scenario.failed?)
    screen = @dashboard.browser.screenshot.base64
    embed "data:image/gif;base64,#{screen}", 'image/png'
  end
  @dashboard.close
end