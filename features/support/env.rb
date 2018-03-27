require 'selenium-webdriver'
require 'capybara/cucumber'
require 'rspec/expectations'
require 'site_prism'
require 'capybara/poltergeist'
require 'appium_capybara'
require 'pry'


def appium_caps
    {
      'Nexus 5'=> { platformName: "android", deviceName: "Nexus 5", versionNumber: "6.0", browserName: "Chrome" },
      'SGS 6'=> { platformName: "android", deviceName: "02157df23bc41912", versionNumber: "5.1.1", browserName: "Chrome" },
      'Hive CI' => { platformName: 'Android', deviceName: ENV['ADB_DEVICE_ARG'], udid: ENV['ADB_DEVICE_ARG'], automationName: 'Appium', browserName: ENV['BROWSER'] }
    }
end

Capybara.register_driver :appium do |app|
  caps = ENV['HIVE'] == 'true' ? appium_caps.fetch('Hive CI') : appium_caps.fetch('Nexus 5')
  appium_port = ENV['APPIUM_PORT'] || '4723'
  puts caps.to_s
  url = "http://localhost:#{appium_port}/wd/hub/" # Url to your running appium server
  appium_lib_options = { server_url: url }
  all_options = { appium_lib:  appium_lib_options, caps: caps }
  Appium::Capybara::Driver.new app, all_options
end

Capybara.default_driver = :appium
