require 'rubygems'
require 'nokogiri'
require 'watir'
require 'rspec'
require '../account_fetch'
require '../bank_page'

describe 'AccountFetch' do
  it 'Check parsing methods on test html file' do
    page = Nokogiri::HTML(open('test_html.html'))
    af = AccountFetch.new
    accs = af.accounts(page)

    expect(af.acc_name(accs[0])).to eq('Test Account Name')
    expect(af.acc_balance(accs[0])).to eq(100.0)
    expect(af.acc_currency(accs[0])).to eq('USD')
  end

  it 'check number of accounts and show an example account' do
    page = Nokogiri::HTML(open('accounts_html.html'))
    af = AccountFetch.new(nil )
    af.page = page
    acc = af.fetch_accounts(page)
    puts acc[0].to_hash
  end

end

