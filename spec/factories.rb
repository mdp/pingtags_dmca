require 'factory_girl'

Factory.define :user do |u|
  u.email {Factory.next(:email)}
  u.linked_in_id {Factory.next(:linked_in_id)}
  u.profile_xml File.read(RAILS_ROOT + "/spec/fixtures/profile.xml")
end

Factory.sequence(:email) {|n| "user#{n}@domain.com"}
Factory.sequence(:linked_in_id) {|n| "#{n}1234asdf"}