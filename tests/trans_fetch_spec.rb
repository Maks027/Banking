# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'rspec'
require '../trans_fetch'

expected_out = { date: '2020-05-01',
                 description: 'Title: Transaction 1. Description: Description 1',
                 amount: 1.0,
                 currency: 'USD',
                 account_name: 'Test Account Name' },
               { date: '2020-05-01',
                 description: 'Title: Transaction 2. Description: Description 2',
                 amount: 2.0,
                 currency: 'USD',
                 account_name: 'Test Account Name' },
               { date: '2020-05-10',
                 description: 'Title: Transaction 3. Description: Description 3',
                 amount: 3.0,
                 currency: 'USD',
                 account_name: 'Test Account Name' },
               { date: '2020-05-10',
                 description: 'Title: Transaction 4. Description: Description 4',
                 amount: 4.0,
                 currency: 'USD',
                 account_name: 'Test Account Name' }

describe 'TransFetch' do
  it 'Verifies #fetch_trans method on test html file' do
    fake_page = Nokogiri::HTML(open('test_html.html'))
    trans_list = TransFetch.new.fetch_trans(fake_page)
    trans_hash_list = []
    trans_list.each { |t| trans_hash_list << t.to_hash }
    expect(trans_hash_list).to eq(expected_out)
  end

  it 'check number of transactions and show an example' do
    html_page = Nokogiri::HTML(open('page_example.html'))
    trans_list = TransFetch.new.fetch_trans(html_page)

    puts 'First transaction:'
    puts JSON.pretty_generate(trans_list[0].to_hash)
    puts "A total of #{trans_list.length} transactions detected"

    expect(trans_list.length).to eq(30)
    expect(trans_list[0].to_hash).to eq({ date: '2020-06-10',
                                          description: 'Title: Demo My Mastercard. Description: 00001846587602',
                                          amount: 10.0,
                                          currency: 'USD',
                                          account_name: 'Demo Everyday Account' })
  end


end


