require 'digest/sha1'

# DO NOT MODIFY THIS FILE
module Bundler
  FINGERPRINT = "354f5bd810d7cf7a5a3718b9b6458a0024383187"
  LOAD_PATHS = ["/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/nokogiri-1.4.1/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/nokogiri-1.4.1/ext", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/activesupport-2.3.5/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/four_bites_aes-1.0.1/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/actionmailer-2.3.5/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/will_paginate-2.3.12/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/factory_girl-1.2.3/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/rack-1.0.1/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/actionpack-2.3.5/lib", "/Users/mark/.bundle/gems/rspec-1.2.6/lib", "/Users/mark/.bundle/gems/rspec-rails-1.2.6/lib", "/Users/mark/.bundle/gems/ruby-hmac-0.4.0/lib", "/Users/mark/.bundle/gems/oauth-0.3.6/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/mysql-2.8.1/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/mysql-2.8.1/ext", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/authlogic-2.1.3/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/rake-0.8.7/lib", "/Users/mark/.bundle/gems/haml-2.2.19/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/activerecord-2.3.5/lib", "/Users/mark/.bundle/gems/fakeweb-1.2.8/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/activeresource-2.3.5/lib", "/usr/local/Cellar/ruby187/1.8.7-p249/lib/ruby/gems/1.8/gems/rails-2.3.5/lib"]
  AUTOREQUIRES = {:default=>["rails", "haml", "oauth", "oauth", "authlogic", "nokogiri", "four_bites_aes", "nokogiri", "mysql", "fakeweb", "will_paginate", "factory_girl", "rspec", "rspec-rails"]}

  def self.match_fingerprint
    print = Digest::SHA1.hexdigest(File.read(File.expand_path('../../Gemfile', __FILE__)))
    unless print == FINGERPRINT
      abort 'Gemfile changed since you last locked. Please `bundle lock` to relock.'
    end
  end

  def self.setup(*groups)
    match_fingerprint
    LOAD_PATHS.each { |path| $LOAD_PATH.unshift path }
  end

  def self.require(*groups)
    groups = [:default] if groups.empty?
    groups.each do |group|
      (AUTOREQUIRES[group] || []).each { |file| Kernel.require file }
    end
  end

  # Setup bundle when it's required.
  setup
end
