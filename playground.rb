# frozen_string_literal: true

require './account'
require './transaction'
require './bank_page'


date = Date.parse('June 7, 2020').to_s
Monetize.assume_from_symbol = true
amount_str = '$10'
amount = amount_str.to_money.to_f
currency = amount_str.to_money.currency.to_s
tr = Transaction.new(date, 'Description', amount, currency, 'Name')
tr_hash = tr.to_hash

puts tr_hash

# date = Date.parse('April 8, 2020')
#
# puts date.between?(Date.today << 2, Date.today)
#
# puts date.to_s



# browser = BankPage.new
#
# list = browser.get_browser.lis(data_semantic: 'activity-group')
#
# list_by_date = list[1].ol.lis
#
# a = list_by_date[1]
#         .article
#         .header
#         .a
#         .div(class: 'panel__header__label--inline')
#         .h2
#         .spans
#
#
#         # .text_content
#
#
# puts a[0].text_content, a[1].text_content

# article.header.a.div(class: 'panel__header__label--inline')
# t1 = Transaction.new(Time.now, 'desc1', 15, 'USD', 'name1')
# t2 = Transaction.new(Time.now, 'desc2', 16, 'USD', 'name2')
# t3 = Transaction.new(Time.now, 'desc3', 17, 'USD', 'name3')
# t4 = Transaction.new(Time.now, 'desc4', 18, 'USD', 'name4')
#
# transactions = []
# transactions << t1.to_hash << t2.to_hash << t3.to_hash << t4.to_hash
#
# a1 = Account.new('n', 'c', 1, 'n', transactions)
#
# h = a1.to_hash
#
# puts h
