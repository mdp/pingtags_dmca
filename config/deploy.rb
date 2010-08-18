set :application, "pingtags"
set :repository,  "git@github.com:mdp/pingtag.git"
set :deploy_to, "/vol/apps/#{application}"
set :user, 'deploy'
set :use_sudo, false
set :stage, :production

set :ssh_options, {:forward_agent => true }
set :scm, :git
set :deploy_via, :remote_cache

role :web, "dev.squarepush.com"                          # Your HTTP server, Apache/etc
role :app, "dev.squarepush.com"                          # This may be the same as your `Web` server
role :db,  "dev.squarepush.com", :primary => true # This is where Rails migrations will run

namespace :bundler do
  task :install, :roles => :app, :except => { :no_release => true }  do
    run("bundle install")
  end
end
 
# after 'deploy:update_code', 'bundler:bundle_new_release'

namespace :deploy do
  task :start do; end;
  task :stop do; end;
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  namespace :web do
    desc <<-DESC
    Present a maintenance page to visitors. Disables your application's web \
    interface by writing a "maintenance.html" file to each web server. The \
    servers must be configured to detect the presence of this file, and if \
    it is present, always display it instead of performing the request.

    By default, the maintenance page will just say the site is down for \
    "maintenance", and will be back "shortly", but you can customize the \
    page by specifying the REASON and UNTIL environment variables:

      $ cap deploy:web:disable \\
            REASON="hardware upgrade" \\
            UNTIL="12pm Central Time"

    Further customization will require that you write your own task.
  DESC
    task :disable, :roles => :web, :except => { :no_release => true } do
      require 'haml'
      require 'tzinfo'
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }

      locals = {:started => ENV['STARTED'], :reason => ENV['REASON'], :deadline => ENV['UNTIL'], :tz => TZInfo::Timezone.get('America/New_York')}

      template = File.read('./app/views/layout/maintenance.html.haml')
      result = Haml::Engine.new(template).render(Object.new, locals)

      put result, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  
    task :enable do
      run "rm #{shared_path}/system/maintenance.html"
    end
  end

  namespace :logs do
    desc "Watch the logs"
    task :production do
      run "cd #{current_path} && tail -f log/production.log"
    end
  end
  
end
