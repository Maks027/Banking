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
    acc = AccountFetch.new.fetch_accounts(page)

    puts 'First account hash:'
    puts JSON.pretty_generate(acc[0].to_hash)
    puts "A total of #{acc.length} accounts detected"

    expect(acc.length).to eq(5)
    expect(acc[0].to_hash).to eq({ balance: 1959.9,
                                   currency: 'USD',
                                   name: 'Demo Everyday Account',
                                   nature: 'Credit Card',
                                   transactions: [] } )
  end
end
