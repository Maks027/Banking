# frozen_string_literal: true

require_relative 'account_fetch'
require_relative 'bank_page'
require_relative 'to_json'
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN

ToJSON.new('./output/account.json').write_acc_to_json(AccountFetch.new(BankPage.new).fetch_accounts)
