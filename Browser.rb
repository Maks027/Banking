require 'rubygems'
require 'watir'
require 'webdrivers'
require 'json'

browser = Watir::Browser.new

browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'

browser.button(name: 'customer_type').click

puts "#{browser.url}"

browser.close
