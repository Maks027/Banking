# frozen_string_literal: true

require_relative 'transaction'

# Account class
class Account
  def initialize(name, currency, balance, nature, transactions)
    @name = name
    @currency = currency
    @balance = balance
    @nature = nature
    @transactions = transactions
  end

  def to_hash
    transactions_hash = []
    @transactions&.each { |t| transactions_hash << t.to_hash }
    acc_info = { name: @name,
                 currency: @currency,
                 balance: @balance,
                 nature: @nature,
                 transactions: transactions_hash }
    acc_info
  end

end
