ActionMailer::Base.smtp_settings = {
:tls => true,
:address => "smtp.gmail.com",
:port => 587,
:domain => "squarepush.com",
:authentication => :plain,
:user_name => SquarePush::Config.email[:account],
:password => SquarePush::Config.email[:password],
:enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = SquarePush::Config.app[:domain]