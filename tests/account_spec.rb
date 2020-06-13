require 'rubygems'
require 'rspec'
require 'monetize'
require 'money'
require '../account'
require 'date'

describe 'Account' do
  it 'Creates hash of an account object' do
    date = Date.parse('June 7, 2020').to_s
    Monetize.assume_from_symbol = true
    Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
    amount_str = '$10'
    amount = amount_str.to_money.to_f
    currency = amount_str.to_money.currency.to_s
    tr = Transaction.new(date, 'Description', amount, currency, 'Name')
    transactions = [] << tr
    account = Account.new('Name', 'USD', 100, 'Credit Card', transactions)
    account_hash = account.to_hash
    expect(account_hash).to eq({ name: 'Name',
                                 currency: 'USD',
                                 balance: 100,
                                 nature: 'Credit Card',
                                 transactions: [{ date: '2020-06-07',
                                                  description: 'Description',
                                                  amount: 10.0,
                                                  currency: 'USD',
                                                  account_name: 'Name' }
                                 ]
                               })
  end
end