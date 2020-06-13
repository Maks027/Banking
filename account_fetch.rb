# frozen_string_literal: true
require_relative 'account'
require_relative 'transaction'
require_relative 'trans_fetch'

# Account fetch class
class AccountFetch
  def initialize
    Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
    Monetize.assume_from_symbol = true
  end

  # Returns an array of html lists containing accounts data
  def accounts(html_page)
    html_page.css("li[data-semantic='account-item']")
  end

  # Returns account name as String
  def acc_name(account)
    account.css("a div div[data-semantic='account-name'] div").text
  end

  # Returns account currency as String
  def acc_currency(account)
    dls = account.css("a div div[data-semantic='account-panel-header-balances'] div dl")
    balance = dls[0].css("dd span[data-semantic='available-balance']").text
    balance.to_money.currency.to_s
  end

  # Returns account balance as Float
  def acc_balance(account)
    dls = account.css("a div div[data-semantic='account-panel-header-balances'] div dl")
    balance = dls[0].css("dd span[data-semantic='available-balance']").text
    balance.to_money.to_f
  end

  # Main method for fetching account data. 
  def fetch_accounts(html_page)
    acc_obj_arr = []
    puts 'Fetching accounts data'
    accounts(html_page).each do |account|
      tr = []
      acc_obj = Account.new(acc_name(account), acc_currency(account),
                            acc_balance(account), 'Credit Card', tr)
      acc_obj_arr << acc_obj
    end
    puts '>Accounts data successfully retrieved'
    acc_obj_arr
  end
end
