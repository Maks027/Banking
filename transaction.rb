# frozen_string_literal: true

#Transaction class
class Transaction
  def initialize(date, description, amount, currency, account_name)
    @date = date
    @description = description
    @amount = amount
    @currency = currency
    @account_name = account_name
  end

  def to_hash
    trans_info = {date: @date,
                  description: @description,
                  amount: @amount,
                  currency: @currency,
                  account_name: @account_name}
    trans_info
  end

end