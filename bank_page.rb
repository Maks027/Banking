# frozen_string_literal: true

require 'rubygems'
require 'watir'
require 'webdrivers'
require 'nokogiri'

# BankPage class
class BankPage
  attr_accessor :browser
  # Opens the Chrome browser, accesses main bank page and logs into personal account
  def initialize
    @browser = Watir::Browser.new
    puts 'Trying to open https://demo.bendigobank.com.au/banking/sign_in'
    @browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
    puts '>Page successfully loaded'
    puts 'Trying to log in'
    @browser.button(name: 'customer_type').click
    puts '>Successfully logged in'
  end

  # Converts current html loaded by Watir to Nokogiri object
  def load_page(browser)
    Nokogiri::HTML(browser.html)
  end

  def accounts(browser)
    browser.lis(data_semantic: 'account-item')
  end

  def activity_div(browser)
    browser.div(class: 'activity-container')
  end

  # Returns end division for transactions
  def end_div(browser)
    browser.div(data_semantic: 'end-of-feed-message')
  end

  def scroll_to_bottom(browser)
    scroll = Watir::Scroll.new(activity_div(browser))
    # Limit scrolling to end division or if last loaded transaction was performed later than 2 months from now
    begin
      date = last_trans_date(browser)
      scroll.to :bottom
    end until end_div(browser).present? || !date.between?(Date.today << 2, Date.today)
  end

  # Wait until activity division is fully loaded
  def wait_to_load(browser)
    activity_div(browser).wait_until(&:exists?)
  end

  def last_trans_date(browser)
    tr_list_by_date = browser.lis(data_semantic: 'activity-group')
    date_str = tr_list_by_date[-1].h3(data_semantic: 'activity-group-heading').text_content
    Date.parse(date_str)
  end

  def attach_trans(accs, page)
    tr = TransFetch.new
    trans = tr.fetch_trans(page)
    puts tr.acc_name(page)
    accs.each do |acc|
      if acc.name == tr.acc_name(page)
        acc.transactions = trans
      end
    end
    accs
  end

  def parse_acc_trans(browser)
    acc_arr = AccountFetch.new.fetch_accounts(load_page(browser))
    accounts(browser).each do |account|
      account.click
      wait_to_load(browser)
      scroll_to_bottom(browser)
      acc_arr = attach_trans(acc_arr, load_page(browser))
    end
    acc_arr
  end
end
