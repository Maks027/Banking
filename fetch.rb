# frozen_string_literal: true

require_relative 'account'
require_relative 'transaction'
require_relative 'browser'
require_relative 'to_json'

browser = Browser.new
acc_lis = browser.accounts

accounts = []

acc_lis.each do |link|
  link.click

  activity_div = browser.get_browser.div(class: 'activity-container')
  activity_div.wait_until(&:exists?)
  browser.load_page
  scroll = Watir::Scroll.new(activity_div)
  end_div = browser.get_browser.div(data_semantic: 'end-of-feed-message')

  begin
    browser.load_page
    last_trans_date = browser.trans_date(browser.transactions[-1])
    scroll.to :bottom

    puts last_trans_date.to_s
  end until end_div.present? || !last_trans_date.between?(Date.today << 2, Date.today)

  transactions = browser.transactions_obj

  accounts << Account.new(browser.acc_name,
                          browser.acc_currency,
                          browser.balance,
                          'Credit Card',
                          transactions)
end

ToJSON.new.write_obj_to_json(accounts)

