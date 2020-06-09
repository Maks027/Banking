# frozen_string_literal: true
require './account'
require './transaction'
require './browser'

# Methods for saving fetched data to JSON file
class ToJSON
  def initialize
    @file_name = 'account.json'
    @file = File.open(@file_name, 'w')
  end

  def write_to_file(hash)
    @file.puts JSON.pretty_generate(hash)
  end

  def write_obj_to_json(acc_objects)
    acc_hash = []
    acc_objects.each { |acc| acc_hash << acc.to_hash }
    acc_hash_f = { account: acc_hash}
    write_to_file(acc_hash_f)
  end

  def write_hash_to_json(acc_hash)
    hash = { account: acc_hash }
    write_to_file(hash)
  end
end
