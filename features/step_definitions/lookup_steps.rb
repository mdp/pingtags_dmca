Given /^a ([a-zA-Z]+) exists$/ do |model|
  Factory.create(model.downcase.to_sym)
end


When /^I visit a shortened URL$/ do
  FakeWeb.register_uri(:get, User.first.url, :body => 'foo')
  visit User.first.url
end

