# frozen_string_literal: true

require 'rubygems'
require 'watir'
require 'webdrivers'
require 'monetize'
require 'money'

# Browser class
class Browser
  def initialize
    @browser = Watir::Browser.new
    @browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
    @browser.button(name: 'customer_type').click
    Monetize.assume_from_symbol = true
  end

  def balance_str
    bal = @browser
          .li(data_semantic:'header-available-balance')
          .div(data_semantic: 'value')
          .span(data_semantic: 'header-available-balance-amount')
          .text_content
    bal
  end

  def balance
    balance_str.to_money.to_f
  end

  def currency
    balance_str.to_money.currency.to_s
  end

  def name
    @browser.h2(data_semantic: 'account-name').text_content
  end

  def accounts
    @browser.lis(data_semantic: 'account-item')
  end
end
