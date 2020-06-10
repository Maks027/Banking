# frozen_string_literal: true

require_relative 'account_fetch'
require_relative 'bank_page'
require_relative 'to_json'

ToJSON.new.write_acc_to_json(AccountFetch.new(BankPage.new).fetch_accounts)
