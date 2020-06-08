# frozen_string_literal: true

require './account'
require './transaction'

t1 = Transaction.new(Time.now, 'desc1', 15, 'USD', 'name1')
t2 = Transaction.new(Time.now, 'desc2', 16, 'USD', 'name2')
t3 = Transaction.new(Time.now, 'desc3', 17, 'USD', 'name3')
t4 = Transaction.new(Time.now, 'desc4', 18, 'USD', 'name4')

transactions = []
transactions << t1.to_hash << t2.to_hash << t3.to_hash << t4.to_hash

a1 = Account.new('n', 'c', 1, 'n', transactions)

h = a1.to_hash

puts h
