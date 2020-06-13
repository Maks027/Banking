# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'rspec'
require '../trans_fetch'

describe 'TransFetch' do
  it 'Verifies #fetch_trans method on test html file' do

    fake_page = Nokogiri::HTML(open('test_html.html'))
    tf = TransFetch.new(nil)
    tf.page = fake_page
    trans_list = tf.fetch_trans
    trans_hash_list = []
    trans_list.each { |t| trans_hash_list << t.to_hash }

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

    expect(trans_hash_list).to eq(expected_out)
  end
end


