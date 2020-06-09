# frozen_string_literal: true

require './account'
require './transaction'
require './browser'
require './to_json'

browser = Browser.new
acc_lis = browser.accounts

accounts = []

acc_lis.each do |link|
  link.click
  activity_div = browser.get_browser.div(class: 'activity-container')
  activity_div.wait_until(&:exists?)

  scroll = Watir::Scroll.new(activity_div)
  end_div = browser.get_browser.div(data_semantic: 'end-of-feed-message')
  scroll.to :bottom until end_div.present?
  transactions = browser.transactions_obj

  accounts << Account.new(browser.acc_name,
                          browser.acc_currency,
                          browser.balance,
                          'Credit Card',
                          transactions)
end

ToJSON.new.write_obj_to_json(accounts)

