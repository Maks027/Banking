# frozen_string_literal: true

require 'rubygems'
require 'watir'
require 'webdrivers'
require 'nokogiri'

# BankPage class
class BankPage
  attr_reader :browser
  attr_reader :page
  # Opens the Chrome browser, accesses main bank page and logs into personal account
  def initialize
    @browser = Watir::Browser.new
    puts 'Trying to open https://demo.bendigobank.com.au/banking/sign_in'
    @browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
    puts '>Page successfully loaded'
    puts 'Trying to log in'
    @browser.button(name: 'customer_type').click
    puts '>Successfully logged in'
    load_page
  end

  # Converts current html loaded by Watir to Nokogiri object
  def load_page
    @page = Nokogiri::HTML(@browser.html)
  end
end
