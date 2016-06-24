module Taza
  class Browser
    def self.create_watir_webdriver(params)
      require 'watir-webdriver'

      if ENV['BROWSER'] == 'chrome'

        # WINDOWS ONLY
        # TODO: try and use chrome profile so we dont have to jump thru hoops for the plugin
        # profile_path =  C:\Users\<user name>\AppData\Local\Google\Chrome\User Data\Default
        # profile_switch = "--user-data-dir=#{profile_path}"
        # need to add this to switches
        # params[:switches] << profile_switch

        browser = Watir::Browser.new params[:browser],
                                     :switches => [params[:switches]]
      elsif ENV['BROWSER'] == 'ie'
        browser = Watir::Browser.new params[:browser]
      elsif ENV['BROWSER'] == 'grid_ie'
        caps = Selenium::WebDriver::Remote::Capabilities.internet_explorer(:version => params[:ie_version],
                                                                           :platform => params[:browser_platform])
        driver = Selenium::WebDriver.for(:remote,
                                         :url => params[:hub_url],
                                         :desired_capabilities => caps)
        browser = Watir::Browser.new driver
      elsif ENV['BROWSER'] == 'grid_chrome'
        caps = Selenium::WebDriver::Remote::Capabilities.chrome(:switches => [params[:switches]],
                                                                :version => params[:chrome_version],
                                                                :platform => params[:browser_platform])
        driver = Selenium::WebDriver.for(:remote,
                                         :url => params[:hub_url],
                                         :desired_capabilities => caps)
        browser = Watir::Browser.new driver
      elsif ENV['BROWSER'] == 'grid_firefox'
        client = Selenium::WebDriver::Remote::Http::Default.new
        client.timeout = 180 # seconds – default is 60
        profile = Selenium::WebDriver::Firefox::Profile.new

        # prevent Firefox from attempting www.X.com whenever X cannot be found
        # disable "domain guessing" http://www-archive.mozilla.org/docs/end-user/domain-guessing.html
        # http://code.google.com/p/selenium/wiki/RubyBindings#Tweaking_Firefox_preferences
        profile['browser.fixup.alternate.enabled'] = false
        # prevents the "Firefox can't find the server at X" message
        # http://newsnorthwoods.blogspot.com/2010/07/firefox-fix-for-server-not-found-error.html
        profile['network.dns.disablePrefetch'] = true
        profile['network.http.connect.timeout'] = 120 # These are attempts to increase the timeout before failing to find a site
        profile['network.http.request.timeout'] = 120 #  NOTE: they don't appear to affect our failures.


        caps = Selenium::WebDriver::Remote::Capabilities.firefox(:firefox_profile => profile,
                                                                 :version => params[:firefox_version],
                                                                 :platform => params[:browser_platform])
        driver = Selenium::WebDriver.for(:remote,
                                         :url => params[:hub_url],
                                         :desired_capabilities => caps,
                                         :http_client => client)
        #driver.manage.timeouts.page_load = 120
        browser = Watir::Browser.new driver
      elsif ENV['BROWSER'] == 'android'
        browser = Watir::Browser.new params[:browser]
      elsif ENV['BROWSER'] == 'iphone'
        browser = Watir::Browser.new params[:browser]
        # elsif ENV['BROWSER'] == 'perf'
        #   profile = Selenium::WebDriver::Firefox::Profile.new
        #   profile.native_events = true
        #   profile.add_extension File.expand_path("../../../../tools/extensions/firebug-1.11.2.xpi", __FILE__)
        #   profile.add_extension File.expand_path("../../../../tools/extensions/fireStarter-0.1a6.xpi", __FILE__)
        #   profile.add_extension File.expand_path("../../../../tools/extensions/netExport-0.9b3.xpi", __FILE__)
        #   profile.add_extension File.expand_path("../../../../tools/extensions/JSErrorCollector.xpi", __FILE__)
        #   profile['extensions.firebug.currentVersion'] = "1.11.2"
        #   profile['extensions.firebug.allPagesActivation'] = "on"
        #   profile['extensions.firebug.activateSameOrigin'] = true
        #   profile['extensions.firebug.framePosition'] = "bottom"
        #   profile['extensions.firebug.previousPlacement'] = 1
        #   profile['extensions.firebug.net.enableSites'] = true
        #   profile['extensions.firebug.addonBarOpened'] = true
        #   profile['extensions.firebug.console.enableSites'] = true
        #   profile['extensions.firebug.defaultPanelName'] = "net"
        #   profile['extensions.firebug.netexport.alwaysEnableAutoExport'] = true
        #   profile['extensions.firebug.netexport.autoExportToFile'] = true
        #   #profile['extensions.firebug.netexport.beaconServerURL'] = 'http://localhost/showslow/beacon/har/'
        #   profile['extensions.firebug.netexport.defaultLogDir'] = File.expand_path("../../../../performance_out/", __FILE__)
        #   profile = add_firefox_download_directory profile
        #   browser = Watir::Browser.new :firefox, :profile => profile
      elsif ENV['BROWSER'] == 'firefox'
        # profile = add_firefox_download_directory(params[:profile])
        # profile.add_extension File.expand_path("../../../../tools/extensions/firebug-1.11.2.xpi", __FILE__)
        # profile.add_extension File.expand_path("../../../../tools/extensions/JSErrorCollector.xpi", __FILE__)
        # profile['extensions.firebug.currentVersion'] = "1.9.2"
        browser = Watir::Browser.new params[:browser] #, :profile => profile
      else
        browser = Watir::Browser.new params[:browser]
      end
      browser
    end

  end
end


#OMG SUPER SECRET STUFF HERE!
require 'user-choices'
module Taza
  class Options < UserChoices::Command
    include UserChoices

    def add_sources(builder)
#     builder.add_source(CommandLineSource, :usage, "Usage: ruby #{$0} [options] file1 [file2]")
      builder.add_source(EnvironmentSource,
                         :mapping, {
              :browser => 'BROWSER',
              :driver => 'DRIVER',
              :attach => 'ATTACH',
              :timeout => 'TIMEOUT',
              :server_ip => 'SERVER_IP',
              :server_port => 'SERVER_PORT',
              :browser_platform => 'BROWSER_PLATFORM',
              :ie_version => 'IE_VERSION',
              :firefox_version => 'FIREFOX_VERSION',
              :chrome_version => 'CHROME_VERSION'
          })
      builder.add_source(YamlConfigFileSource, :from_complete_path, Settings.config_file_path)
    end
  end
end
