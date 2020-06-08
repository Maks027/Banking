# frozen_string_literal: true

require './account'
require './transaction'
require './browser'

browser = Browser.new

acc_lis = browser.accounts

accounts = []

acc_lis.each do |link|
  link.click
  account = Account.new(browser.acc_name,
                        browser.acc_currency,
                        browser.balance,
                        'Credit Card',
                        browser.trans_hash)
  accounts << account.to_hash
end

file_name = 'account.json'
file = File.open(file_name, 'w')

acc_hash = {account: accounts}

file.puts JSON.pretty_generate(acc_hash)

browser.close
