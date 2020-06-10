# frozen_string_literal: true

require 'rubygems'
require 'watir'
require 'webdrivers'
require 'nokogiri'

# BankPage class
class BankPage
  attr_reader :browser
  attr_reader :page
  def initialize
    @browser = Watir::Browser.new
    @browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
    @browser.button(name: 'customer_type').click
    load_page
  end

  def load_page
    @page = Nokogiri::HTML(@browser.html)
  end
end
