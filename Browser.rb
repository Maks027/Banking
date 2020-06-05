require 'rubygems'
require 'watir'
require 'webdrivers'
require 'monetize'
require 'money'

def balance(br)
  br
    .div(class: %w[_2tzPNu1unf _22kXFRwS9J])
    .span(data_semantic: 'header-available-balance-amount')
    .text_content
end

def acc_name(br)
  br.h2(class: 'yBcmat9coi').text_content
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

Monetize.assume_from_symbol = true
acc_money = balance(br).to_money


accHash = [:name => acc_name(br),
           :currency => acc_money.currency.to_s,
           :balance => acc_money.to_f]


h = {:account => accHash}


file.puts JSON.pretty_generate(h)


br.close
