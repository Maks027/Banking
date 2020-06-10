# frozen_string_literal: true
#
require_relative 'account'
require_relative 'transaction'
require_relative 'bank_page'

# Methods for saving fetched data to JSON file
class ToJSON
  attr_reader :file_name
  attr_reader :file

  def initialize(file_name)
    @file_name = file_name
    @file = File.open(@file_name, 'w')
  end


  def write_to_file(hash)
    @file.puts JSON.pretty_generate(hash)
  end

  def write_acc_to_json(acc_array)
    puts 'Writing data to JSON file'
    acc_hash = []
    acc_array.each { |acc| acc_hash << acc.to_hash }
    acc_hash_f = { account: acc_hash}
    write_to_file(acc_hash_f)
    puts ">Data successfully saved to #{@file_name}"
  end

  def write_hash_to_json(acc_hash)
    hash = { account: acc_hash }
    write_to_file(hash)
  end
end
