require 'selenium-webdriver'
require 'capybara/cucumber'
require 'rspec/expectations'
require 'site_prism'
require 'capybara/poltergeist'
require 'appium_capybara'
require 'pry'


def appium_caps
  {
    'Nexus5'=> { platformName: "android", deviceName: "Nexus 5", versionNumber: "5.1", browserName: "Chrome"},
    'SGS 6'=> { platformName: "android", deviceName: "02157df23bc41912", versionNumber: "5.1.1", browserName: "chrome"}
  }
end


Capybara.register_driver :appium do |app|
  puts "in it"
  caps = appium_caps.fetch('SGS 6')
  puts "#{caps}"
  desired_caps = caps
  url = "http://127.0.0.1:4723/wd/hub/" # Url to your running appium server
  appium_lib_options = { server_url: url }
  all_options = { appium_lib:  appium_lib_options, caps: desired_caps }
  Appium::Capybara::Driver.new app, all_options
end

Capybara.default_driver = :appium



