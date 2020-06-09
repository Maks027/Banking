# frozen_string_literal: true

require 'rubygems'
require 'watir'
require 'webdrivers'
require 'monetize'
require 'money'
require './transaction'

# Browser class
class Browser
  def initialize
    @browser = Watir::Browser.new
    @browser.goto 'https://demo.bendigobank.com.au/banking/sign_in'
    @browser.button(name: 'customer_type').click

    Monetize.assume_from_symbol = true

  end

  def get_browser
    @browser
  end

  def balance_str
    bal = @browser
          .li(data_semantic:'header-available-balance')
          .div(data_semantic: 'value')
          .span(data_semantic: 'header-available-balance-amount')
          .text_content
    bal
  end

  def balance
    balance_str.to_money.to_f
  end

  def acc_currency
    balance_str.to_money.currency.to_s
  end

  def acc_name
    @browser.h2(data_semantic: 'account-name').text_content
  end

  def accounts
    @browser.lis(data_semantic: 'account-item')
  end

  def transactions
    @browser.lis(data_semantic: 'activity-group')
  end

  def trans_date(trans_at_date)
    trans_at_date.h3(data_semantic: 'activity-group-heading').text_content
  end

  def trans_div(trans_at_date)
    trans_at_date.article.header.a.div(class: 'panel__header__label--inline')
  end

  def trans_description(tr_div)
    spans = tr_div.h2.spans
    "Title: #{spans[0].text_content}. Description: #{spans[1].text_content}"
  end

  def trans_amount_money(tr_div)
    tr_div.div.span(data_semantic: 'transaction-amount').text_content.to_money
  end

  def trans_amount(tr_money)
    tr_money.to_f
  end

  def trans_currency(tr_money)
    tr_money.currency.to_s
  end

  def trans_for_date(trans_at_date, tr_date, account_name)
    tr_obj_arr = []
    trans_at_date.ol.lis.each do |t_d|
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
      date = Date.parse(trans_date(t))
      return tr_obj_arr.flatten! unless date.between?(Date.today << 2, Date.today)
      tr_obj_arr << trans_for_date(t, date, account_name)
    end
    tr_obj_arr.flatten!
  end
end
