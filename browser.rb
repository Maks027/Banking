# frozen_string_literal: true

require 'rubygems'
require 'watir'
require 'webdrivers'
require 'nokogiri'
require 'monetize'
require 'money'
require_relative 'transaction'

# Browser class
class Browser
  def initialize
    @browser = Watir::Browser.new
    @browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
    @browser.button(name: 'customer_type').click
    load_page
    Monetize.assume_from_symbol = true

  end

  def get_browser
    @browser
  end

  def load_page
    @page = Nokogiri::HTML(@browser.html)
  end

  def balance_str
    @page.css("span[data-semantic = 'header-available-balance-amount']").text
  end

  def balance
    balance_str.to_money.to_f
  end

  def acc_currency
    balance_str.to_money.currency.to_s
  end

  def acc_name
    @page.css("h2[data-semantic = 'account-name']").text
  end

  def accounts
    @browser.lis(data_semantic: 'account-item')
  end

  def transactions
    @page.css("li[data-semantic='activity-group']")
  end

  def trans_date(trans_at_date)
    date_str = trans_at_date.css("h3[data-semantic='activity-group-heading']").text
    Date.parse(date_str)
  end

  def trans_div(trans_at_date)
    trans_at_date.css("article header a div[class='panel__header__label--inline']")
  end

  def trans_description(tr_div)
    title = tr_div.css("span[class='overflow-ellipsis']").text
    sec_title = tr_div.css("span[class='overflow-ellipsis sub-title']").text
    "Title: #{title}. Description: #{sec_title}"
  end

  def trans_amount_money(tr_div)
    tr_div.css("span[data-semantic='transaction-amount']").text.to_money
  end

  def trans_amount(tr_money)
    tr_money.to_f
  end

  def trans_currency(tr_money)
    tr_money.currency.to_s
  end

  def trans_for_date(trans_at_date, tr_date, account_name)
    tr_obj_arr = []
    trans_at_date.css('ol li').each do |t_d|
      div = trans_div(t_d)
      tr_money = trans_amount_money(div)
      tr_obj_arr << Transaction.new(tr_date.to_s,
                                    trans_description(div),
                                    trans_amount(tr_money),
                                    trans_currency(tr_money),
                                    account_name)
    end
    tr_obj_arr
  end

  def transactions_obj
    tr_obj_arr = []
    account_name = acc_name
    transactions.each do |t|
      date = trans_date(t)
      return tr_obj_arr.flatten! unless date.between?(Date.today << 2, Date.today)

      tr_obj_arr << trans_for_date(t, date, account_name)
    end
    tr_obj_arr.flatten!
  end
end
