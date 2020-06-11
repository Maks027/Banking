# frozen_string_literal: true

require 'rspec'
require_relative '../bank_page'

describe 'BankPage' do
  subject { BankPage.new }
  it 'Opens the browser and log in to account' do
    expect(subject.browser.url).to eq('https://demo.bendigobank.com.au/banking/accounts')
    expect(subject.load_page).to be_an_instance_of(Nokogiri::HTML::Document)
  end
end
