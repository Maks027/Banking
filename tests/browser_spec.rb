require 'rspec'
require_relative '../bank_page'


describe 'BankPage' do
  subject { BankPage.new }

  it 'Opens the browser and log in to account' do
    expect(subject.browser.url).to eq('https://demo.bendigobank.com.au/banking/accounts')
  end

  it 'Checks if there is an accounts list on the page' do
    acc_list = subject.accounts
    expect(acc_list).to be_instance_of(Watir::LICollection)
  end

  it 'Checks if #acc_name returns a String' do
    name = subject.acc_name
    expect(name).to be_an_instance_of(String)
  end


end