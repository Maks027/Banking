# frozen_string_literal: true
require_relative 'account'
require_relative 'transaction'
require_relative 'trans_fetch'

# Account fetch class
class AccountFetch
  attr_accessor :page # Provides accessors to the current page(for testing)
  def initialize(bank_page)
    return if bank_page.nil? # Enables possibility to instantiate object with nil argument(for testing)

    @bank_page = bank_page
    @browser = bank_page.browser
    @page = bank_page.load_page
  end

  # Returns an array of html lists containing accounts data
  def accounts
    @browser.lis(data_semantic: 'account-item')
  end

  # Returns account name as String
  def acc_name
    @page.css("h2[data-semantic = 'account-name']").text
  end

  # Returns account currency as String
  def acc_currency
    @page.css("span[data-semantic = 'header-available-balance-amount']").text.to_money.currency.to_s
  end

  # Returns account balance as Float
  def acc_balance
    @page.css("span[data-semantic = 'header-available-balance-amount']").text.to_money.to_f
  end

  # Returns html division with all activity
  def activity_div
    @browser.div(class: 'activity-container')
  end

  # Returns end division for transactions
  def end_div
    @browser.div(data_semantic: 'end-of-feed-message')
  end

  # Returns the date of last activity (to limit loading of transactions)
  def last_trans_date
    tr_list_by_date = @page.css("li[data-semantic='activity-group']")
    date_str = tr_list_by_date[-1].css("h3[data-semantic='activity-group-heading']").text
    Date.parse(date_str)
  end

  # Scrolls activity division to load transactions dynamically
  def scroll_to_bottom
    scroll = Watir::Scroll.new(activity_div)
    # Limit scrolling to end division or if last loaded transaction was performed later than 2 months from now
    begin
      @page = @bank_page.load_page
      date = last_trans_date
      scroll.to :bottom
    end until end_div.present? || !date.between?(Date.today << 2, Date.today)
  end

  # Wait until activity division is fully loaded
  def wait_to_load
    activity_div.wait_until(&:exists?)
    @page = @bank_page.load_page
  end

  # Main method for fetching account data. Each detected account is accessed by clicking
  # on the corresponding list element. Then it waits until activity division is loaded
  # and scrolls down until all necessary transaction data is loaded and performs fetching
  def fetch_accounts
    acc_obj_arr = []
    accounts.each do |link|
      link.click
      puts "Accessing account: #{acc_name}"
      wait_to_load
      puts 'Loading transactions data'
      scroll_to_bottom
      puts '>Transactions data successfully loaded'
      puts 'Fetching transactions'
      tr = TransFetch.new(@bank_page).fetch_trans
      acc_obj_arr << Account.new(acc_name, acc_currency, acc_balance,
                                 'Credit Card', tr)
      puts ">Successfully retrieved data for #{acc_name} account"
    end
    acc_obj_arr
  end
end
