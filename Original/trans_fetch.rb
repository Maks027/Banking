# frozen_string_literal: true

require 'rubygems'
require 'monetize'
require 'money'
require 'date'
require_relative 'account'
require_relative 'transaction'

# Transaction fetch class
class TransFetch
  attr_accessor :page # Provides accessors to the current page(for testing)
  def initialize(bank_page)
    return if bank_page.nil?  # Enables possibility to instantiate object with nil argument(for testing)

    @page = bank_page.load_page
  end

  # Returns account name of current transaction as String
  def acc_name
    @page.css("h2[data-semantic = 'account-name']").text
  end

  # Returns an array of html lists of transactions grouped by date
  def trans_list_by_date
    @page.css("li[data-semantic='activity-group']")
  end

  # Returns an array of html lists of transactions at a specific date
  # Expects list element returned by #trans_list_by_date
  def trans_list_at_date(trans_at_date)
    trans_at_date.css('ol li')
  end

  # Returns the date of a specific transactions group as Date object
  # Expects list element returned by #trans_list_by_date
  def trans_date(trans_at_date)
    date_str = trans_at_date.css("h3[data-semantic='activity-group-heading']").text
    Date.parse(date_str)
  end

  # Returns html division with necessary info about the transaction
  # Expects list element of a single transaction returned by #trans_list_at_date
  def trans_div(current_trans)
    current_trans.css("article header a div[class='panel__header__label--inline']")
  end

  # Returns a formatted string containing transaction description
  # Expects list element of a single transaction returned by #trans_list_at_date
  def trans_description(current_trans)
    title = trans_div(current_trans).css("span[class='overflow-ellipsis']").text
    sec_title = trans_div(current_trans).css("span[class='overflow-ellipsis sub-title']").text
    "Title: #{title}. Description: #{sec_title}"
  end

  # Returns transaction amount as float
  # Expects list element of a single transaction returned by #trans_list_at_date
  def trans_amount(current_trans)
    trans_div(current_trans).css("span[data-semantic='transaction-amount']").text.to_money.to_f
  end

  # Returns transaction currency assumed from symbol
  # Expects list element of a single transaction returned by #trans_list_at_date
  def trans_currency(current_trans)
    trans_div(current_trans).css("span[data-semantic='transaction-amount']").text.to_money.currency.to_s
  end

  # Iterates through transactions array of html list grouped by date
  # Returns an array of Transaction objects for that date
  # Expects list element returned by #trans_list_by_date
  # Transaction date and account name are passed as arguments to improve efficiency
  def trans_for_date(tans_at_date, date, name)
    tr_at_date_arr = []
    trans_list_at_date(tans_at_date).each do |t_d|
      tr = Transaction.new(date.to_s, trans_description(t_d), trans_amount(t_d), trans_currency(t_d), name)
      tr_at_date_arr << tr
    end
    tr_at_date_arr
  end

  # Main method for fetching transactions data for the last 2 months
  # It iterates through transactions grouped by date,
  # calling #trans_for_date to get all transactions at a specific date
  # and stores returned object in an array.
  # Returns a flatten array of Transaction objects for the last 2 months
  def fetch_trans
    name = acc_name
    tr_obj_arr = []
    trans_list_by_date.each do |t|
      date = trans_date(t)
      unless date.between?(Date.today << 2, Date.today)
        puts ">Fetched #{tr_obj_arr.length} transactions"
        return tr_obj_arr.flatten!
      end
      tr_obj_arr << trans_for_date(t, date, name)
    end
    puts ">Fetched #{tr_obj_arr.length} transactions"
    tr_obj_arr.flatten!
  end
end
