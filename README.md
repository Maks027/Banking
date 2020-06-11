## Banking
Ruby script for fetching data from Bendigo Bank demo 
accounts 

Link: https://demo.bendigobank.com.au/banking/sign_in

####Getting started
These instructions will get you a copy of this project 
for running the script on your computer.
#####Prerequisites
You should have *Ruby 2.6.6* (or newer version) installed 
in order to run the script. Tested on only on version *2.6.6 (Windows 10)*. 
The project was developed using *RubyMine 2020.1.2* IDE.
#####Installing
To get a copy of the project, you can create an empty 
repository in a preferred location and run:

 `git clone https://github.com/Maks027/Banking.git `
 
 
 Alternatively, you can download the project as a .zip archive
 and unpack it to some location on your computer
 
#####Runnning
To run the script, simply open *cmd* (for Windows) 
or *Bash* terminal (for Linux) and navigate to the 
project location. Then run the command:

`ruby run_fetch.rb`

A new Chrome window will open and the script will start 
fetching data. During this process it will print messages
to console about its status. At the end, the script will
write all fetched data to an *accounts_printout_{timestamp}.json* file in the */output*
directory.

#####Used frameworks
* Watir (http://watir.com/)
* webdrivers (https://github.com/titusfortner/webdrivers)
* Nokogiri (https://nokogiri.org/)
* Monetize (https://github.com/RubyMoney/monetize)
* Money (https://github.com/RubyMoney/money)
* Rspec (https://rspec.info/)