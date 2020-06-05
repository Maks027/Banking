require 'rubygems'
require 'watir'
require 'webdrivers'

def balance(br)
  br
      .div(class: %w[_2tzPNu1unf _22kXFRwS9J])
      .span(data_semantic: 'header-available-balance-amount')
      .text_content
end

def new_browser
  browser = Watir::Browser.new
  browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
  browser.button(name: 'customer_type').click
  return browser
end


br = new_browser




puts balance(browser)



browser.close
