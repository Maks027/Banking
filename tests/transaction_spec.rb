require 'rubygems'
require 'rspec'
require 'monetize'
require 'money'
require '../transaction'
require 'date'

describe 'Transaction' do
  it 'Creates the hash of transaction object' do
    date = Date.parse('June 7, 2020').to_s
    Monetize.assume_from_symbol = true
    amount_str = '$10'
    amount = amount_str.to_money.to_f
    currency = amount_str.to_money.currency.to_s
    tr = Transaction.new(date, 'Description', amount, currency, 'Name')
    tr_hash = tr.to_hash

    expect(tr_hash).to eq({ date: '2020-06-07',
                            description: 'Description',
                            amount: 10.0,
                            acc_currency: 'USD',
                            account_name: 'Name' })
  end
end