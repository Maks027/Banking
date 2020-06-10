# frozen_string_literal: true

require 'rubygems'
require 'monetize'
require 'money'
require 'date'
require_relative 'account'
require_relative 'transaction'

# Transaction fetch class
class TransFetch
  def initialize(bank_page)
    @page = bank_page.load_page
    Monetize.assume_from_symbol = true
  end

  def acc_name
    @page.css("h2[data-semantic = 'account-name']").text
  end

  def trans_list_by_date
    @page.css("li[data-semantic='activity-group']")
  end

  def trans_list_at_date(trans_at_date)
    trans_at_date.css('ol li')
  end

  def trans_date(trans_at_date)
    date_str = trans_at_date.css("h3[data-semantic='activity-group-heading']").text
    Date.parse(date_str)
  end

  def trans_div(current_trans)
    current_trans.css("article header a div[class='panel__header__label--inline']")
  end

  def trans_description(current_trans)
    title = trans_div(current_trans).css("span[class='overflow-ellipsis']").text #Try getting span array
    sec_title = trans_div(current_trans).css("span[class='overflow-ellipsis sub-title']").text
    "Title: #{title}. Description: #{sec_title}"
  end

  def trans_amount(current_trans)
    trans_div(current_trans).css("span[data-semantic='transaction-amount']").text.to_money.to_f
  end

  def trans_currency(current_trans)
    trans_div(current_trans).css("span[data-semantic='transaction-amount']").text.to_money.currency.to_s
  end

  def trans_for_date(tans_at_date, date, name)
    tr_at_date_arr = []
    trans_list_at_date(tans_at_date).each do |t_d|
      tr = Transaction.new(date.to_s, trans_description(t_d), trans_amount(t_d), trans_currency(t_d), name)
      tr_at_date_arr << tr
    end
    tr_at_date_arr
  end

  def fetch_trans
    name = acc_name
    tr_obj_arr = []
    trans_list_by_date.each do |t|
      date = trans_date(t)
      return tr_obj_arr.flatten! unless date.between?(Date.today << 2, Date.today)

      tr_obj_arr << trans_for_date(t, date, name)
    end
    tr_obj_arr.flatten!
  end
end
