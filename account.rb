# frozen_string_literal: true

require_relative 'transaction'

# Account class
class Account
  # Initialises instance variables with data passed as arguments
  def initialize(name, currency, balance, nature, transactions)
    @name = name
    @currency = currency
    @balance = balance
    @nature = nature
    @transactions = transactions
  end

  # Method for converting instance variables to hash for further writing to file
  def to_hash
    transactions_hash = []
    @transactions&.each { |t| transactions_hash << t.to_hash }
    { name: @name,
      currency: @currency,
      balance: @balance,
      nature: @nature,
      transactions: transactions_hash }
  end
end
