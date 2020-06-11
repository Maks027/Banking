# frozen_string_literal: true
#
require_relative 'account'
require_relative 'transaction'
require_relative 'bank_page'

# Methods for saving fetched data to JSON file
class ToJSON
  attr_reader :file_name
  attr_reader :file

  # Creates a new file with specified directory and name
  def initialize(file_name)
    @file_name = file_name
    @file = File.open(@file_name, 'w')
  end

  # Writes hash object to the current file
  def write_to_file(hash)
    @file.puts JSON.pretty_generate(hash)
    @file.close
  end

  # Writes Account objects array to the file
  def write_acc_to_json(acc_array)
    puts 'Writing data to JSON file'
    acc_hash = []
    acc_array.each { |acc| acc_hash << acc.to_hash }
    acc_hash_f = { account: acc_hash}
    write_to_file(acc_hash_f)
    puts ">Data successfully saved to #{@file_name}"
  end
end
