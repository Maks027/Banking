require 'rubygems'
require 'watir'
require 'webdrivers'
require 'monetize'
require 'money'
# require 'nokogiri'
# require 'open-uri'
Monetize.assume_from_symbol = true

def balance(br)
  br
    .li(data_semantic:'header-available-balance')
    .div(data_semantic: 'value')
    .span(data_semantic: 'header-available-balance-amount')
    .text_content
end

def acc_name(br)
  br.h2(data_semantic: 'account-name').text_content
end

def new_browser
  browser = Watir::Browser.new
  browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
  browser.button(name: 'customer_type').click
  return browser
end

br = new_browser

fileName = 'account.json'
file = File.open(fileName, 'w')

acc_lis = br.lis(data_semantic: 'account-item')

acc_hash = []

acc_lis.each do |l|
  l.click
  balance(br)
  acc_money = balance(br).to_money
  acc_info = { name: acc_name(br),
               currency: acc_money.currency.to_s,
               balance: acc_money.to_f }
  acc_hash << acc_info
end

h = {account: acc_hash}

file.puts JSON.pretty_generate(h)

br.close
