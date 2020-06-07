# frozen_string_literal: true

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
    acc_info = { name: @name,
                 currency: @currency,
                 balance: @nature,
                 transactions: @transactions }
    acc_info
  end

end
