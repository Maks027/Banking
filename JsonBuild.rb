require 'json'

fileName = "account.json"
file = File.open(fileName, "w")

transactionHash = [:date => "1",
                   :description => "2",
                   :ammount => "3",
                   :currency => "4",
                   :account_name => "5"]

th1 = {:date => "11",
       :description => "21",
       :ammount => "31",
       :currency => "41",
       :account_name => "51"}

th2 = {:date => "12",
       :description => "22",
       :ammount => "32",
       :currency => "42",
       :account_name => "52"}

transactionHash << th1 << th2

accHash = [:name => "1",
           :currency => "2",
           :balance => "3",
           :nature => "4",
           :transactions => transactionHash]

accHash2 = {:name => "1a",
            :currency => "2a",
            :balance => "3a",
            :nature => "4a",
            :transactions => transactionHash}

accHash << accHash2


h = {:account => accHash}

file.puts JSON.pretty_generate(h)