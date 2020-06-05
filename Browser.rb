require 'rubygems'
require 'watir'
require 'webdrivers'

def balance(br)
  br
      .div(class: %w[_2tzPNu1unf _22kXFRwS9J])
      .span(data_semantic: 'header-available-balance-amount')
      .text_content
end

def acc_name(br)
  br.h2(class: "yBcmat9coi").text_content
end

def new_browser
  browser = Watir::Browser.new
  browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
  browser.button(name: 'customer_type').click
  return browser
end

br = new_browser

fileName = "account.json"
file = File.open(fileName, "w")



accHash = [:name => acc_name(br) ,
           :balance => balance(br)]


h = {:account => accHash}


file.puts JSON.pretty_generate(h)


br.close
