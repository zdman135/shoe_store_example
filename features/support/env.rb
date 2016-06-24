require_relative '../../lib/sites/dashboard.rb'

require 'rspec'
require 'pry'
require 'active_record'
require 'factory_girl'
require 'mail'
require 'nokogiri'
require 'httpclient'
require 'os'

I18n.enforce_available_locales = true

# default environment
ENV['TAZA_ENV'] ||= 'isolation'
ENV['BROWSER_PLATFORM'] ||= 'WINDOWS'
(ENV['BROWSER'] ||= 'chrome').downcase
(ENV['DRIVER'] ||= 'watir_webdriver').downcase
ENV['IE_VERSION'] ||= '9'
ENV['FIREFOX_VERSION'] ||= '28'
ENV['CHROME_VERSION'] ||= '34'

#append tools directory to the path for chromedriver
if OS.windows?
  ENV['PATH'] = File.join(File.dirname(__FILE__), '..', '..', 'tools', 'chromedriver', 'windows') + ';' + ENV['PATH']
  ENV['PATH'] = File.join(File.dirname(__FILE__), '..', '..', 'tools', 'iedriverserver') + ';' + ENV['PATH']
elsif OS.mac?
  ENV['PATH'] = File.join(File.dirname(__FILE__), '..', '..', 'tools', 'chromedriver', 'osx') + ':' + ENV['PATH']
elsif OS.linux? && OS.bits == 32
  ENV['PATH'] = File.join(File.dirname(__FILE__), '..', '..', 'tools', 'chromedriver', 'linux_32') + ':' + ENV['PATH']
elsif OS.linux? && OS.bits == 64
  ENV['PATH'] = File.join(File.dirname(__FILE__), '..', '..', 'tools', 'chromedriver', 'linux_64') + ':' + ENV['PATH']
else
  p 'unknown OS'
end