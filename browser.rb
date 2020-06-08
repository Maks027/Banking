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

  def trans_date(transaction)
    transaction.h3(data_semantic: 'activity-group-heading').text_content
  end

  def trans_div(tr_lis)
    tr_lis.article.header.a.div(class: 'panel__header__label--inline')
  end

  def trans_name(tr_lis)
    trans_div(tr_lis).h2.span(class: 'overflow-ellipsis').text_content
  end

  def trans_description(tr_lis)
    trans_div(tr_lis).h2.span(class: %w[overflow-ellipsis sub-title]).text_content
  end

  def trans_amount(tr_lis)
    trans_div(tr_lis).div.span(data_semantic: 'transaction-amount').text_content.to_money.to_f
  end

  def trans_currency(tr_lis)
    trans_amount(tr_lis).to_money.currency.to_s
  end

  def trans_for_date(trans_at_date)
    trans_arr = []
    trans_at_date.ol.lis.each do |t|
      trans_arr << Transaction.new(trans_date(trans_at_date),
                                     trans_description(t),
                                     trans_amount(t),
                                     trans_currency(t),
                                     trans_name(t))
      # trans_at_date_hash << single_trans.to_hash
    end
    trans_arr
    # trans_at_date_hash
  end

  def trans_hash
    transactions_hash = []
    transactions.each do |t|
      trans_for_date(t).each { |t_d| transactions_hash << t_d.to_hash}
    end
    transactions_hash
  end

end
