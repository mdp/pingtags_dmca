When /^someones ([a-zA-Z]+) scans my barcode$/ do |model|
  headers["User-Agent"] = "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us)"
  get '/user/'
end


Then /^I should see a scan listed$/ do
  
end