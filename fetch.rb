# frozen_string_literal: true

require './account'
require './transaction'
require './browser'

browser = Browser.new

acc_lis = browser.accounts

accounts = []

acc_lis.each do |link|
  link.click
  # Watir::Wait.until { browser.div(data_semantic: 'activity-feed').visible? }
  activity_div = browser.get_browser.div(class: 'activity-container')

  activity_div.wait_until(&:exists?)

  scroll = Watir::Scroll.new(activity_div)

  end_div = browser.get_browser.div(data_semantic: 'end-of-feed-message')

  until end_div.present? do
    scroll.to :bottom
  end
  
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
