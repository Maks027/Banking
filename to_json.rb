# frozen_string_literal: true
require_relative 'account'
require_relative 'transaction'
require_relative 'bank_page'

# Methods for saving fetched data to JSON file
class ToJSON
  def initialize
    @file_name = 'account.json'
    @file = File.open(@file_name, 'w')
  end

  def write_to_file(hash)
    @file.puts JSON.pretty_generate(hash)
  end

  def write_acc_to_json(acc_array)
    acc_hash = []
    acc_array.each { |acc| acc_hash << acc.to_hash }
    acc_hash_f = { account: acc_hash}
    write_to_file(acc_hash_f)
  end

  def write_hash_to_json(acc_hash)
    hash = { account: acc_hash }
    write_to_file(hash)
  end
end
