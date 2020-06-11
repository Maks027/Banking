require 'rspec'
require '../to_json'
require '../account'
require '../transaction'

describe 'ToJSON' do
  file_name = '../output/test.json'

  def delete_test_file(file, name)
    file.close unless file.nil? || file.closed? # Close test file
    File.delete(name) if File.exists? name # Delete test file
  end

  it 'Creates an empty file in output directory' do
    ToJSON.new(file_name).file.close # Create test.json file and close it
    b = File.open(file_name, 'r') # Open created file
    expect(File.exists?(b)).to eq(true)
    delete_test_file(b, file_name)
  end

  it 'Writes sample hash to json file' do
    sample_hash = { k1: 'A', k2: 'B', k3: 'C' }

    a = ToJSON.new(file_name)
    a.write_to_file(sample_hash)
    b = File.open(file_name, 'r')

    expect(a.file.print).to eq(b.print)
    a.file.close
    delete_test_file(b, file_name)
  end

  it 'Creates a printout of an Account object to json' do
    tr = Transaction.new('2020-06-07', 'Description', 10, 'USD', 'Name')
    transactions = [] << tr
    acc= Account.new('Name', 'USD', 100, 'Credit Card', transactions)
    accounts = [] << acc
    a = ToJSON.new(file_name)
    a.write_acc_to_json(accounts)
    b = File.open(file_name, 'r')
    expect(a.file.print).to eq(b.print)
    a.file.close
    delete_test_file(b, file_name)
  end
end
